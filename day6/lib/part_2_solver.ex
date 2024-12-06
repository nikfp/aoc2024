defmodule Part2Solver do
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

    # iterate all rows into either `false` or a task
    Enum.flat_map(0..max_index, fn row ->
      # iterate all columns
      Enum.map(0..max_index, fn col ->
        # no point in putting an obstacle on an obstacle
        if Map.has_key?(obstacles, {row, col}) do
          # Task.async(fn -> false end)
          false
        else
          Task.async(fn ->
            # Test each permutation of dropping an obstacle
            advance(
              :up,
              starting_loc,
              obstacles |> Map.put({row, col}, true),
              max_index,
              %{}
            )
          end)
        end
      end)
    end)
    # filter out false
    |> Enum.filter(fn el -> el end)
    # await the tasks
    |> Enum.map(fn task -> Task.await(task) end)
    # filter for locations where task returned true
    # indicates that dropping 1 obstacle causes cycle
    |> Enum.filter(fn el -> el != false end)
    # add them up
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
  - Check if current location and direction has been seen, 
    - return true if so, otherwise continue below
  - Check the next location based on direction of travel
  - If next location is out of bounds, return false 
  - If next location is an obstacle, change direction and recurse
  - Otherwise add current loc to visited and recurse to next location
  """
  def advance(direction, {row, col} = current_loc, obstacles, max_index, visited) do
    # let's check if the guard has been here or not
    # Accounts for direction of travel as well
    if Map.has_key?(visited, {row, col, direction}) do
      true
    else
      # If you get here, the guard hasn't hit the current location
      # moving the same direction of travel
      next_loc = get_next_loc(direction, current_loc)

      case next_loc do
        # Guard ran off board, not a match
        {row, _} when row < 0 or row > max_index ->
          false

        # Guard ran off board, not a match
        {_, col} when col < 0 or col > max_index ->
          false

        # Guard hit an obstacle, turn and try again
        location when is_map_key(obstacles, location) ->
          Map.get(@directions, direction)
          |> advance(current_loc, obstacles, max_index, visited)

        location ->
          advance(
            direction,
            location,
            obstacles,
            max_index,
            Map.put(visited, {row, col, direction}, true)
          )
      end
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
