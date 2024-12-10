IO.puts("\nRunning script.....\n")

Code.require_file("./lib/parser.ex", __DIR__)

alias Parser

Parser.parse("./inputs/simple_test.txt")
|> IO.inspect(label: "simple_test part 1")
Parser.parse("./inputs/test.txt")
|> IO.inspect(label: "test part 1")
