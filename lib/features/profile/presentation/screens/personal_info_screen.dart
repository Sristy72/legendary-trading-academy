import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController _firstNameController = TextEditingController(
    text: "Albert",
  );
  final TextEditingController _lastNameController = TextEditingController(
    text: "Flores",
  );
  final TextEditingController _ageController = TextEditingController(
    text: "24",
  );

  String gender = "Male";
  String nationality = "United States";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Information",
      style: TextStyle(color: Color(0xFF1A3E74),fontWeight: FontWeight.w700, fontSize: 24
      ),
      )
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("First Name"),
                const SizedBox(height: 6),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                const Text("Last Name"),
                const SizedBox(height: 6),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                const Text("Age"),
                const SizedBox(height: 6),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                const Text("Gender"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: gender,
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                    DropdownMenuItem(value: "Other", child: Text("Other")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
        
                const Text("Nationality"),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: nationality,
                  items: const [
                    DropdownMenuItem(
                      value: "United States",
                      child: Text("United States"),
                    ),
                    DropdownMenuItem(
                      value: "Bangladesh",
                      child: Text("Bangladesh"),
                    ),
                    DropdownMenuItem(value: "India", child: Text("India")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      nationality = value!;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 181),
        
                // Custom Button use
                context.primaryButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile Saved!")),
                    );
                  },
                  text: "Save",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
