import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final TextInputType? keyboardType;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: const OutlineInputBorder()),
        keyboardType: keyboardType,
      ),
    );
  }
}

// class CustomDropdownFieldPosition extends StatelessWidget {
//   final Position value;
//   final String? labelText;
//   final List<Position> items;
//   final ValueChanged<Position?> onChanged;

//   CustomDropdownFieldPosition({
//     required this.value,
//     this.labelText,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//       child: DropdownButtonFormField<Position>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: const OutlineInputBorder(),
//         ),
//         items: items.map((Position position) {
//           return DropdownMenuItem<Position>(
//             value: position,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Text(position.displayName),
//             ),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }

// class CustomDropdownFieldChurch extends StatelessWidget {
//   final Church value;
//   final String? labelText;
//   final List<Church> items;
//   final ValueChanged<Church?> onChanged;

//   CustomDropdownFieldChurch({
//     required this.value,
//     this.labelText,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//       child: DropdownButtonFormField<Church>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: const OutlineInputBorder(),
//         ),
//         items: items.map((Church church) {
//           return DropdownMenuItem<Church>(
//             value: church,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Text(church.displayName),
//             ),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

// }

// class CustomDropdownField extends StatelessWidget {
//   final Type type;
//   final String? labelText;
//   final List<Enum> items;
//   final ValueChanged<Enum?> onChanged;
//   final String Function(String) displayString;

//   const CustomDropdownField({
//     required this.type,
//     this.labelText,
//     required this.items,
//     required this.onChanged,
//     required this.displayString,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//       child: DropdownButtonFormField<Enum>(
       
//         decoration: InputDecoration(
//           labelText: labelText,
//           border: const OutlineInputBorder(),
//         ),
//         items: items.map((Enum item) {
//           return DropdownMenuItem(
//             value: item,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: Text(displayString(item)),
//             ),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
