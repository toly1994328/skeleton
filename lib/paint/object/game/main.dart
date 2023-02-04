// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:window_manager/window_manager.dart';
//
// void main() async {
//   if (Platform.isWindows || Platform.isMacOS) {
//     WidgetsFlutterBinding.ensureInitialized();
//     await windowManager.ensureInitialized();
//
//     WindowOptions windowOptions = const WindowOptions(
//       size: Size(600, 600),
//       center: true,
//       backgroundColor: Colors.transparent,
//       skipTaskbar: false,
//       titleBarStyle: TitleBarStyle.normal,
//     );
//     windowManager.waitUntilReadyToShow(windowOptions, () async {
//       await windowManager.show();
//       await windowManager.focus();
//     });
//   }
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _count = 0;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             _count++;
//             setState(() {});
//           },
//         ),
//         body: Center(
//             child:
//
//           // Wrap(
//           //   spacing: 26,
//           //   children: [
//           //     // DigitalWidget(
//           //     //   width: 124,
//           //     //   value: 8,
//           //     //   color: Colors.blue,
//           //     //   digitalPath: digitalPath,
//           //     // ),
//           //     SingleDigitalWidget(
//           //       width: 54,
//           //       value: tenBit,
//           //       digitalPath: digitalPath,
//           //     ),
//           //     SingleDigitalWidget(
//           //       color: Colors.red,
//           //       width: 54,
//           //       value: oneBit,
//           //       digitalPath: digitalPath,
//           //     ),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }
