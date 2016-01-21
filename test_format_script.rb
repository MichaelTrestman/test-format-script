cli_output = `cf help`

cli_output.gsub /CF/i, 'awesome'

puts cli_output += "\nPubtoolsRoolz"
