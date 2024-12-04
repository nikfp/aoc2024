defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row_index}, acc -> 
      String.split(line, "", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, col_index}, acc -> 
        Map.put(acc, {row_index, col_index}, char)
      end)
    end)
  end
end
