import re

def extract_languages(file_path):
    languages = []
    regex = re.compile(r"^[A-Za-z][A-Za-z0-9+\-\s]*$")
    
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if regex.match(line) and 1 < len(line) < 40:
                languages.append(line)
    
    # Sort the languages alphabetically
    languages.sort()

    # Print the total number of languages and the names
    print(f"Total lenguajes: {len(languages)}")
    for language in languages:
        print(language)

# Usage
file_path = "LANGUAGE.TXT"
extract_languages(file_path)