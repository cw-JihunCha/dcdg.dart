import 'package:test/test.dart';

import 'utils.dart';

void main() {
  pubGetFixtures();

  group('dcdg tool (exclude cases)', () {
    test('should ignore excluded classes', () {
      final result = runWith([
        '-e',
        'PublicInternalPublic',
        '-p',
        'test/fixtures/simple/',
      ]);
      expect(result.exitCode, 0);
      expect(result.stdout, contains('PublicExternalPublic'));
      expect(result.stdout, contains('_PrivateExternalPrivate'));
      expect(result.stdout, isNot(contains('PublicInternalPublic')));
      expect(result.stdout, contains('_PrivateInternalPrivate'));
      expect(result.stdout, contains('PublicPartInternalPartPublic'));
      expect(result.stdout, contains('_PrivatePartInternalPartPrivate'));
    });

    test('should ignore excluded classes based on a regex', () {
      final result = runWith([
        '-e',
        '.*Internal.*',
        '-p',
        'test/fixtures/simple/',
      ]);
      expect(result.exitCode, 0);
      expect(result.stdout, contains('PublicExternalPublic'));
      expect(result.stdout, contains('_PrivateExternalPrivate'));
      expect(result.stdout, isNot(contains('PublicInternalPublic')));
      expect(result.stdout, isNot(contains('_PrivateInternalPrivate')));
      expect(result.stdout, isNot(contains('PublicPartInternalPartPublic')));
      expect(result.stdout, isNot(contains('_PrivatePartInternalPartPrivate')));
    });

    test('should exclude private classes', () {
      final result = runWith([
        '--exclude-private',
        'class',
        '-p',
        'test/fixtures/simple/',
      ]);
      expect(result.exitCode, 0);
      expect(result.stdout, contains('PublicExternalPublic'));
      expect(result.stdout, isNot(contains('_PrivateInternalPrivate')));
      expect(result.stdout, contains('PublicInternalPublic'));
      expect(result.stdout, isNot(contains('_PrivateInternalPrivate')));
      expect(result.stdout, contains('PublicPartInternalPartPublic'));
      expect(result.stdout, isNot(contains('_PrivatePartInternalPartPrivate')));
    });
  });
}