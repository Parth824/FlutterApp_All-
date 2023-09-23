import 'package:flutter/material.dart';
import 'package:music_app_my/screens/main_screen.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  // Create variables to store the user's profile information.
  String _name = '';
  String _email = '';
  String _bio = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ));
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Add a profile picture field.

            // Add a name field.
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              initialValue: _name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),

            // Add an email field.
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              initialValue: _email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address.';
                }
                if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),

            // Add a bio field.
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Bio',
              ),
              initialValue: _bio,
              maxLines: 5,
              onSaved: (value) {
                _bio = value!;
              },
            ),

            // Add a submit button.
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save the user's profile information.
                  // ...

                  // Close the profile edit page.
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
