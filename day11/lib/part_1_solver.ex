defmodule Part1Solver do
  def solve(input, counter) do
    input
  end

  defp check_number(_, 0) do
    Counter.increment()
  end

  defp check_number(0, counter) do
    check_number(1, counter - 1)
  end

  defp check_number(number, counter) do
    log_10 = :math.log10(number) |> floor()

    if rem(log_10, 2) == 0 do
      # need logic to split number in two and recurse down each new number 
    else
      check_number(number * 2024, counter - 1)
    end
  end
end

defmodule Counter do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.update(__MODULE__, &(&1 + 1))
  end
end
