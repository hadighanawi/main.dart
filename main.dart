import 'package:flutter/material.dart';

void main() {
  runApp(ContactFormApp());
}

class ContactFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleContactForm(),
    );
  }
}

class SimpleContactForm extends StatefulWidget {
  @override
  _SimpleContactFormState createState() => _SimpleContactFormState();
}

class _SimpleContactFormState extends State<SimpleContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedGender = '';
  String _preferredContactMethod = 'Email';
  bool _subscribeToNewsletter = false;
  String _errorMessage = '';
  String _submittedInfo = '';
  final List<String> _contactMethods = ['Email', 'Phone', 'SMS'];
  void _submitForm() {
    setState(() {
      _errorMessage = '';
      _submittedInfo = '';

      String name = _nameController.text.trim();
      String email = _emailController.text.trim();

      if (name.isEmpty ||
          email.isEmpty ||
          _selectedGender.isEmpty ||
          _preferredContactMethod.isEmpty) {
        _errorMessage = 'Please fill out all fields';
        return;
      }
      if (!email.contains('@') || !email.contains('.')) {
        _errorMessage = 'Please enter a valid email address';
        return;
      }
      _submittedInfo =
      'Name: $name\nEmail: $email\nGender: $_selectedGender\nPreferred Contact Method: $_preferredContactMethod\nSubscribed to Newsletter: ${_subscribeToNewsletter ? 'Yes' : 'No'}';
    });
  }
  void _clearForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _selectedGender = '';
      _preferredContactMethod = 'Email';
      _subscribeToNewsletter = false;
      _errorMessage = '';
      _submittedInfo = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 10),

              // Email field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              const Text('Gender:', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                  Radio(
                    value: 'Other',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  const Text('Other'),
                ],
              ),
              SizedBox(height: 10),
              Text('Preferred Contact Method:', style: TextStyle(fontSize: 16)),
              DropdownButton<String>(
                value: _preferredContactMethod,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    _preferredContactMethod = newValue!;
                  });
                },
                items: _contactMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: _subscribeToNewsletter,
                    onChanged: (bool? value) {
                      setState(() {
                        _subscribeToNewsletter = value!;
                      });
                    },
                  ),
                  Text('Subscribe to newsletter'),
                ],
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _clearForm,
                    child: Text('Clear'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),

              if (_submittedInfo.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  color: Colors.lightBlueAccent.shade100,
                  child: Text(
                    _submittedInfo,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}