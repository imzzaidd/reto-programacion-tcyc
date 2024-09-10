import re
file_path = 'LANGUAGE.TXT'

try:
    with open(file_path, 'r', encoding='utf-8') as file:
        file_contents = file.read()
    
    # Expresión regular 
    pattern = re.compile(r'^[A-Za-z0-9_\-\.+\/*&|~`<>?!@#\^()\[\]{}]+(?:\s*\([^)]*\))?\s*-', re.MULTILINE)
    
    #Coincidencias
    matches = pattern.findall(file_contents)
    
    languages = set()
    
    # Extrae los nombres de lenguajes y aplica filtros
    for match in matches:
        language_name = match.split(' -')[0].strip()
        
        #1
        unwanted_patterns = [r'^p\.', r'^pp\.', r'^[0-9]', r'^[a-z]{1,2}$', r'^x86', r'^[A-Za-z]$', r'^\s*$', r'^\d{2,}[^a-zA-Z\d]', r'^\s*\([^)]*\)\s*$']
        is_valid = True
        
        for pattern in unwanted_patterns:
            if re.match(pattern, language_name):
                is_valid = False
                break
        
        #2
        if is_valid:
            languages.add(language_name)
    
    #Orden alfabético
    languages = sorted(languages)
    
    # Imprime los lenguajes en orden alfabético
    for language in languages:
        print(language)
    
    # Imprime el total de lenguajes encontrados
    print("\nTotal de lenguajes encontrados:", len(languages))
    
except Exception as e:
    #Excepción
    print("Error al leer el archivo:", str(e))
