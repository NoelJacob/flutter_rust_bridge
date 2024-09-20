import 'package:flutter/material.dart';
import 'package:frb_example_rust_ui_counter/src/rust/app.dart';
import 'package:frb_example_rust_ui_counter/src/rust/frb_generated.dart';
import 'package:styled_widget/styled_widget.dart';

void main() async {
  await RustLib.init();
  runApp(MyRustApp());
}

class MyRustApp extends RustWidget {
  MyRustApp({super.key}): super(state: RustState());

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
      body: Column(
          children: <Widget>[
            Text('Count: ${state.count}'),
            TextButton(
              onPressed: state.increment,
              child: Text('+1'),
            ),
          ],
        ),
    ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   RustState state = RustState();
//   late final BaseRustState baseState;
//
//   @override
//   void initState() {
//     super.initState();
//     baseState = BaseRustState(onMutate: () {
//       if (mounted) setState(() {});
//     });
//     state.setBaseState(baseState: baseState);
//   }
//
//   @override
//   void dispose() {
//     baseState.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//           body: [
//         Text('Count: ${state.count}'),
//         TextButton(
//           onPressed: state.increment,
//           child: Text('+1'),
//         ),
//       ].toColumn().padding(all: 16)),
//     );
//   }
// }
