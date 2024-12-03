IO.puts("\nRunning.....\n\n")

Mix.install([
  {:nimble_parsec, "~> 1.0"}
])

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/solvers.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver

prod_input = Parser.parse("./inputs/prod.txt")

Parser.parse("./inputs/test.txt")
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 test", charlists: :as_integers)

prod_input
|> Part1Solver.solve()
|> IO.inspect(label: "Part 1 prod", charlists: :as_integers)

Parser.parse("./inputs/test2.txt")
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 test", charlists: :as_integers)

prod_input
|> Part2Solver.solve()
|> IO.inspect(label: "Part 2 prod", charlists: :as_integers)
