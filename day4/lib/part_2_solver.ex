defmodule Part2Solver do
  def solve(input) do
    input
    |> Enum.filter(fn {_coords, char} ->
      case char do
        "A" -> true
        _ -> false
      end
    end)
    |> Enum.map(fn el -> is_it_xmas?(el, input) end)
    |> Enum.filter(fn el -> el end)
    |> Enum.count()
  end

  # We know A is in the middle but does X mark the spot
  defp is_it_xmas?({{row, col}, _}, overall_map) do
    [
      mas_right_slash?(row, col, overall_map),
      mas_left_slash?(row, col, overall_map)
    ]
    |> Enum.all?()
  end

  defp mas_left_slash?(row, col, overall_map) do
    {
      Map.get(overall_map, {row - 1, col + 1}, ""),
      Map.get(overall_map, {row + 1, col - 1}, "")
    }
    |> case do
      {"M", "S"} -> true
      {"S", "M"} -> true
      _ -> false
    end
  end

  defp mas_right_slash?(row, col, overall_map) do
    {
      Map.get(overall_map, {row - 1, col - 1}, ""),
      Map.get(overall_map, {row + 1, col + 1}, "")
    }
    |> case do
      {"M", "S"} -> true
      {"S", "M"} -> true
      _ -> false
    end
  end
end
