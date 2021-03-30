defmodule AsfWeb.Live.Documents do
  use AsfWeb, :live_view
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
    documents = Documents.list_documents
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

  def handle_event("save_document", %{"document" => document}, socket) do
    socket =
      case Documents.create_document(document) do
        {:ok, %Document{}} ->
          IO.inspect("USPEO JE DA NAPRAVI")
          assign(socket,
            documents: Documents.list_documents,
            changeset: Document.changeset(%Document{}, %{})
          )

        {:error, %Ecto.Changeset{} = cs} ->
          IO.inspect(cs, label: "NIJE USPEO DA NAPRAVI", limit: :infinity, pretty: true)
          assign(socket, changeset: cs)
      end

    {:noreply, socket}
  end
end
