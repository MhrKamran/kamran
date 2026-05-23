import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/result_card.dart';
import '../widgets/section_header.dart';
import '../widgets/tip_chip.dart';

/// Home Screen — [Stateful Widget]
/// Manages all calculator state: bill amount, tip %, people count.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _billController = TextEditingController();
  double _tipPercent = 15.0;
  int _people = 1;
  bool _hasResult = false;

  // ── Computed values ──────────────────────────────────────────────
  double get _billAmount => double.tryParse(_billController.text) ?? 0.0;
  double get _tipAmount => _billAmount * (_tipPercent / 100);
  double get _totalAmount => _billAmount + _tipAmount;
  double get _perPerson => _people > 0 ? _totalAmount / _people : 0.0;

  void _calculate() {
    FocusScope.of(context).unfocus();
    setState(() => _hasResult = _billAmount > 0);
  }

  void _reset() {
    _billController.clear();
    setState(() {
      _tipPercent = 15.0;
      _people = 1;
      _hasResult = false;
    });
  }

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  // ── UI ────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A6B4A),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tip Calculator',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset',
            onPressed: _reset,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Bill Amount ─────────────────────────────────────
              const SectionHeader(title: 'Bill Amount', icon: Icons.receipt_long_rounded),
              const SizedBox(height: 8),
              _BillInputField(controller: _billController),

              const SizedBox(height: 24),

              // ── Tip Percentage ──────────────────────────────────
              const SectionHeader(title: 'Select Tip', icon: Icons.percent_rounded),
              const SizedBox(height: 10),
              _TipSelector(
                selected: _tipPercent,
                onChanged: (v) => setState(() => _tipPercent = v),
              ),

              const SizedBox(height: 24),

              // ── People Counter ──────────────────────────────────
              const SectionHeader(title: 'Split Between', icon: Icons.group_rounded),
              const SizedBox(height: 10),
              _PeopleCounter(
                count: _people,
                onDecrement: () {
                  if (_people > 1) setState(() => _people--);
                },
                onIncrement: () => setState(() => _people++),
              ),

              const SizedBox(height: 28),

              // ── Calculate Button ────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A6B4A),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Calculate',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              // ── Results ─────────────────────────────────────────
              if (_hasResult) ...[
                const SizedBox(height: 28),
                ResultCard(
                  tipAmount: _tipAmount,
                  totalAmount: _totalAmount,
                  perPerson: _perPerson,
                  people: _people,
                ),
              ],

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private local widgets (still part of StatefulWidget screen)
// ─────────────────────────────────────────────────────────────────────────────

/// Bill input field — internal Stateless helper
class _BillInputField extends StatelessWidget {
  final TextEditingController controller;
  const _BillInputField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          hintText: '0.00',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 18),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '\$',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A6B4A),
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Tip selector row — internal Stateless helper
class _TipSelector extends StatelessWidget {
  final double selected;
  final ValueChanged<double> onChanged;
  const _TipSelector({required this.selected, required this.onChanged});

  static const List<double> _presets = [5, 10, 15, 20, 25];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _presets
          .map((p) => TipChip(
                label: '${p.toInt()}%',
                isSelected: selected == p,
                onTap: () => onChanged(p),
              ))
          .toList(),
    );
  }
}

/// People counter — internal Stateless helper
class _PeopleCounter extends StatelessWidget {
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  const _PeopleCounter({
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CounterButton(icon: Icons.remove, onTap: onDecrement, enabled: count > 1),
          Column(
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A6B4A),
                ),
              ),
              Text(
                count == 1 ? 'person' : 'people',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
          _CounterButton(icon: Icons.add, onTap: onIncrement, enabled: true),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  const _CounterButton({required this.icon, required this.onTap, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF1A6B4A) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: enabled ? Colors.white : Colors.grey.shade400, size: 20),
      ),
    );
  }
}
