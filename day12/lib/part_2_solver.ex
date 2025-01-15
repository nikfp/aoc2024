defmodule Part2Solver do
  def solve(input) do
    %{grid: grid, upper_bound: _upper_bound} = input

    # Take the grid keys
    {updated_grid, _} =
      Map.keys(grid)
      # Work through each one in a reducer
      |> Enum.reduce({grid, 0}, fn element, {new_grid, group_number} ->
        # Pull the location out of the grid
        location = new_grid |> Map.get(element)

        # If the location already has a group, continue
        if location.group != nil do
          {new_grid, group_number}

          # Otherwise execute a flood search on the current location
        else
          flood_search(new_grid, %{}, [element], group_number)
        end
      end)

    groups =
      updated_grid
      |> Enum.map(fn {_, v} -> v end)
      |> Enum.group_by(fn el -> el.group end)
      |> IO.inspect()
      |> Enum.map(fn {k, v} ->
        area = length(v)

        bounds =
          Enum.reduce(v, %{}, fn el, acc ->
            Map.merge(el.boundaries, acc)
          end)

        %{
          group: k,
          area: area,
          bounds: bounds
        }
      end)
      |> Enum.take(1)

    # |> Enum.sum()
  end

  # This is the base case. No edges are left, so the edge count
  # can be returned
  defp traverse_edges(
         _group_number,
         _master_grid,
         edge_map,
         edge_count
       )
       when map_size(edge_map) == 0 do
    %{edge_count: edge_count}
  end

  defp traverse_edges(group_number, master_grid, edge_map, edge_count) do
    # The idea here is that you first have to select any edge at random,
    # then you have to identify the first location adjacent to the edge
    # that is in the group. That becomes your starting point. 
    # TODO - create a function to make this easier
    # The relationship between the edge and the starting point dictates which
    # direction to start moving. 

    # The traversal of one loop of edges is complete when the starting position 
    # is reached and the traversal is going in the same direction

    # An edge is counted when a turn is made in the traversal

    # A map needs to be kept of visited edges, At the end of a traversal loop, 
    # the difference between the supplied edge map and the visited edges 
    # will be the new map supplied to the recursion. This will catch 
    # situations where edges are seen for multiple sections
  end

  # work through all locations
  # when you reach a location that doesn't have a group,
  # assign the next group number to it
  # flood fill search all connected elements of the same type
  # in that group. 

  defp flood_search(grid, _evaluated_locs, [], group_number) do
    {grid, group_number + 1}
  end

  defp flood_search(grid, evaluated_locs, lookup_locs, group_number) do
    # Get the first element of the lookup list
    [{row, col} | rest_locs] = lookup_locs

    # Get the character we're evaluating against
    %{char: location_char} = location_info = Map.get(grid, {row, col})

    # Get surrounding locations as a list 
    {updated_lookup_locs, updated_location_details} =
      [
        {row, col - 1},
        {row, col + 1},
        {row - 1, col},
        {row + 1, col}
      ]

      # Iterate over locations
      |> Enum.reduce({rest_locs, location_info}, fn new_loc, {other_locs, details} ->
        # If the new location has been evaluated, ignore it and 
        # move along to the next locationp
        O

        if Map.has_key?(evaluated_locs, new_loc) do
          {other_locs, details}
        else
          # If the now location has not been evaluated, we need it's character
          %{char: new_loc_char} = Map.get(grid, new_loc, %{char: "AA"})

          # If the character matches, add the new location to the list of
          # Things to evaluate
          if new_loc_char == location_char do
            {[new_loc | other_locs], details}
          else
            # if the character doesn't match, 
            # add the new location to the list of locations that are boundaries
            updated_details =
              Map.update(details, :boundaries, %{}, fn map -> Map.put(map, new_loc, true) end)

            {other_locs, updated_details}
          end
        end
      end)

    location_with_group =
      updated_location_details
      |> Map.put(:group, group_number)

    updated_grid =
      grid
      |> Map.put({row, col}, location_with_group)

    updated_eval_locations =
      evaluated_locs
      |> Map.put({row, col}, true)

    flood_search(updated_grid, updated_eval_locations, updated_lookup_locs, group_number)
  end
end
