defmodule Parser do
  def parse(file) do
    File.read!(file)
    |> String.split([" ", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
