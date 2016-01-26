languages = {
	"German"=> "de_DE",
	"English"=> "en_US",
	"Spanish"=> "es_ES",
	"French"=> "fr_FR",
	"Italian"=> "it_IT",
	"Japanese"=> "ja_JP",
	"Portuguese (Brazil)"=> "pt_BR",
	"Chinese (simplified)"=> "zh_Hans"
}

table_line_regex = /^\s{2,}(\w.+?)\s{2,}(\S.+?)$/
table_regex = /(^##[^\n]*?$)(\n(^[^\n]+?\|[^\n]+?$))/



languages.each do |lang, code|

	`cf config --locale #{code}; cf help > help.txt`

	cli_output = File.read('help.txt')

	cli_output.gsub!(/\s*?$/, '')
	cli_output.gsub!(/^([^\s].*?):$/){"## <a id='#{$1.downcase.gsub(' ','-')}'></a>#{$1}" }
	cli_output.gsub!(table_line_regex){ "   #{$1}  |  #{$2}"}
	cli_output.gsub!(table_regex){"#{$1}\nName   |   Description\n------------|------------#{$2}"}
	cli_output.gsub!('_', '\_')


	title = "---\ntitle: CF CLI #{lang}\n---\n\n"

	File.open("cli_help_#{code}.html.md.erb", "w") do |file| 
		file << title 
		file << cli_output
	end

end
