defmodule Part2Solver do
  def solve(input) do
    %{grid: grid, starts: starts} = input

    starts
    |> Enum.map(fn start ->
      look_ahead(grid, 0, start, %{})
      |> Enum.map(fn {key, _} -> key end)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  # General idea here is starting at a start point, 
  # gather all locations where the value is one number 
  # up. For each of those locations, recurse up one digit
  # continue until the location is 9
  # if location reaches 9, mark location in map of reached elements
  # if location doesn't get to 9, return visited map without marking top element 
  # when you get to the top, return something consistent
  defp look_ahead(_grid, 9, location, visited) do
    Map.put(visited, location, true)
  end

  defp look_ahead(grid, height, {row, col}, visited) do
    [
      {row, col + 1},
      {row, col - 1},
      {row + 1, col},
      {row - 1, col}
    ]
    |> Enum.filter(fn el -> Map.get(grid, el, 0) == height + 1 end)
    |> Enum.flat_map(fn new_loc ->
      look_ahead(grid, height + 1, new_loc, visited)
    end)
  end
end
