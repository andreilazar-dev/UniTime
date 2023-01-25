import 'dart:convert';

class JsonScrubber {
  static Iterable academicYear(String rawjson) {
    String cleanJson = "";
    RegExp regex =
        RegExp(r"var\s*.*?=\s", multiLine: true, caseSensitive: true);
    String json1 = rawjson.replaceAll(regex, "");
    RegExp regex1 = RegExp(r"\{.*?\}");
    Iterable<Match> matches1 = regex1.allMatches(json1);

    for (Match m in matches1) {
      //print(m.group(0));
      cleanJson = cleanJson + m.group(0)! + ",";
    }
    cleanJson = cleanJson.substring(0, cleanJson.length - 1) + "]";

    int startIndex = cleanJson.indexOf(':', cleanJson.indexOf(':'));

    // Extract the substring between the indices
    cleanJson = "[" + cleanJson.substring(startIndex + 1, cleanJson.length);
    // cleanJson = cleanJson + "]";
    return json.decode(cleanJson);
  }

  static Map<String, dynamic> courses(String data) {
    data = _removeElencoCdl(data);
    // Use a regular expression to match the content between 'var' and '='
    data = data.replaceAllMapped(RegExp(r'var\s+(\w+)\s*='), (match) {
      // Extract the content between 'var' and '='
      String? content = match.group(1);
      // Wrap the content with double quotes and replace '=' with ':'
      return '"$content":';
    });

    // Replace all remaining ';' with ','
    data = data.replaceAll(';', ',');

    //remove last ,

    // Find the position of the last ',' character
    int commaIndex = data.lastIndexOf(',');
    if (commaIndex == -1) {
      print('Error: No comma found in the string');
    }

    // Extract the portion of the string before the last ',' character
    data = data.substring(0, commaIndex);

    //end

    return json.decode("[{" + data + "}]")[0];
  }

  static String _removeElencoCdl(String data) {
    // Find the position of the first ';' character after 'var elenco_cdl'
    int startIndex = data.indexOf('var elenco_cdl');
    if (startIndex == -1) {
      print('Error: No "var elenco_cdl" found in the string');
      return "";
    }
    int semicolonIndex = data.indexOf(';', startIndex);
    if (semicolonIndex == -1) {
      print('Error: No semicolon found in the string');
      return "";
    }

    // Extract the portion of the string before the first ';' character
    // and the portion of the string after the first ';' character
    String before = data.substring(0, startIndex);
    String after = data.substring(semicolonIndex + 1);

    // Concatenate the two parts to remove the portion of the string
    // between 'var elenco_cdl' and the first ';' character
    String modified = before + after;

    return modified;
  }

  static Map<String, dynamic> years(String data) {
    // Use a regular expression to match the content between 'var' and '='
    data = data.replaceAllMapped(RegExp(r'var\s+(\w+)\s*='), (match) {
      // Extract the content between 'var' and '='
      String? content = match.group(1);
      // Wrap the content with double quotes and replace '=' with ':'
      return '"$content":';
    });

    // Replace all remaining ';' with ','
    data = data.replaceAll(';', ',');

    //remove last ,

    // Find the position of the last ',' character
    int commaIndex = data.lastIndexOf(',');
    if (commaIndex == -1) {
      print('Error: No comma found in the string');
    }

    // Extract the portion of the string before the last ',' character
    data = data.substring(0, commaIndex);

    //end

    final value = json.decode("[{" + data + "}]");
    return value[0];
  }
}
