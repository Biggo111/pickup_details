import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerContainer extends StatefulWidget {
  @override
  _DatePickerContainerState createState() => _DatePickerContainerState();
}

class _DatePickerContainerState extends State<DatePickerContainer> {
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd MMM, yyyy').format(picked);
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    _dateController.text = _selectedDate != null
        ? DateFormat('dd MMM, yyyy').format(_selectedDate!)
        : '';
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

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
            child: TextField(
              controller: _dateController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Select Date',
                hintStyle: GoogleFonts.montserrat(fontSize: 13),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ],
      ),
    );
  }
}
