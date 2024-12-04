defmodule Part1Solver do
  # Input comes in from parser as a map of {row, col} => char, 
  # Each tuple key represents a position
  def solve(input) do
      input
      |> Enum.filter(fn {_coords, char} ->
        case char do
          "X" -> true
          _ -> false
        end
      end)
      |> Enum.map(fn el -> count_christmas(el, input) end)
      |> Enum.sum()
  end

  # We know it starts with X, but how many times does it do MAS? 
  defp count_christmas({{row, col}, _}, overall_map) do
    [
      mas_leftwise?(row, col, overall_map),
      mas_rightwise?(row, col, overall_map),
      mas_upwise?(row, col, overall_map),
      mas_downwise?(row, col, overall_map),
      mas_nw_wise?(row, col, overall_map),
      mas_ne_wise?(row, col, overall_map),
      mas_sw_wise?(row, col, overall_map),
      mas_se_wise?(row, col, overall_map)
    ]
    |> Enum.filter(fn el -> el end)
    |> Enum.count()
  end

  defp mas_leftwise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row, col - 1}, ""),
      Map.get(overall_map, {row, col - 2}, ""),
      Map.get(overall_map, {row, col - 3}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_rightwise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row, col + 1}, ""),
      Map.get(overall_map, {row, col + 2}, ""),
      Map.get(overall_map, {row, col + 3}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_downwise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row + 1, col}, ""),
      Map.get(overall_map, {row + 2, col}, ""),
      Map.get(overall_map, {row + 3, col}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_upwise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row - 1, col}, ""),
      Map.get(overall_map, {row - 2, col}, ""),
      Map.get(overall_map, {row - 3, col}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_se_wise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row + 1, col + 1}, ""),
      Map.get(overall_map, {row + 2, col + 2}, ""),
      Map.get(overall_map, {row + 3, col + 3}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_sw_wise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row + 1, col - 1}, ""),
      Map.get(overall_map, {row + 2, col - 2}, ""),
      Map.get(overall_map, {row + 3, col - 3}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_nw_wise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row - 1, col - 1}, ""),
      Map.get(overall_map, {row - 2, col - 2}, ""),
      Map.get(overall_map, {row - 3, col - 3}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end

  defp mas_ne_wise?(row, col, overall_map) do
    {
      Map.get(overall_map, {row - 1, col + 1}, ""),
      Map.get(overall_map, {row - 2, col + 2}, ""),
      Map.get(overall_map, {row - 3, col + 3}, "")
    }
    |> case do
      {"M", "A", "S"} -> true
      _ -> false
    end
  end
end
