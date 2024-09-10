import Foundation

// Ruta al archivo .txt
let filePath = "LANGUAGE.TXT"

do {
    // Lee el contenido del archivo como una cadena
    let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
    
    // Expresión regular mejorada para capturar una gama aún más amplia de nombres de lenguajes
    let regex = try NSRegularExpression(pattern: "^[A-Za-z0-9_\\-\\.\\+\\*/&|~`<>?!@#\\^]+(?:\\s*\\([^\\)]+\\))?\\s*-", options: .anchorsMatchLines)
    
    // Encuentra todas las coincidencias en el archivo
    let matches = regex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.utf16.count))
    
    var languages = [String]()
    
    // Extrae los nombres de lenguajes coincidentes y los añade a la lista, evitando duplicados y filtrando palabras no deseadas
    for match in matches {
        if let range = Range(match.range, in: fileContents) {
            let languageName = String(fileContents[range])
                .components(separatedBy: " -").first!  // Elimina la descripción que sigue al nombre del lenguaje
                .trimmingCharacters(in: .whitespacesAndNewlines)  // Limpia espacios en blanco innecesarios
            
            // Filtra nombres no deseados (ajustar patrones según sea necesario)
            let unwantedPatterns = ["^p\\.", "^pp\\.", "^[0-9]", "^[a-z]{1,2}$", "^x86", "^[A-Za-z]$", "^\\s*$", "^\\d{2,}[^a-zA-Z\\d]"]
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
    
    // Ordena los lenguajes en orden alfabético
    languages.sort()
    
    // Imprime los lenguajes en orden alfabético
    for language in languages {
        print(language)
    }
    
    // Imprime el total de lenguajes encontrados
    print("\nTotal de lenguajes encontrados: \(languages.count)")
    
} catch {
    // Manejo de errores al leer el archivo
    print("Error al leer el archivo: \(error.localizedDescription)")
}
