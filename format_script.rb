`cf help > help.txt`
cli_output = File.read('help.txt')



table_line_regex = /^\s{2,}([\w-].+?)\s{2,}(\w.+?)$/
table_regex = /(^##[^\n]*?$)(\n(^[^\n]+?\|[^\n]+?$))/


cli_output.gsub!(/\s*?$/, '')
cli_output.gsub!(/^([^\s].*?):$/){"## <a id='#{ x = $1; $1.downcase.gsub(' ','-')}'></a>#{x}" }
cli_output.gsub!(table_line_regex){ "   #{$1}  |  #{$2}"}
cli_output.gsub!(table_regex){"#{$1}\nName   |   Description\n------------|------------#{$2}"}
cli_output.gsub!('_', '\_')


title = "---\ntitle: CF CLI\n---\n\n"

File.open('cli_help.html.md.erb', "w") { |file| file << title }
File.open('cli_help.html.md.erb', "a") { |file| file << cli_output }

