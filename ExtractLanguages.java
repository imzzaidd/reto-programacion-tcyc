import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ExtractLanguages {
    public static void main(String[] args) {
        String filePath = "LANGUAGE.TXT";
        ArrayList<String> languages = new ArrayList<>();

        // Expresión regular para identificar líneas con nombres de lenguajes (que están en mayúscula inicial)
        String regex = "^[A-Za-z0-9][A-Za-z0-9+\\-\\s]*$";
        Pattern pattern = Pattern.compile(regex);

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Verificar si la línea parece ser el nombre de un lenguaje de programación
                Matcher matcher = pattern.matcher(line.trim());
                if (matcher.matches() && line.trim().length() > 1 && line.trim().length() < 40) {
                    languages.add(line.trim());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Imprime el total de lenguajes encontrados
        System.out.println("Total lenguajes: " + languages.size());
        // Imprime los nombres de los lenguajes
        for (String language : languages) {
            System.out.println(language);
        }
    }
}

