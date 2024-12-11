defmodule Parser do
  def parse(file) do
    lines =
      File.read!(file)
      |> String.trim()
      |> String.split("\n", trim: true)
      |> Enum.with_index()

    upper_bound = length(lines)

    lines
    |> Enum.reduce(%{grid: %{}, starts: []}, fn {line, row}, acc ->
      line
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {el, col}, inner_acc ->
        %{grid: grid, starts: starts} = inner_acc

        case String.to_integer(el) do
          0 ->
            %{
              grid: Map.put(grid, {row, col}, 0),
              starts: [{row, col} | starts]
            }

          val ->
            %{
              grid: Map.put(grid, {row, col}, val),
              starts: starts
            }
        end
      end)
    end)
    |> Map.put(:upper_bound, upper_bound)
  end
end
