defmodule Parser do
  def parse(file) do
    lines =
      file
      |> File.read!()
      |> String.trim()
      |> String.split("\n")

    upper_bound = length(lines)

    antennae_map =
      lines
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, row}, acc ->
        String.split(line, "", trim: true)
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, col}, inner_acc ->
          case char do
            "." -> inner_acc
            _ -> inner_acc |> Map.update(char, [{row, col}], fn list -> [{row, col} | list] end)
          end
        end)
      end)

    %{
      upper_bound: upper_bound,
      antennae_map: antennae_map
    }
  end
end
