/// Sayı oyununda kullanılabilecek dört işlem operatörleri.
enum Operation {
  add('+'),
  subtract('-'),
  multiply('×'),
  divide('÷');

  const Operation(this.symbol);

  /// Operatörün görsel sembolü.
  final String symbol;

  /// İki sayı üzerinde işlemi uygular.
  /// Bölme işlemi için kalansız bölünme kontrolü yapılmalıdır.
  int apply(int a, int b) {
    return switch (this) {
      Operation.add => a + b,
      Operation.subtract => a - b,
      Operation.multiply => a * b,
      Operation.divide => a ~/ b,
    };
  }

  /// Bölme işleminin geçerli olup olmadığını kontrol eder.
  /// Kalansız bölünme gereklidir.
  bool isValidDivision(int a, int b) {
    if (this != Operation.divide) return true;
    if (b == 0) return false;
    return a % b == 0;
  }
}
