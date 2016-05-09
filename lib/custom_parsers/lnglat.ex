defmodule LngLat do
  def lnglat(attributes) do
    [pull_lng(attributes), pull_lat(attributes)]
    |> parse_lnglat
  end

  defp pull_lat({_, 'lat', _, _, lat}), do: lat
  defp pull_lat({_, 'lon', _, _, _lon}), do: nil
  defp pull_lat(attributes) when is_list(attributes) do
    attributes |> Enum.map(&(pull_lat(&1)))
  end

  defp pull_lng({_, 'lon', _, _, lon}), do: lon
  defp pull_lng({_, 'lat', _, _, _lat}), do: nil
  defp pull_lng(attributes) when is_list(attributes) do
    attributes |> Enum.map(&(pull_lng(&1)))
  end

  defp parse_lnglat([[lng, nil], [nil, lat]]),
    do: [List.to_float(lng), List.to_float(lat)]
end
