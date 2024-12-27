defmodule Part1Solver do
  def solve(input, count_value) do
    Counter.start_link(0)

    input
    |> Enum.each(fn el ->
      check_number(el, count_value)
    end)

    Counter.value()
  end

  defp check_number(_, 0) do
    Counter.increment()
  end

  defp check_number(0, counter) do
    check_number(1, counter - 1)
  end

  defp check_number(number, counter) do
    log_10 = :math.log10(number) |> floor() |> Kernel.+(1)

    if rem(log_10, 2) == 0 do
      midpoint = log_10 / 2

      divisor = trunc(:math.pow(10, midpoint))

      div(number, divisor)
      |> check_number(counter - 1)

      rem(number, divisor)
      |> check_number(counter - 1)
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
