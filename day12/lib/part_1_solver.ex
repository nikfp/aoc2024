defmodule Part1Solver do
  def solve(input) do
    %{grid: grid, upper_bound: _upper_bound} = input

    # {updated_grid, _} =

    # Take the grid keys
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
    [
      {row, col - 1}, 
      {row, col + 1},
      {row - 1, col}, 
      {row + 1, col}
    ]
    # Iterate over locations
    |> Enum.reduce({grid}, fn new_loc, {reducing_grid} -> 
      # If the new location has been evaluated, ignore it and 
      # move along to the next location
      if Map.has_key?(evaluated_locs, new_loc) do
        {reducing_grid}

      else
        #If the now location has not been evaluated, we need it's character
        %{char: new_loc_char} = Map.get(reducing_grid)
      end
    end)
    # 

    flood_search(grid, evaluated_locs, [], group_number)
  end

  # once groups are numbered, areas are the number of elements
  # in the group. 

  # maybe perimeter of a group is everywhere it touches another group,
  # plus anywhere it touches a boundary. Can this be calculated during
  # the flood fill? o

  # FLOOD FILL - 
  # need a list of locations to evaluate
  # need a map of evaluated locations
  # get head of lookup list
  # - look up, left, down, right
  # - if found location is same character, 
  #   and not in the map of processes locations, 
  #   add to lookup list
  # - if found location is another character, add to boundary list for location
  # - once the current location is done evaluating, add to map of evaluated locations
  # - recurse on recurse by passing grid, list of to-evaluate locations,
  #   and list of seen locations
  # - Once the lookup list is empty, return the updated grid

  # FINAL CALC
  # process all locations to groupings, 
  # count members of group for area, 
  # count perimeter locations noted for each location,
  # multiply, then sum the total of all
end
