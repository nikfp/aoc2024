defmodule Part1Solver do
  @doc """
  Input comes in as a map: 
  %{
    rules: %{ {"29", "13"} => true, ...}
    manuals: [
      ["75", "14", "10"],
      ...
      ]
  }
  """
  def solve(input) do
    %{rules: rules, manuals: manuals} = input

    manuals
    |> Enum.filter(fn manual ->
      manual_valid?(manual, rules)
    end)
    |> Enum.map(fn manual ->
      find_center_el(manual)
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp manual_valid?([_last_element], _rules) do
    true
  end

  defp manual_valid?([head | tail], rules) do
    Enum.all?(tail, fn el ->
      Map.has_key?(rules, {head, el})
    end)
    |> case do
      true -> manual_valid?(tail, rules)
      false -> false
    end
  end

  defp find_center_el(manual) do
    length = length(manual)

    [center | _tail] =
      Enum.drop(manual, trunc(length / 2))
    center
  end
end
