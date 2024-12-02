IO.puts("\nRunning project\n")

Code.require_file("./lib/parser.ex", __DIR__)
Code.require_file("./lib/part_1_solver.ex", __DIR__)
Code.require_file("./lib/part_2_solver.ex", __DIR__)

alias Parser
alias Part1Solver
alias Part2Solver

test_input = Parser.parse("./inputs/test.txt")
prod_input = Parser.parse("./inputs/prod.txt")

test_input
|> Part1Solver.solve()
|> IO.inspect(label: "test part 1")
 
prod_input
|> Part1Solver.solve()
|> IO.inspect(label: "prod part 1")

test_input
|> Part2Solver.solve()
|> IO.inspect(label: "test part 2")

prod_input
|> Part2Solver.solve()
|> IO.inspect(label: "prod part 2")
