defmodule TrackstarTest do
  use ExUnit.Case
  doctest Trackstar

  test "run returns coordinates" do
    expected_coords = [[-106.3007900, 39.3604100],
                      [-106.3007500, 39.3604070],
                      [-106.3007050, 39.3604070],
                      [-106.3006830, 39.3604070],
                      [-106.3004510, 39.3604140]]

    path = "test/fixtures/small_w_hr.gpx"
    {:ok, coords, _} = Trackstar.run(path)

    assert coords.coordinates == expected_coords
  end
end
