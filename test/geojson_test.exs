defmodule GeoJSONTest do
  use ExUnit.Case
  doctest GeoJSON

  test "linestring formatter works" do
    coords = %Coordinates{coordinates: [
        ['-106.3007900', '39.3604100'], 
        ['-106.3007500', '39.3604070'], 
        ['-106.3007050', '39.3604070'], 
        ['-106.3006830', '39.3604070'], 
        ['-106.3004510', '39.3604140']
      ]}

    assert GeoJSON.formatted(coords) == %{coordinates: [['-106.3007900', '39.3604100'], ['-106.3007500', '39.3604070'], ['-106.3007050', '39.3604070'], ['-106.3006830', '39.3604070'], ['-106.3004510', '39.3604140']], type: "LineString"}
  end
end

