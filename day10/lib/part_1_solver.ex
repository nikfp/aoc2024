defmodule Part1Solver do
  def solve(input) do
    %{grid: grid, starts: starts, upper_bound: upper_bound} = input

    starts
    # |> Enum.drop(3)
    # |> Enum.take(1)
    |> Enum.flat_map(fn start ->
      look_ahead(grid, 1, start, %{})
    end)
    |> Enum.count()
  end

  # General idea here is starting at a start point, 
  # gather all locations where the value is one number 
  # up. For each of those locations, recurse up one digit
  # continue until the location is 9
  # when you get to the top, return something consistent

  defp look_ahead(grid, 10, pos, visited) do
    [pos]
  end

  defp look_ahead(grid, height, {row, col}, visited) do

    [
      {row - 1, col},
      {row + 1, col},
      {row, col - 1},
      {row, col + 1}
    ]
    |> Enum.filter(fn loc ->
      Map.get(grid, loc, 0) == height 
    end)
    |> IO.inspect()
    |> Enum.flat_map(fn loc ->
      look_ahead(grid, height + 1, loc, visited)
    end)
  end
end
