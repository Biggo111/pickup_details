import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownMenuContainer extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String hintText;

  DropdownMenuContainer({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.hintText
  });

  @override
  _DropdownMenuContainerState createState() => _DropdownMenuContainerState();
}

class _DropdownMenuContainerState extends State<DropdownMenuContainer> {
  //String? _selectedOption;

  //final List<String> _options = ['8-10', '10-12', '12-2', '2-4', '4-6', '6-8'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 172,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                value: widget.selectedValue,
                hint: Text(widget.hintText, style: GoogleFonts.montserrat(fontSize: 10),),
                icon: const Icon(Icons.expand_more),
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: widget.onChanged,
                items: widget.items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
