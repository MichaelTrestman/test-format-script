cli_output = `cf help`

puts cli_output.gsub /CF/i, 'awesome'
