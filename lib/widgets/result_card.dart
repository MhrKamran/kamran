import 'package:flutter/material.dart';

/// [Stateless Widget] — Displays the computed tip and total results.
/// Stateless because it is purely presentational — it receives all values
/// as constructor parameters and renders them without managing any state.
class ResultCard extends StatelessWidget {
  final double tipAmount;
  final double totalAmount;
  final double perPerson;
  final int people;

  const ResultCard({
    super.key,
    required this.tipAmount,
    required this.totalAmount,
    required this.perPerson,
    required this.people,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A6B4A), Color(0xFF22895F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1A6B4A).withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _ResultRow(label: 'Tip Amount', value: '\$${tipAmount.toStringAsFixed(2)}'),
          const Divider(color: Colors.white24, height: 24),
          _ResultRow(label: 'Total Bill', value: '\$${totalAmount.toStringAsFixed(2)}'),
          if (people > 1) ...[
            const Divider(color: Colors.white24, height: 24),
            _ResultRow(
              label: 'Per Person ($people)',
              value: '\$${perPerson.toStringAsFixed(2)}',
              highlight: true,
            ),
          ],
        ],
      ),
    );
  }
}

/// Internal stateless row for each result item
class _ResultRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ResultRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: highlight ? Colors.white : Colors.white70,
            fontSize: highlight ? 15 : 14,
            fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: highlight ? 22 : 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
