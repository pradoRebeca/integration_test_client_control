import 'package:client_control/models/clients.dart';
import 'package:client_control/models/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:client_control/main.dart' as app;
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration Test', (tester) async {
    final providerKey = GlobalKey();

    app.main(list: [], providerKey: providerKey);

    await tester.pumpAndSettle();

    expect(find.text('Clientes'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Gerenciar clientes'), findsOneWidget);
    expect(find.text('Tipos de clientes'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);

    await tester.tap(find.text("Tipos de clientes"));
    await tester.pumpAndSettle();

    expect(find.text('Tipos de cliente'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);

    expect(find.text('Platinum'), findsOneWidget);
    expect(find.text('Golden'), findsOneWidget);
    expect(find.text('Titanium'), findsOneWidget);
    expect(find.text('Diamond'), findsOneWidget);
    expect(find.text('Titanium'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    const String textNewClientType = "Black";
    const IconData iconNewClientType = Icons.card_giftcard;

    await tester.enterText(find.byType(TextFormField), textNewClientType);
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(Icon), findsAny);

    await tester.tap(find.byIcon(iconNewClientType));
    await tester.pumpAndSettle();

    expect(find.byIcon(iconNewClientType), findsOneWidget);

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text(textNewClientType), findsOneWidget);
    expect(find.byIcon(iconNewClientType), findsOneWidget);

    expect(
        Provider.of<Types>(providerKey.currentContext!, listen: false)
            .types
            .last
            .name,
        textNewClientType);
    expect(
        Provider.of<Types>(providerKey.currentContext!, listen: false)
            .types
            .last
            .icon,
        iconNewClientType);

    //Testando novo cliente
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Gerenciar clientes"));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    const String nameNewClient = 'Julia Nascimento';
    const String emailNewClient = 'julia.nascimento@gmailo.com';

    await tester.enterText(find.byKey(const Key('nameKey')), nameNewClient);
    await tester.enterText(find.byKey(const Key('emailKey')), emailNewClient);

    await tester.tap(find.byIcon(Icons.arrow_downward));
    await tester.pumpAndSettle();

    await tester.tap(find.text(textNewClientType).last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.textContaining(nameNewClient), findsOneWidget);

    expect(
        Provider.of<Clients>(providerKey.currentContext!, listen: false)
            .clients
            .last
            .name,
        nameNewClient);
    expect(
        Provider.of<Clients>(providerKey.currentContext!, listen: false)
            .clients
            .last
            .email,
        emailNewClient);

    //Delete Client Test
    await tester.drag(find.byType(Dismissible), const Offset(500, 0));
    await tester.pumpAndSettle();

    expect(find.textContaining(nameNewClient), findsNothing);

    // //Exit Test
    // await tester.tap(find.byIcon(Icons.menu));
    // await tester.pumpAndSettle();

    // await tester.tap(find.text("Sair"));
  });
}
