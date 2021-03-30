defmodule Asf.Documents.Document do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, Ecto.UUID, []}
  schema "documents" do
    field :content, :string
    field :sub_title, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:uuid, :title, :sub_title, :content])
    |> validate_required([:uuid, :title, :content])
  end
end
