defmodule Parser do
  def parse(file) do
    File.read!(file)
  end
end
