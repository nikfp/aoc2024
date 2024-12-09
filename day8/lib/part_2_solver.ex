defmodule Part2Solver do
  def solve(input) do
    %{antennae_map: antennae_map, upper_bound: upper_bound} = input

    Enum.reduce(antennae_map, %{}, fn {_key, [start | other_locs]}, acc ->
      process_locations(start, other_locs, acc)
    end)
    # |> Enum.filter(fn {{row, col}, _v} ->
    #   row >= 0 && row < upper_bound &&
    #     col >= 0 && col < upper_bound
    # end)
    # |> Enum.count()
  end

  def process_locations(_starting_point, [], result_map) do
    result_map
  end

  def process_locations(starting_point, other_locations, result_map) do
    antinodes_for_start =
      Enum.reduce(other_locations, result_map, fn loc, map ->
        map
        |> Map.put(locate_antinode(starting_point, loc), true)
        |> Map.put(locate_antinode(loc, starting_point), true)
      end)

    [new_start | new_locations] = other_locations

    process_locations(new_start, new_locations, antinodes_for_start)
  end

  def locate_antinode({row_a, col_a}, {row_b, col_b}) do
    {row_a + (row_a - row_b), col_a + (col_a - col_b)}
  end
end
