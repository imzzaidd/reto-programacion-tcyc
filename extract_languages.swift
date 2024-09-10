import Foundation

func extractLanguages(filePath: String) {
    var languages: [String] = []
    let regex = try! NSRegularExpression(pattern: "^[A-Za-z][A-Za-z0-9+\\-\\s]*$", options: [])
    
    if let fileHandle = FileHandle(forReadingAtPath: filePath) {
        let data = fileHandle.readDataToEndOfFile()
        if let content = String(data: data, encoding: .utf8) {
            let lines = content.components(separatedBy: .newlines)
            for line in lines {
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                if regex.firstMatch(in: trimmedLine, options: [], range: NSRange(location: 0, length: trimmedLine.utf16.count)) != nil {
                    if trimmedLine.count > 1 && trimmedLine.count < 40 {
                        languages.append(trimmedLine)
                    }
                }
            }
        }
        fileHandle.closeFile()
    }

    // Sort the languages alphabetically
    languages.sort()

    // Print the total number of languages and the names
    print("Total lenguajes: \(languages.count)")
    for language in languages {
        print(language)
    }
}

// Usage
let filePath = "LANGUAGE.TXT"
extractLanguages(filePath: filePath)
