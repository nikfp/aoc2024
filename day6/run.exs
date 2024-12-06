IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "part 1 test")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "part 1 prod")

Parser.parse("./inputs/test.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "part 2 test")

Parser.parse("./inputs/prod.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "part 2 prod")

Mix.install([
  {:benchee, "~> 1.0", only: :dev}
])

Benchee.run(
  %{
    part1: fn ->
      Parser.parse("./inputs/prod.txt")
      |> Part1Solver.solve()
      |> IO.inspect(label: "part 1 prod")
    end,
    part2: fn ->
      Parser.parse("./inputs/prod.txt")
      |> Part2Solver.solve()
      |> IO.inspect(label: "part 2 prod")
    end
  },
  time: 10,
  memory_time: 5,
  reduction_time: 5
)
