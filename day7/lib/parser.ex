defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [target | digits] =
        line
        |> String.split([": ", " "])
        |> Enum.map(&String.to_integer/1)

      %{target: target, digits: digits}
    end)
  end
end
