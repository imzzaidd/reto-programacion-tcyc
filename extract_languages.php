<?php

function extractLanguages($filePath) {
    $languages = [];
    $regex = "/^[A-Za-z][A-Za-z0-9+\-\s]*$/";
    
    if (($file = fopen($filePath, "r")) !== FALSE) {
        while (($line = fgets($file)) !== FALSE) {
            $line = trim($line);
            if (preg_match($regex, $line) && strlen($line) > 1 && strlen($line) < 40) {
                $languages[] = $line;
            }
        }
        fclose($file);
    }
    
    // Sort the languages alphabetically
    sort($languages);

    // Print the total number of languages and the names
    echo "Total lenguajes: " . count($languages) . "\n";
    foreach ($languages as $language) {
        echo $language . "\n";
    }
}

// Usage
$filePath = "LANGUAGE.TXT";
extractLanguages($filePath);

?>

