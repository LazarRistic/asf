defmodule AsfBOWeb.Live.Document.ListController do
  use AsfBOWeb, :live_view
  import Ecto.Changeset
  alias Asf.Documents
  alias Asf.Documents.Document

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       expanded_docs: [],
       page_title: "Documents"
     )}
  end

  def handle_params(_params, _url, socket) do
    documents = Documents.list_documents()
    changeset = Document.changeset(%Document{}, %{})

    {:noreply,
     assign(socket,
       documents: documents,
       changeset: changeset
     )}
  end

  def handle_event("toggle_document", %{"id" => id}, socket) do
    expanded_docs = socket.assigns.expanded_docs

    expanded_docs =
      if id in expanded_docs do
        List.delete(expanded_docs, id)
      else
        [id | expanded_docs]
      end

    {:noreply,
     assign(socket,
       expanded_docs: expanded_docs
     )}
  end

  def handle_event("remove_document", %{"id" => id}, socket) do
    socket =
      id
      |> Documents.get_document!()
      |> Documents.delete_document()
      |> case do
        {:ok, _} ->
          socket
          |> push_patch(to: Routes.live_path(socket, AsfBOWeb.Live.Document.ListController))
          |> put_flash(:info, "Document deleted successfully")

        {:error, changeset} ->
          errors =
            traverse_errors(changeset, fn {msg, opts} ->
              Enum.reduce(opts, msg, fn {key, value}, acc ->
                String.replace(acc, "%{#{key}}", to_string(value))
              end)
            end)

          put_flash(socket, :error, "#{inspect(errors)}")
      end

    {:noreply, socket}
  end
end
