import 'dart:math';

String generateUserId() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  String randomString = List.generate(6, (index) {
    return characters[random.nextInt(characters.length)];
  }).join();

  return 'U$randomString';
}

String generateSchoolId() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  String randomString = List.generate(6, (index) {
    return characters[random.nextInt(characters.length)];
  }).join();

  return 'S$randomString';
}

String generateClassId() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  String randomString = List.generate(6, (index) {
    return characters[random.nextInt(characters.length)];
  }).join();

  return 'C$randomString';
}

String generateStudentId() {
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  String randomString = List.generate(6, (index) {
    return characters[random.nextInt(characters.length)];
  }).join();

  return 's$randomString';
}
