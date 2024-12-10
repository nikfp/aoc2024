defmodule Part2Solver do
  def solve(input) do
    %{antennae_map: antennae_map, upper_bound: upper_bound} = input

    Enum.reduce(antennae_map, %{}, fn {_key, [start | other_locs]}, acc ->
      process_locations(start, other_locs, acc, upper_bound)
    end)
    |> Enum.count()
  end

  def process_locations(_starting_point, [], result_map, _upper_bound) do
    result_map
  end

  def process_locations(starting_point, other_locations, result_map, upper_bound) do
    antinodes_for_start =
      Enum.reduce(other_locations, result_map, fn loc, map ->
        locate_antinodes(map, starting_point, loc, upper_bound)
      end)

    [new_start | new_locations] = other_locations

    process_locations(new_start, new_locations, antinodes_for_start, upper_bound)
  end

  def locate_antinodes(collector, {row_a, col_a}, {row_b, col_b}, upper_bound) do
    row_change = row_a - row_b
    col_change = col_a - col_b

    locate_backwards(collector, {row_a, col_a}, row_change, col_change, upper_bound)
    |> locate_forwards({row_a, col_a}, row_change, col_change, upper_bound)
  end

  defp locate_forwards(collector, {start_row, start_col}, row_change, col_change, upper_bound) do
    if start_row >= upper_bound || start_row < 0 || start_col >= upper_bound || start_col < 0 do
      collector
    else
      locate_forwards(
        collector |> Map.put({start_row, start_col}, true),
        {start_row + row_change, start_col + col_change},
        row_change,
        col_change,
        upper_bound
      )
    end
  end

  defp locate_backwards(collector, {start_row, start_col}, row_change, col_change, upper_bound) do
    if start_row >= upper_bound || start_row < 0 || start_col >= upper_bound || start_col < 0 do
      collector
    else
      locate_backwards(
        collector |> Map.put({start_row, start_col}, true),
        {start_row - row_change, start_col - col_change},
        row_change,
        col_change,
        upper_bound
      )
    end
  end
end
