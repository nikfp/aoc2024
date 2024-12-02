defmodule Parser do
  def parse(file) do
    file
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(fn number -> String.to_integer(number) end)
    end)
  end
end
