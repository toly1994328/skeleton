import 'dart:io';

void main(){
  File file = File(r'E:\Projects\Flutter\Github\skeleton\lib\paint\object\boy\boy.svg');
  String content = file.readAsStringSync();
  RegExp regExp = RegExp(r'\bd="(.*?)"');
  int i = 0;
  regExp.allMatches(content).forEach((element) {
    String code = """
final Path path$i = parseSvgPathData('''${element.group(1)}''');
    """;
    print(code);
    i++;
  });
}