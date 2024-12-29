defmodule Parser do
  def parse(file) do
    lines =
      File.read!(file)
      |> String.split("\n", trim: true)

    upper_bound = length(lines)

    grid =
      lines
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, row}, acc ->
        String.split(line, "", trim: true)
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, col}, inner_acc ->
          Map.put(inner_acc, {row, col}, %{
            char: char,
            group: nil,
            boundaries: []
          })
        end)
      end)

    %{grid: grid, upper_bound: upper_bound}
  end
end
