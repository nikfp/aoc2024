defmodule Parser do
  def parse(file) do
    [rules, manuals] =
      File.read!(file)
      |> String.trim()
      |> String.split("\n\n")

    %{
      rules: parse_rules(rules),
      manuals: parse_manuals(manuals)
    }
  end

  defp parse_rules(rules) do
    rules
    |> String.split("\n")
    |> Stream.map(&String.split(&1, "|"))
    |> Enum.reduce(%{}, fn [earlier, later], acc ->
      Map.put(acc, {earlier, later}, true)
    end)
  end

  defp parse_manuals(manuals) do
    manuals
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ","))
  end
end
