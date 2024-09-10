import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class ExtractLanguages {
    public static void main(String[] args) {
        String filePath = "LANGUAGE.TXT";

        try {
            // Lee el contenido del archivo
            StringBuilder fileContents = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    fileContents.append(line).append("\n");
                }
            }

            // Expresión regular para capturar nombres de lenguajes
            Pattern pattern = Pattern.compile("^[A-Za-z0-9_\\-\\.\\+\\*/&|~`<>?!@#\\^\\(\\)\\[\\]{}]+(?:\\s*\\([^\\)]+\\))?\\s*-", Pattern.MULTILINE);
            Matcher matcher = pattern.matcher(fileContents);

            Set<String> languages = new HashSet<>();

            // Extrae los nombres de lenguajes y aplica filtros
            while (matcher.find()) {
                String languageName = matcher.group().split(" -")[0].trim();

                // Filtra nombres no deseados
                if (isValidLanguage(languageName)) {
                    languages.add(languageName);
                }
            }

            // Imprime los lenguajes en orden alfabético
            languages.stream().sorted().forEach(System.out::println);

            // Imprime el total de lenguajes encontrados
            System.out.println("\nTotal de lenguajes encontrados: " + languages.size());

        } catch (IOException e) {
            System.out.println("Error al leer el archivo: " + e.getMessage());
        }
    }

    private static boolean isValidLanguage(String languageName) {
        String[] unwantedPatterns = {"^\\s*$", "^\\d{2,}[^a-zA-Z\\d]", "^[A-Za-z]$"};
        for (String pattern : unwantedPatterns) {
            if (Pattern.compile(pattern).matcher(languageName).find()) {
                return false;
            }
        }
        return true;
    }
}


