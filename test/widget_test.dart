import 'package:client_control/components/hamburger_menu.dart';
import 'package:client_control/components/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Drawer Test', () {
    Future<void> pumpDrawer(WidgetTester tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          key: scaffoldKey,
          drawer: const HamburgerMenu(),
        ),
      ));

      scaffoldKey.currentState?.openDrawer();

      await tester.pump();
    }

    testWidgets('Find "Menu" in drawer', (tester) async {
      await pumpDrawer(tester);

      expect(find.text('Menu'), findsOneWidget);
    });

    testWidgets('Find "Gerenciar clientes" in drawer', (tester) async {
      await pumpDrawer(tester);

      expect(find.text("Gerenciar clientes"), findsOneWidget);
    });

    testWidgets('Find "Tipos de clientes" in drawer', (tester) async {
      await pumpDrawer(tester);

      expect(find.text("Tipos de clientes"), findsOneWidget);
    });

    testWidgets('Find "Sair" in drawer', (tester) async {
      await pumpDrawer(tester);

      expect(find.text("Sair"), findsOneWidget);
    });
  });

  group('IconPicker Test', () {
    Future<void> pumpIconPicker(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => showIconPicker(context: context),
            child: const Text("show icon picker"),
          ),
        ),
      ));
    }

    testWidgets('Find dialog IconPicker', (tester) async {
      await pumpIconPicker(tester);

      await tester.tap(find.byType(TextButton));

      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
    });

    testWidgets('IconPicker should be open with 25 Icons', (tester) async {
      await pumpIconPicker(tester);

      await tester.tap(find.byType(TextButton));

      await tester.pumpAndSettle();

      expect(find.byType(Icon), findsNWidgets(25));
    });

    testWidgets('IconPicker click in exist Icon', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async => await showIconPicker(context: context),
            child: const Text("show icon picker"),
          ),
        ),
      ));

      const IconData icon = Icons.card_giftcard;

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(find.byIcon(icon), findsOneWidget);
    });
  });
}
