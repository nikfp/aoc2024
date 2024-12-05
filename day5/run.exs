IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)
alias Part2Solver

alias Parser
alias Part1Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "prod part 1")

Parser.parse("./inputs/test.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "test part 2")

Parser.parse("./inputs/prod.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "prod part 2")

Code.require_file("./lib/waseem_solvers.ex", __DIR__)

alias Aoc2024Elixir.D05

Mix.install([
  {:benchee, "~> 1.0", only: :dev}
])

Benchee.run(%{
  nik_1: fn ->
    Parser.parse("./inputs/prod.txt")
    |> Part1Solver.solve()
    |> IO.inspect(label: "prod part 1")
  end,
  nik_2: fn ->
    Parser.parse("./inputs/prod.txt")
    |> Part2Solver.solve()
    |> IO.inspect(label: "prod part 2")
  end,
  waseem_1: fn ->
    D05.run1("./inputs/prod.txt")
  end,
  waseem_2: fn ->
    D05.run2("./inputs/prod.txt")
  end
}, time: 2, parallel: 2, memory_time: 1, reduction_time: 1)
