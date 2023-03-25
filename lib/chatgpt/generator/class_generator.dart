import 'dart:io';
import 'package:path/path.dart' as path;
main() {
  Class clazz1 = Class(
    name: 'TaskResult',
    fields: [
      Field(name: 'cost', type: int),
      Field(name: 'taskName', type: String),
      Field(name: 'count', type: int),
      Field(name: 'taskCode', type: String),
      Field(name: 'taskInfo', type: String, nullable: true, isRequired: false),
    ],
  );
  Class clazz2 = Class(
    name: 'User',
    fields: [
      Field(name: 'age', type: int),
      Field(name: 'username', type: String),
      Field(name: 'roleId', type: int),
      Field(name: 'info', type: String,nullable: true),
      Field(name: 'height', type: double, nullable: true, isRequired: false),
    ],
  );
  clazz1.write2File(Directory(r'E:\Projects\Flutter\Github\skeleton\lib\chatgpt\generator'));
  clazz2.write2File(Directory(r'E:\Projects\Flutter\Github\skeleton\lib\chatgpt\generator'));
}

class Class {
  final List<Field> fields;
  final String name;

  Class({required this.fields, required this.name});

  Future<void> write2File(Directory directory){
    File file = File(path.join(directory.path,"${fileName}.dart"));
    return file.writeAsString(buildClass());
  }

  RegExp regExp =  RegExp(r'[A-Z].*?(?=([A-Z]|\b))');

  String get fileName{
   return regExp.allMatches(name).map((e) => e.group(0)?.toLowerCase()).join("_");
  }

  String buildClass() {
    String defines = '';
    String constructParams = '';
    String toJsonStatements = '';
    String fromJsonStatements = '';
    String copyWithParamStatements = '';
    String copyWithStatements = '';
    for (int i = 0; i < fields.length; i++) {
      Field field = fields[i];
      defines += "${field.defineStatement}\n";
      constructParams += field.paramStatement;
      toJsonStatements += field.toJsonStatement;
      fromJsonStatements += field.fromJsonStatement;
      copyWithParamStatements += field.copyWithParamStatement;
      copyWithStatements += field.copyWithStatement;
      if (i != fields.length - 1) {
        constructParams += '\n';
        toJsonStatements += '\n';
        fromJsonStatements += '\n';
        copyWithParamStatements += '\n';
        copyWithStatements += '\n';
      }
    }

    String result = """
class $name {
$defines
  $name({
$constructParams
  });

  $name copyWith({
$copyWithParamStatements
  }) =>
      $name(
$copyWithStatements
      );
      
      static $name fromJson(Map<String, dynamic> map) => $name(
$fromJsonStatements
      );

  Map<String,dynamic> toJson()=>{
$toJsonStatements
  };
}
""";
    return result;
  }
}

class Field {
  final bool isFinal;
  final bool isStatic;
  final bool isRequired;
  final String name;
  final bool nullable;
  final Type type;

  Field({
    this.isFinal = true,
    this.isStatic = false,
    required this.name,
    required this.type,
    this.nullable = false,
    this.isRequired = true,
  });

  String get defineStatement {
    String finalArg = isFinal ? 'final' : '';
    String typeArg = type.toString();
    String nullableArg = nullable ? '?' : '';
    return '  $finalArg $typeArg$nullableArg $name;';
  }

  String get paramStatement {
    String requiredArg = isRequired ? 'required' : '';
    return '    $requiredArg this.$name,';
  }

  String get toJsonStatement {
    return '        "$name": $name,';
  }

  String get fromJsonStatement {
    return '        $name: map["$name"] ,';
  }

  String get copyWithParamStatement {
    return '    $type? $name,';
  }

  String get copyWithStatement {
    return '        $name: $name ?? this.$name,';
  }
}
