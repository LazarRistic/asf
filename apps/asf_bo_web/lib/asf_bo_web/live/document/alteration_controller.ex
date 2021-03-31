defmodule AsfBOWeb.Live.Document.AlterationController do
  use AsfBOWeb, :live_view
  import Ecto.Changeset
  alias Asf.Documents
  alias Asf.Documents.Document

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       page_title: "Edit Document"
     )}
  end

  def handle_params(params, _url, socket) do
    changeset =
      params["uuid"]
      |> Documents.get_document!()
      |> Document.changeset(%{})

    {:noreply,
     assign(socket,
       changeset: changeset
     )}
  end

  def handle_event("save_document", %{"document" => document}, socket) do
    socket =
      socket.assigns.changeset
      |> apply_changes()
      |> Documents.update_document(document)
      |> case do
        {:ok, %Document{}} ->
          socket
          |> push_redirect(to: Routes.live_path(socket, AsfBOWeb.Live.Document.ListController))
          |> put_flash(:info, "Document updated successfully")

        {:error, %Ecto.Changeset{} = cs} ->
          assign(socket, changeset: cs)
      end

    {:noreply, socket}
  end
end
