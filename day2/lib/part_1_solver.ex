defmodule Part1Solver do
  def solve(lines) do
    lines
    |> Stream.map(fn line ->
      case is_ascending?(line) do
        true -> {:asc, line}
        false -> {:desc, line}
      end
    end)
    |> Stream.map(&is_gradual?/1)
    |> Stream.filter(& &1) 
    |> Enum.count()
  end

  defp is_gradual?({:asc, [_]}) do
    true
  end

  defp is_gradual?({:asc, [left | [right | rest]]}) do
    case gradual_step_up?(left, right) do
      false -> false
      true -> is_gradual?({:asc, [right | rest]})
    end
  end

  defp is_gradual?({:desc, [_]}) do
    true
  end

  defp is_gradual?({:desc, [left | [right | rest]]}) do
    case gradual_step_down?(left, right) do
      false -> false
      true -> is_gradual?({:desc, [right | rest]})
    end
  end

  defp gradual_step_up?(left, right) do
    right <= left + 3 && right > left
  end

  defp gradual_step_down?(left, right) do
    left > right && right >= left - 3
  end

  defp is_ascending?([a | [b | rest]]) do
    case b do
      b when b > a -> true
      b when b < a -> false
      b -> is_ascending?([b | rest])
    end
  end
end
