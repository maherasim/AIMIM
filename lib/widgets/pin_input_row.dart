import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class PinInputRow extends StatefulWidget {
  final bool obscure;
  final ValueChanged<String>? onCompleted;

  const PinInputRow({super.key, this.obscure = true, this.onCompleted});

  @override
  State<PinInputRow> createState() => PinInputRowState();
}

class PinInputRowState extends State<PinInputRow> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());

  String get pin => _controllers.map((c) => c.text).join();

  void clear() {
    for (final c in _controllers) { c.clear(); }
    if (mounted) _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    for (final f in _focusNodes) { f.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, _buildBox),
    );
  }

  Widget _buildBox(int i) {
    return SizedBox(
      width: 42,
      height: 50,
      child: TextField(
        controller: _controllers[i],
        focusNode: _focusNodes[i],
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        obscureText: widget.obscure,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kPrimaryGreen, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (val) {
          if (val.length == 1 && i < 5) {
            _focusNodes[i + 1].requestFocus();
          } else if (val.isEmpty && i > 0) {
            _focusNodes[i - 1].requestFocus();
          }
          final current = pin;
          if (current.length == 6) widget.onCompleted?.call(current);
        },
      ),
    );
  }
}
