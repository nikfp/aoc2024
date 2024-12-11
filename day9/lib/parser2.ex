defmodule Parser2 do
  def parse(file) do
    %{index_map: index_map} =
      File.read!(file)
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.take(19)
      |> build_data_maps(:filled, %{}, %{}, 0, 0)

    # index_map
    # |> Enum.sort_by(fn {k, _} -> k end)
  end

  defp build_data_maps([], _, index_map, free_block_map, start_index, _) do
    reversed_free_map =
      free_block_map
      |> Enum.map(fn {k, v} ->
        {k, v |> Enum.reverse()}
      end)
      |> Map.new()

    %{
      index_map: index_map,
      free_block_map: reversed_free_map,
      final_index: start_index - 1
    }
  end

  defp build_data_maps(inputs, :filled, index_map, free_block_map, start_index, file_number) do
    [current_count | rest_vals] = inputs

    # build the index map for the current count
    updated_index =
      fill_map(index_map, file_number, current_count, start_index, current_count, start_index)

    # recurse to :free mode with updated index map, 
    build_data_maps(
      rest_vals,
      :free,
      updated_index,
      free_block_map,
      start_index + current_count,
      file_number + 1
    )
  end

  defp build_data_maps(inputs, :free, index_map, free_block_map, start_index, file_number) do
    [current_count | rest_vals] = inputs

    updated_index =
      fill_map(index_map, ".", current_count, start_index, current_count, start_index)

    updated_free =
      Map.update(free_block_map, current_count, [start_index], fn list -> [start_index | list] end)

    build_data_maps(
      rest_vals,
      :filled,
      updated_index,
      updated_free,
      start_index + current_count,
      file_number
    )
  end

  defp fill_map(map, _fill_value, 0, _index, _block_size, _start_index) do
    map
  end

  defp fill_map(map, fill_value, count, index, block_size, start_index) do
    Map.put(map, index, %{value: fill_value, start_index: start_index, block_size: block_size})
    |> fill_map(fill_value, count - 1, index + 1, block_size, start_index)
  end
end
