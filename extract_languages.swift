import Foundation

// Ruta al archivo .txt
let filePath = "LANGUAGE.TXT"

do {
    // Lee el contenido del archivo como una cadena
    let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
    
    // Expresión regular mejorada para capturar nombres de lenguajes de programación al inicio de la línea
    // Los nombres pueden contener letras, números, y algunos caracteres especiales como +, *, -, #
    let regex = try NSRegularExpression(pattern: "^[A-Za-z0-9#*+.-]+", options: .anchorsMatchLines)
    
    // Encuentra todas las coincidencias en el archivo
    let matches = regex.matches(in: fileContents, options: [], range: NSRange(location: 0, length: fileContents.utf16.count))
    
    var languages = [String]()
    
    // Extrae los nombres de lenguajes coincidentes y los añade a la lista, evitando duplicados
    for match in matches {
        if let range = Range(match.range, in: fileContents) {
            let languageName = String(fileContents[range])
            if !languages.contains(languageName) {
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
