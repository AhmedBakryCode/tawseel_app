import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool isPassword;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String)? validator; // Add a validator function

  CustomTextFormField({
    required this.isPassword,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();

    // Listen to changes in the text field to update the icon based on validation
    widget.controller.addListener(() {
      setState(() {
        // Check if the field is empty
        _isValid = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4), // Drop shadow from the Y-axis
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: widget.hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: _buildSuffixIcon(), // Build suffix icon based on validation
        ),
        onChanged: (value) {
          setState(() {
            // Revalidate when text changes
            _isValid = value.isNotEmpty;
          });
        },
      ),
    );
  }

  Widget _buildSuffixIcon() {
    // If it's a password field, show visibility toggler icon
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else {
      // Change the icon based on validation result
      return Icon(
        _isValid ? Icons.check : Icons.close,
        color: _isValid ? Colors.green : Colors.red,
      );
    }
  }
}

class DropdownTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final List<String> dropdownItems; // List of elements to show in the dropdown
  final String? Function(String)? validator;

  DropdownTextFormField({
    required this.controller,
    required this.hintText,
    required this.dropdownItems,
    this.validator,
  });

  @override
  _DropdownTextFormFieldState createState() => _DropdownTextFormFieldState();
}

class _DropdownTextFormFieldState extends State<DropdownTextFormField> {
  bool _isDropdownOpen = false;
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 4), // Drop shadow from the Y-axis
                blurRadius: 4,
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
hintStyle: TextStyle(color: Colors.grey),
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: _buildDropdownIcon(), // Build the dropdown icon
            ),
          ),
        ),
        // Show dropdown menu when _isDropdownOpen is true
        if (_isDropdownOpen) _buildDropdownMenu(),
      ],
    );
  }

  Widget _buildDropdownIcon() {
    return IconButton(
      icon: Icon(
        _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      ),
      onPressed: () {
        setState(() {
          _isDropdownOpen = !_isDropdownOpen;
        });
      },
    );
  }

  Widget _buildDropdownMenu() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true, // Ensures the list only takes necessary space
        itemCount: widget.dropdownItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.dropdownItems[index]),
            onTap: () {
              setState(() {
                _selectedItem = widget.dropdownItems[index];
                widget.controller.text = _selectedItem!;
                _isDropdownOpen = false; // Close dropdown after selection
              });
            },
          );
        },
      ),
    );
  }
}

class BirthDateField extends StatefulWidget {
  final TextEditingController controller;

  BirthDateField({required this.controller});

  @override
  _BirthDateFieldState createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  int? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  List<int> days = List<int>.generate(31, (index) => index + 1);
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> years = List<String>.generate(100, (index) => '${2024 - index}');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4), // Drop shadow from the Y-axis
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(8), // Add border radius if needed
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<int>(
              value: selectedDay,
              hint: Text("Day"),
              items: days.map((day) {
                return DropdownMenuItem<int>(
                  value: day,
                  child: Text(day.toString()),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedDay = newValue;
                  _updateController();
                });
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: selectedMonth,
              hint: Text("Month"),
              items: months.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedMonth = newValue;
                  _updateController();
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<String>(
              value: selectedYear,
              hint: Text("Year"),
              items: years.map((year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedYear = newValue;
                  _updateController();
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Update the controller with the combined birth date
  void _updateController() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      widget.controller.text = '$selectedDay $selectedMonth $selectedYear';
    }
  }
}
