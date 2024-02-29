import 'package:flutter/material.dart';

class HCSelect extends StatefulWidget {
  String? hintText;
  Function onChanged;
  String value;
  List<String> items;

  HCSelect({
    super.key,
    this.hintText = '',
    required this.onChanged,
    required this.value,
    required this.items,
  });

  @override
  State<StatefulWidget> createState() {
    return _HCSelectState();
  }
}

class _HCSelectState extends State<HCSelect> {
  String? _value = '';
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _value = widget.value;
      _items = widget.items;
    });
  }

  @override
  void didUpdateWidget(covariant HCSelect oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _value = widget.value;
      _items = widget.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.zero,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black38,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          hoverColor: const Color(0xFFFAFAFA),
          filled: true,
          fillColor: Colors.white,
        ),
        dropdownColor: Colors.white,
        hint: Text(
          widget.hintText!,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black26,
          ),
        ),
        value: _value,
        onChanged: (String? value) => {
          setState(() {
            _value = value;
          }),
          widget.onChanged.call(value),
        },
        items: _items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }
}
