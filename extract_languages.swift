import Foundation

// Ruta al archivo .txt
let filePath = "LANGUAGE.TXT"

do {
    // Lee el contenido del archivo como una cadena
    let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
    
    // Divide el contenido en líneas
    let lines = fileContents.components(separatedBy: .newlines)
    
    var languages = [String]()
    
    // Bandera para verificar cuándo comenzar a capturar nombres de lenguajes
    var capturingLanguages = false
    
    for line in lines {
        // Detecta cuando empieza la lista de lenguajes (esto depende de cómo está estructurado el archivo)
        if line.contains("2.PAK") { // Aquí es donde detectamos el inicio de los lenguajes
            capturingLanguages = true
        }
        
        // Comienza a capturar nombres de lenguajes
        if capturingLanguages {
            // Intenta detectar si la línea contiene el nombre de un lenguaje
            // Puedes ajustar esto según el formato específico del archivo
            if let languageName = line.components(separatedBy: " - ").first {
                languages.append(languageName)
            }
            
            // Detecta cuándo termina la lista de lenguajes (si es necesario)
            if line.contains("AXIS") { // Ejemplo: cuando termina la lista
                break
            }
        }
    }
    
    // Imprime todos los lenguajes capturados
    for language in languages {
        print(language)
    }
    
    print("Total de lenguajes encontrados: \(languages.count)")
    
} catch {
    // En caso de error al leer el archivo
    print("Error al leer el archivo: \(error.localizedDescription)")
}
