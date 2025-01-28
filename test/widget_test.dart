// import 'package:expenses_tracker/main.dart';
// import 'package:expenses_tracker/presentation/screens/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('MyApp Widget Tests', () {
//     testWidgets('SplashScreen is displayed as initial route',
//         (WidgetTester tester) async {
//       // Build the app
//       await tester.pumpWidget(MyApp());

//       // Verify SplashScreen is shown
//       expect(find.byType(SplashScreen), findsOneWidget);
//     });

//     testWidgets('App uses the correct theme', (WidgetTester tester) async {
//       // Build the app
//       await tester.pumpWidget(MyApp());

//       // Find MaterialApp in the widget tree
//       final materialApp = find.byType(MaterialApp);
//       expect(materialApp, findsOneWidget,
//           reason: "MaterialApp should exist in the widget tree");

//       // Extract the MaterialApp widget to access its theme
//       final MaterialApp app = tester.widget(materialApp);
//       final ThemeData? theme = app.theme;

//       // Debugging: Ensure theme is not null
//       expect(theme, isNotNull,
//           reason: "ThemeData should not be null in MaterialApp");

//       // Verify the Material 3 usage

//       expect(theme!.useMaterial3, true,
//           reason: "Material 3 should be enabled for the theme");
//     });
//   });
// }
