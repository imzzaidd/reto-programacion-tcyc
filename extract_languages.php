<?php
$filePath = 'LANGUAGE.TXT';

try {
    // Lee el contenido del archivo como una cadena
    $fileContents = file_get_contents($filePath);
    
    if ($fileContents === false) {
        throw new Exception("No se pudo leer el archivo.");
    }
    
    // Expresión regular
    $pattern = '/^[A-Za-z0-9_\-\.+\/*&|~`<>?!@#\^()\[\]{}]+(?:\s*\([^)]*\))?\s*-/m';
    
    // Coincidencias
    preg_match_all($pattern, $fileContents, $matches);
    
    $languages = [];
    
    // Extrae los nombres de lenguajes y aplica filtros
    foreach ($matches[0] as $match) {
        $languageName = trim(explode(' -', $match)[0]);
        
        // Filtra nombres no deseados
        $unwantedPatterns = ['/^\s*$/', '/^\d{2,}[^a-zA-Z\d]/', '/^[A-Za-z]$/'];
        $isValid = true;
        
        foreach ($unwantedPatterns as $pattern) {
            if (preg_match($pattern, $languageName)) {
                $isValid = false;
                break;
            }
        }
        
        // Lenguajes válidos y evita duplicados
        if ($isValid && !in_array($languageName, $languages)) {
            $languages[] = $languageName;
        }
    }
    
    // Ordena en orden alfabético
    sort($languages);
    
    // Imprime en orden alfabético
    foreach ($languages as $language) {
        echo $language . PHP_EOL;
    }
    
    // Imprime el total de lenguajes encontrados
    echo "\nTotal de lenguajes encontrados: " . count($languages) . PHP_EOL;
    
} catch (Exception $e) {
    // Manejo de errores
    echo "Error al leer el archivo: " . $e->getMessage() . PHP_EOL;
}

?>

