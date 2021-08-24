defmodule AsfFHWeb.Assets do
  @moduledoc """
  The Assets context.
  """

  def insert_avatar(meta, entry) do
    dest = Path.join("apps/asf_fh_web/priv/static/uploads", _filename(entry))
    File.cp!(meta.path, dest)
    "/uploads/#{_filename(entry)}"
  end

  defp _filename(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    "#{entry.uuid}.#{ext}"
  end
end
