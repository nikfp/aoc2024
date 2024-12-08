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
