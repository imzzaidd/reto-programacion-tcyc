file_path = 'LANGUAGE.TXT'

begin
  # Lee el contenido del archivo como una cadena
  file_contents = File.read(file_path, encoding: 'UTF-8')

  # Expresión regular
  pattern = /^[A-Za-z0-9_\-\.+\/*&|~`<>?!@#\^()\[\]{}]+(?:\s*\([^)]*\))?\s*-/
  
  # Coincidencias
  matches = file_contents.scan(pattern)
  languages = []
  
  # Extrae los nombres de lenguajes y aplica filtros
  matches.each do |match|
    language_name = match.split(' -').first.strip
    
    # Filtra nombres no deseados
    unwanted_patterns = [/^p\./, /^pp\./, /^[0-9]/, /^[a-z]{1,2}$/, /^x86/, /^[A-Za-z]$/, /^\s*$/, /^\d{2,}[^a-zA-Z\d]/, /^\s*\([^)]*\)\s*$/]
    is_valid = true
    
    unwanted_patterns.each do |pattern|
      if language_name.match?(pattern)
        is_valid = false
        break
      end
    end
    # Agrega solo lenguajes válidos y evita duplicados
    if is_valid && !languages.include?(language_name)
      languages << language_name
    end
  end
  # Ordena en orden alfabético
  languages.sort.each do |language|
    puts language
  end
  # Imprime el total de lenguajes
  puts "\nTotal de lenguajes encontrados: #{languages.size}"
rescue => e
  # Manejo de errores
  puts "Error al leer el archivo: #{e.message}"
end
