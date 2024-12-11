IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Part1Solver

# Parser.parse("./inputs/simple_test.txt")
# |> Parser.build_loc_list()
# |> Part1Solver.solve_with_index()
# |> IO.inspect(label: "simple_test part 1")

# Parser.parse("./inputs/test.txt")
# |> Parser.build_loc_list()
# |> Part1Solver.solve_with_index()
# |> IO.inspect(label: "test part 1")
#
# Parser.parse("./inputs/prod.txt")
# |> Parser.build_loc_list()
# |> Part1Solver.solve_with_index()
# |> IO.inspect(label: "prod part 1")
#
# Parser.parse("./inputs/prod.txt")
# |> Parser.build_loc_list()
# |> Part1Solver.solve_with_reducer_only()
# |> IO.inspect(label: "prod part 1")

Code.require_file("./lib/parser2.ex", __DIR__)

alias Parser2

Parser2.parse("./inputs/test.txt")
|> IO.inspect(label: "test part 2", charlists: :as_integers)

Mix.install([
  {:benchee, "~> 1.0", only: :dev}
])

#   %{
#     part_1_index: fn ->
#       Parser.parse("./inputs/prod.txt")
#       |> Parser.build_loc_list()
#       |> Part1Solver.solve_with_index()
#       |> IO.inspect(label: "prod part 1")
#     end,
#     part_1_reducer: fn ->
#       Parser.parse("./inputs/prod.txt")
#       |> Parser.build_loc_list()
#       |> Part1Solver.solve_with_reducer_only()
#       |> IO.inspect(label: "prod part 1")
#     end
#   },
#   time: 3,
#   memory_time: 1,
#   reduction_time: 1
# )
