defmodule Parser do
  def parse(path) do
    File.read!(path)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [left, right] = String.split(line, "   ")

      {String.to_integer(left), String.to_integer(right)}
    end)
  end

  def build_lists(input_list) do
    Enum.reduce(input_list, {[], []}, fn {left, right}, {left_list, right_list} -> 
      {[left | left_list], [right | right_list]}
    end)
  end

  def sort_lists({left, right}) do
    {Enum.sort(left), Enum.sort(right)}
  end
end
