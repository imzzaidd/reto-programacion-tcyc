def extract_languages(file_path)
  languages = []
  regex = /^[A-Za-z][A-Za-z0-9+\-\s]*$/
  
  File.foreach(file_path) do |line|
    line.strip!
    if line.match?(regex) && line.length > 1 && line.length < 40
      languages << line
    end
  end
  
  # Sort the languages alphabetically
  languages.sort!

  # Print the total number of languages and the names
  puts "Total lenguajes: #{languages.size}"
  languages.each { |language| puts language }
end

# Usage
file_path = "LANGUAGE.TXT"
extract_languages(file_path)
