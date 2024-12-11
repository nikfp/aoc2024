IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

Code.require_file("./lib/part_1_solver.ex", __DIR__)

alias Part1Solver

Parser.parse("./inputs/simple_test.txt")
|> Part1Solver.solve_with_index()
|> IO.inspect(label: "simple_test part 1")

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve_with_index()
|> IO.inspect(label: "test part 1")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve_with_index()
|> IO.inspect(label: "prod part 1")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve_with_reducer_only()
|> IO.inspect(label: "prod part 1")

Mix.install([
  {:benchee, "~> 1.0", only: :dev}
])

Benchee.run(
  %{
    part_1_index: fn ->
      Parser.parse("./inputs/prod.txt")
      |> Part1Solver.solve_with_index()
      |> IO.inspect(label: "prod part 1")
    end,
    part_1_reducer: fn ->
      Parser.parse("./inputs/prod.txt")
      |> Part1Solver.solve_with_reducer_only()
      |> IO.inspect(label: "prod part 1")
    end
  },
  time: 3,
  memory_time: 1,
  reduction_time: 1
)
