defmodule Parser do
  @doc """
  A data structure is needed for this exercise, as follows:
  %{
    obstacles: map of locations
    grid_max_index: integer
    starting_loc: {row, col} 
  }
  """
  def parse(file) do
    read_file =
      File.read!(file)
      |> String.trim()
      |> String.split("\n")

    grid_max_index = length(read_file) - 1

    read_file
    |> Enum.with_index()
    # Build up the map this function returns
    |> Enum.reduce(%{}, fn {line, row}, acc ->
      String.split(line, "", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, col}, inner_acc ->
        case char do
          "#" ->
            Map.update(inner_acc, :obstacles, %{{row, col} => true}, fn map ->
              Map.put(map, {row, col}, true)
            end)

          "^" ->
            Map.put(inner_acc, :starting_loc, {row, col})

          _ ->
            inner_acc
        end
      end)
    end)
    |> Map.put(:grid_max_index, grid_max_index)
  end
end
