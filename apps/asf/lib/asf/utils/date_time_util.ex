defmodule Asf.Utils.DateTimeUtil do
  def utc_to_local(%NaiveDateTime{} = utc) do
    erlang_datetime = {{utc.year, utc.month, utc.day}, {utc.hour, utc.minute, utc.second}}

    {{year, month, day}, {hour, minute, second}} =
      :calendar.universal_time_to_local_time(erlang_datetime)

    {:ok, ndt} = NaiveDateTime.new(year, month, day, hour, minute, second)
    ndt
  end
end
