defmodule TrackstarTest do
  use ExUnit.Case
  doctest Trackstar

  test "run returns coordinates" do
    path = "test/fixtures/small_w_hr.gpx"
    coordinates = Trackstar.run(path)

    IO.puts "Coordinates: \"#{coordinates}\""
    assert is_list(coordinates)
  end
end
