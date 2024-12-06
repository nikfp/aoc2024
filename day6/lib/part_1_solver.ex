defmodule Part1Solver do
  @directions %{
    up: :right,
    right: :down,
    down: :left,
    left: :up
  }

  @doc """
  Expects an inbound data structure as follows:
  %{
    obstacles: map of locations
    grid_max_index: integer
    starting_loc: {row, col} 
  }
  """
  def solve(input) do
    %{
      grid_max_index: max_index,
      obstacles: obstacles,
      starting_loc: starting_loc
    } = input

    advance(
      :up,
      starting_loc,
      obstacles,
      max_index,
      %{starting_loc => true}
    )
    |> Enum.count()
  end

  @doc """
  ## Takes in the following args: 
  - direction - current direction of travel
  - current_loc - current location
  - obstacles - map of obstacle locations as %{{row, col} => true}
  - max_index - maximum bound of grid
  - visited - map of locations already visited

  ## Behaves as follows
  - Check the next location based on direction of travel
  - If next location is out of bounds, return the visited map
  - If next location is an obstacle, change direction and recurse
  - Otherwise add current loc to visited and recurse to next location
  """
  def advance(direction, current_loc, obstacles, max_index, visited) do
    next_loc = get_next_loc(direction, current_loc)

    case next_loc do
      {row, _} when row < 0 or row > max_index ->
        visited

      {_, col} when col < 0 or col > max_index ->
        visited

      location when is_map_key(obstacles, location) ->
        Map.get(@directions, direction)
        |> advance(current_loc, obstacles, max_index, visited)

      location ->
        advance(
          direction,
          location,
          obstacles,
          max_index,
          Map.put(visited, location, true)
        )
    end
  end

  defp get_next_loc(:up, {row, col}) do
    {row - 1, col}
  end

  defp get_next_loc(:right, {row, col}) do
    {row, col + 1}
  end

  defp get_next_loc(:down, {row, col}) do
    {row + 1, col}
  end

  defp get_next_loc(:left, {row, col}) do
    {row, col - 1}
  end
end
