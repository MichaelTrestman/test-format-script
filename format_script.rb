`cf help > help.txt`
cli_output = File.read('help.txt')

cli_output.gsub! /\s*?$/, ''
cli_output.gsub! (/^([^\s].*?):$/){"## <a id='#{ x = $1; $1.downcase.gsub(' ','-')}'></a>#{x}" }

table_line_regex = /^\s{2,}([\w-].+?)\s{2,}(\w.+?)$/

# first_table_line = cli_output.match(table_line_regex)[0]
# p first_table_line
cli_output.gsub!(table_line_regex){ "   #{$1}  |  #{$2}"}


table_regex = /(^##[^\n]*?$)(\n(^[^\n]+?\|[^\n]+?$))/

cli_output.gsub!(table_regex){"#{$1}\nName   |   Description\n------------|------------#{$2}"}

chunk_regex = /(##.*?\/a>)(.*?):(.*?)(?=#)/m

cli_output.gsub!(chunk_regex){"#{$1}#{$2}#{$3}\n[Top](##{$2.downcase.gsub(' ','-')}"}



File.open('cli_help.html.md.erb', "w") { |file| file << cli_output }

