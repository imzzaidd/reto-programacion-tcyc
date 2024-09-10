<?php
$filePath = 'LANGUAGE.TXT';

try {

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
        
        // 1
        $unwantedPatterns = ['/^\s*$/', '/^\d{2,}[^a-zA-Z\d]/', '/^[A-Za-z]$/'];
        $isValid = true;
        
        foreach ($unwantedPatterns as $pattern) {
            if (preg_match($pattern, $languageName)) {
                $isValid = false;
                break;
            }
        }
        
        // 2
        if ($isValid && !in_array($languageName, $languages)) {
            $languages[] = $languageName;
        }
    }
    
    //Orden alfabético
    sort($languages);
    
    // Imprime en orden alfabético
    foreach ($languages as $language) {
        echo $language . PHP_EOL;
    }
    
    // Imprime el total de lenguajes encontrados
    echo "\nTotal de lenguajes encontrados: " . count($languages) . PHP_EOL;
    
} catch (Exception $e) {
    //Excepción
    echo "Error al leer el archivo: " . $e->getMessage() . PHP_EOL;
}

?>

