IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

Code.require_file("./lib/part_1_solver.ex", __DIR__)

# Part 1
alias Part1Solver

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1", charlists: :as_integers)

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "prod part 1", charlists: :as_integers)

Code.require_file("./lib/part_2_solver.ex", __DIR__)

# Part 2
alias Part2Solver

Parser.parse("./inputs/test.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "test part 2", charlists: :as_integers)

Parser.parse("./inputs/prod.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "prod part 2", charlists: :as_integers)

Mix.install([
  {:nimble_parsec, "~> 1.4"},
  {:benchee, "~> 1.0", only: :dev}
])

Code.require_file("./lib/makaze.exs", __DIR__)

alias MakazeSolver

File.read!("./inputs/prod.txt")
|> MakazeSolver.parse()
|> MakazeSolver.sum([&MakazeSolver.unconcat/2, &MakazeSolver.divide/2, &-/2])
|> IO.inspect(label: "Part 2 Real")

Benchee.run(
  %{
    nik_1: fn ->
      Parser.parse("./inputs/prod.txt")
      |> Part1Solver.solve()
      |> IO.inspect(label: "prod part 1", charlists: :as_integers)
    end,
    makaze_1: fn ->
      File.read!("./inputs/prod.txt")
      |> MakazeSolver.parse()
      |> MakazeSolver.sum([&MakazeSolver.divide/2, &-/2])
      |> IO.inspect(label: "Part 1 Real")
    end,
    nik_2: fn ->
      Parser.parse("./inputs/prod.txt")
      |> Part2Solver.solve()
      |> IO.inspect(label: "prod part 2", charlists: :as_integers)
    end,
    makaze_2: fn ->
      File.read!("./inputs/prod.txt")
      |> MakazeSolver.parse()
      |> MakazeSolver.sum([&MakazeSolver.unconcat/2, &MakazeSolver.divide/2, &-/2])
      |> IO.inspect(label: "Part 2 Real")
    end
  },
  time: 2,
  memory_time: 1,
  reduction_time: 1
)
