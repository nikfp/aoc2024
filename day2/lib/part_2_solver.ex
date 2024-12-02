defmodule Part2Solver do
  def solve(lines) do
    lines
    |> Stream.map(&process_line/1)
    |> Stream.filter(& &1)
    |> Enum.count()
  end

  defp process_line(line) do
    if is_safe?(line) do
      true
    else
      check_variant(line, 0)
    end
  end

  defp check_variant(line, pos) do
    if pos >= length(line) do
      false
    else
      safe = List.delete_at(line, pos) |> is_safe?()

      case safe do
        true -> true
        false -> check_variant(line, pos + 1)
      end
    end
  end

  defp is_safe?(line) do
    case is_ascending?(line) do
      true -> {:asc, line} |> is_gradual?()
      false -> {:desc, line} |> is_gradual?()
    end
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

  defp is_ascending?([_]) do
    false
  end
end
