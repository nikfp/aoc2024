defmodule Part1Solver do
  def solve(input, count_value) do
    Counter.start_link(0)

    {counter, _} =
      input
      |> Enum.reduce({0, %{}}, fn el, {counter, cache} ->
        {number, new_cache} = check_number(el, count_value, cache)
        {counter + number, new_cache}
      end)

    counter
  end

  # Check if the number and counter combo exists in the cache
  # If it does, return it with the cache
  # If it does NOT, do the calculation on the map and return the map with
  # the cached value added to it. 

  defp check_number(number, 0, cache) do
    Map.get(cache, {number, 0})
    |> case do
      nil ->
        {1, Map.put(cache, {number, 0}, 1)}

      val ->
        {val, cache}
    end
  end

  defp check_number(0, counter, cache) do
    Map.get(cache, {0, counter})
    |> case do
      nil ->
        check_number(1, counter - 1, cache)

      val ->
        {val, cache}
    end
  end

  defp check_number(number, counter, cache) do
    Map.get(cache, {number, counter})
    |> case do
      nil ->
        log_10 = :math.log10(number) |> floor() |> Kernel.+(1)

        if rem(log_10, 2) == 0 do
          midpoint = log_10 / 2

          divisor = trunc(:math.pow(10, midpoint))

          {num_1, cache_1} =
            div(number, divisor)
            |> check_number(counter - 1, cache)

          {num_2, cache_2} =
            rem(number, divisor)
            |> check_number(counter - 1, cache_1)

          {num_1 + num_2, Map.put(cache_2, {number, counter}, num_1 + num_2)}
        else
          check_number(number * 2024, counter - 1, cache)
        end

      value ->
        {value, cache}
    end
  end

  # defp get_from_cache(cache, number, counter) do
  #   Map.get_and_update(cache, {number, counter}, fn val ->
  #     case val do
  #       nil ->
  #         number = check_number(number, integer)
  #         {check_number(number, counter, cache)}
  #
  #       val ->
  #         {val, cache}
  #     end
  #   end)
  # end
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

  def reset do
    Agent.update(__MODULE__, fn _ -> 0 end)
  end
end