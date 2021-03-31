defmodule AsfBOWeb.Live.Document.CreationController do
  use AsfBOWeb, :live_view
  alias Asf.Documents
  alias Asf.Documents.Document

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "New Document"
     )}
  end

  def handle_params(_params, _url, socket) do
    changeset = Document.changeset(%Document{}, %{})

    {:noreply,
     assign(socket,
       changeset: changeset
     )}
  end

  def handle_event("save_document", %{"document" => document}, socket) do
    socket =
      case Documents.create_document(document) do
        {:ok, %Document{}} ->
          socket
          |> push_redirect(to: Routes.live_path(socket, AsfBOWeb.Live.Document.ListController))
          |> put_flash(:info, "Document created successfully")

        {:error, %Ecto.Changeset{} = cs} ->
          assign(socket, changeset: cs)
      end

    {:noreply, socket}
  end
end
