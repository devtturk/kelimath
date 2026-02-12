import 'package:flutter/material.dart';

import 'number_button.dart';

/// Kullanılabilir sayıları grid olarak gösteren widget.
class AvailableNumbersGrid extends StatelessWidget {
  const AvailableNumbersGrid({
    super.key,
    required this.numbers,
    required this.onNumberTap,
    this.selectedIndex,
    this.isWaitingForSecond = false,
  });

  /// Mevcut sayılar listesi.
  final List<int> numbers;

  /// Sayıya tıklandığında çağrılacak callback.
  final void Function(int index) onNumberTap;

  /// Seçili sayının index'i (null ise seçili değil).
  final int? selectedIndex;

  /// İkinci sayı bekleniyor mu?
  final bool isWaitingForSecond;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < numbers.length; i++)
          NumberButton(
            number: numbers[i],
            isSelected: selectedIndex == i,
            isWaitingForSecond: isWaitingForSecond && selectedIndex != i,
            onTap: () => onNumberTap(i),
          ),
      ],
    );
  }
}
