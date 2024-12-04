IO.puts("\nRunning script.....\n")

Mix.install([
  {:benchee, "~> 1.0", only: :dev}
])

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver
alias Benchee

test_input = Parser.parse("./inputs/test.txt")
test_2_input = Parser.parse("./inputs/test2.txt")
prod_input = Parser.parse("./inputs/prod.txt")

test_input
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 test")

Parser.parse("./inputs/prod.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 prod")

test_input
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 test")

Parser.parse("./inputs/prod.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 prod")

Code.require_file("./lib/waseem_solvers.ex", __DIR__)

alias Aoc2024Elixir.D04

D04.run_part_1("./inputs/prod.txt")

Benchee.run(%{
   nik_part1: (fn -> 
    Parser.parse("./inputs/prod.txt")
    |> Part1Solver.solve()
    |> IO.inspect(label: "Part 1 prod")
    end),
  nik_part2: (fn -> 
    Parser.parse("./inputs/prod.txt")
    |> Part2Solver.solve()
    |> IO.inspect(label: "Part 2 prod")
  end),
  waseem_part1: (fn -> 
    D04.run_part_1("./inputs/prod.txt")
  end),
  waseem_part2: (fn -> 
    D04.run_part_2("./inputs/prod.txt")
  end)
}, parallel: 2, time: 2, memory_time: 2, reduction_time: 2)

