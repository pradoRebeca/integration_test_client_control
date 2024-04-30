import 'package:client_control/models/client.dart';
import 'package:client_control/models/client_type.dart';
import 'package:client_control/models/clients.dart';
import 'package:client_control/models/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Clients Test', () {
    final clientRebeca = Client(
        name: 'Rebeca',
        email: "rebeca.prado@gmail.com",
        type: ClientType(name: 'Gold', icon: Icons.account_circle));

    final clientJose = Client(
        name: 'Jose',
        email: "jose.silva@gmail.com",
        type: ClientType(name: 'Gold', icon: Icons.account_circle));

    test('Clients model create client', () {
      final clients = Clients(clients: []);

      clients.add(clientRebeca);

      expect(clients.clients, [clientRebeca]);
    });

    test('Clients model create two clients', () {
      final clients = Clients(clients: []);

      clients.add(clientRebeca);
      clients.add(clientJose);

      expect(clients.clients, [clientRebeca, clientJose]);
    });

    test('Clients model remove 1/2 clients', () {
      final clients = Clients(clients: [clientRebeca]);

      clients.remove(0);
      clients.add(clientJose);

      expect(clients.clients, [clientJose]);
    });
  });

  group('Types Test', () {
    final type = ClientType(name: 'Gold', icon: Icons.person);

    test('Types create new type', () {
      final types = Types(types: []);

      types.add(type);

      expect(types.types, [type]);
    });

    test('Types remove type', () {
      final types = Types(types: [type]);

      types.remove(0);

      expect(types.types, []);
    });
  });
}
