IO.puts("\nRunning script....\n")

Code.require_file("./lib/parser.ex")

alias Parser

Parser.parse("./inputs/test.txt")
|> IO.inspect(label: "test part 1")
