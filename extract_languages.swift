import Foundation
let filePath = "LANGUAGE.TXT"

do {
    let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
    let regex = try NSRegularExpression(pattern: "^[A-Za-z0-9_\\-\\.\\+\\*/&|~`<>?!@#\\^\\(\\)\\[\\]{}]+(?:\\s*\\([^\\)]+\\))?\\s*-", options: .anchorsMatchLines)
    
    //Coincidencias en el archivo
    let matches = regex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.utf16.count))
    var languages = [String]()
    
    // Extrae los nombres de lenguajes 
    for match in matches {
        if let range = Range(match.range, in: fileContents) {
            let languageName = String(fileContents[range])
                .components(separatedBy: " -").first!  // Elimina la descripción que sigue al nombre del lenguaje
                .trimmingCharacters(in: .whitespacesAndNewlines)  // Limpia espacios en blanco innecesarios
            
            // Filtra nombres no deseados
            let unwantedPatterns = ["^p\\.", "^pp\\.", "^[0-9]", "^[a-z]{1,2}$", "^x86", "^[A-Za-z]$", "^\\s*$", "^\\d{2,}[^a-zA-Z\\d]", "^(?:\\s*\\([^\\)]+\\))?$"]
            var isValid = true
            for pattern in unwantedPatterns {
                let invalidRegex = try NSRegularExpression(pattern: pattern, options: [])
                if invalidRegex.firstMatch(in: languageName, options: [], range: NSRange(location: 0, length: languageName.utf16.count)) != nil {
                    isValid = false
                    break
                }
            }
            // Agregar solo lenguajes válidos y evitar duplicados
            if isValid && !languages.contains(languageName) {
                languages.append(languageName)
            }
        }
    }
    
    // Orden e impresión de datos
    languages.sort()
    for language in languages {
        print(language)
    }
    print("\nTotal de lenguajes encontrados: \(languages.count)")
    
} catch {
    // Excepciones
    print("Error al leer el archivo: \(error.localizedDescription)")
}
