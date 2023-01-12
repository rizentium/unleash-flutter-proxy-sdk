import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unleash_proxy/unleash_proxy.dart';

import 'unleash_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('UnleashApp', () {
    late UnleashApp unleashApp;
    late http.Client client;
    late UnleashOptions options;

    final headers = <String, String>{};
    final context = UnleashContext(userId: '12345');

    late Uri requestBasic;
    late Uri requstWithContext;

    setUp(() async {
      options = UnleashOptions(
        proxyUrl: 'https://proxy_url.com',
        clientKey: 'clientKey',
        poolMode: const Duration(seconds: 1),
      );
      client = MockClient();
      headers.addAll({
        'Authorization': options.clientKey,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });

      requestBasic = Uri.tryParse(options.proxyUrl)!;
      requstWithContext = Uri.tryParse(
        '${options.proxyUrl}?${context.queryParams}',
      )!;

      when(client.get(requestBasic, headers: headers)).thenAnswer(
        (realInvocation) async {
          const filePath = 'test/data/mock_proxy.json';
          final response = await rootBundle.loadString(filePath);
          return http.Response(response, 200);
        },
      );

      when(client.get(requstWithContext, headers: headers)).thenAnswer(
        (realInvocation) async {
          const filePath = 'test/data/mock_proxy_with_context.json';
          final response = await rootBundle.loadString(filePath);
          return http.Response(response, 200);
        },
      );

      unleashApp = await Unleash.initializeApp(
        options: options,
        client: client,
      );
    });

    test('should return correct data', () async {
      // expect(unleashApp.toggles, isNull);

      final uri = Uri.tryParse(options.proxyUrl)!;
      expect(uri.queryParameters, <String, String>{});

      await Future.delayed(const Duration(seconds: 3), () => {});
      verify(client.get(uri, headers: headers)).called(4);

      expect(unleashApp.toggles?.length, 2);

      final toggle1 = unleashApp.isEnabled('demo');
      final toggle2 = unleashApp.isEnabled('demoApp.step2');

      expect(toggle1, isTrue);
      expect(toggle2, isFalse);
    });

    test('should return correct data after update context', () async {
      await unleashApp.setContext(UnleashContext(userId: '12345'));

      final queryParams = unleashApp.context?.queryParams;
      final uri = Uri.tryParse('${options.proxyUrl}?$queryParams')!;

      await Future.delayed(const Duration(seconds: 3), () => {});
      verify(client.get(uri, headers: headers)).called(3);

      expect(uri.queryParameters, {'userId': '12345'});

      expect(unleashApp.toggles?.length, 3);

      final toggle1 = unleashApp.isEnabled('demo');
      final toggle2 = unleashApp.isEnabled('demoApp.step2');

      expect(toggle1, isTrue);
      expect(toggle2, isTrue);
    });
  });

  group('UnleashApp with bootstrap', () {
    late UnleashApp unleashApp;
    late http.Client client;
    late UnleashOptions options;

    final headers = <String, String>{};
    final context = UnleashContext(userId: '12345');

    late Uri requestBasic;
    late Uri requstWithContext;

    setUp(() async {
      options = UnleashOptions(
        proxyUrl: 'https://proxy_url.com',
        clientKey: 'clientKey',
        poolMode: const Duration(seconds: 1),
        bootstrap: UnleashBootstrap(
          source: [
            UnleashToggle(
              enabled: true,
              name: 'bootstrap',
              variant: UnleashToggleVariant(name: 'disabled', enabled: true),
            ),
          ],
        ),
      );
      client = MockClient();
      headers.addAll({
        'Authorization': options.clientKey,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });

      requestBasic = Uri.tryParse(options.proxyUrl)!;
      requstWithContext = Uri.tryParse(
        '${options.proxyUrl}?${context.queryParams}',
      )!;

      when(client.get(requestBasic, headers: headers)).thenAnswer(
        (realInvocation) async {
          const filePath = 'test/data/mock_proxy.json';
          final response = await rootBundle.loadString(filePath);
          return http.Response(response, 200);
        },
      );

      when(client.get(requstWithContext, headers: headers)).thenAnswer(
        (realInvocation) async {
          const filePath = 'test/data/mock_proxy_with_context.json';
          final response = await rootBundle.loadString(filePath);
          return http.Response(response, 200);
        },
      );

      unleashApp = await Unleash.initializeApp(
        options: options,
        client: client,
      );
    });

    test('should return correct data', () async {
      // expect(unleashApp.toggles, isNull);

      final uri = Uri.tryParse(options.proxyUrl)!;
      expect(uri.queryParameters, <String, String>{});

      await Future.delayed(const Duration(seconds: 3), () => {});
      verify(client.get(uri, headers: headers)).called(4);

      expect(unleashApp.toggles?.length, 3);

      final toggle1 = unleashApp.isEnabled('demo');
      final toggle2 = unleashApp.isEnabled('demoApp.step2');
      final toggle3 = unleashApp.isEnabled('bootstrap');

      expect(toggle1, isTrue);
      expect(toggle2, isFalse);
      expect(toggle3, isTrue);
    });

    test('should return correct data after update context', () async {
      await unleashApp.setContext(UnleashContext(userId: '12345'));

      final queryParams = unleashApp.context?.queryParams;
      final uri = Uri.tryParse('${options.proxyUrl}?$queryParams')!;

      await Future.delayed(const Duration(seconds: 3), () => {});
      verify(client.get(uri, headers: headers)).called(3);

      expect(uri.queryParameters, {'userId': '12345'});

      expect(unleashApp.toggles?.length, 4);

      final toggle1 = unleashApp.isEnabled('demo');
      final toggle2 = unleashApp.isEnabled('demoApp.step2');
      final toggle3 = unleashApp.isEnabled('bootstrap');

      expect(toggle1, isTrue);
      expect(toggle2, isTrue);
      expect(toggle3, isTrue);
    });
  });
}
