import 'dart:io';

import 'package:flutter/material.dart';
import 'package:contact_app/contact/widgets/custom_elevated_button.dart';
import 'package:contact_app/contact/widgets/custom_text_form_field.dart';
import 'package:contact_app/contact/widgets/user_model.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

class AddUserBottomSheet extends StatefulWidget {
  final Function(User) onAddUser;

  const AddUserBottomSheet({Key? key, required this.onAddUser})
    : super(key: key);
  @override
  State<AddUserBottomSheet> createState() => _AddUserBottomSheetState();
}

class _AddUserBottomSheetState extends State<AddUserBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String? name;
  String? email;
  String? phone;

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Container(
      height: isKeyboardOpen ? MediaQuery.of(context).size.height * 0.8 : null,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: _image == null
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFFFF1D4),
                              ),
                            ),
                            child: Image.asset("assets/no-image.png"),
                          )
                        : Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(_image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFFFF1D4),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 120,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name == null ? "User Name" : name!,
                              style: TextStyle(
                                color: Color(0xFFFFF1D4),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(color: Color(0xFFFFF1D4), thickness: 2),
                          Expanded(
                            child: Text(
                              email == null ? "example@email.com" : email!,
                              style: TextStyle(
                                color: Color(0xFFFFF1D4),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Divider(color: Color(0xFFFFF1D4), thickness: 2),
                          Expanded(
                            child: Text(
                              phone == null ? "+200000000000" : phone!,
                              style: TextStyle(
                                color: Color(0xFFFFF1D4),
                                fontSize:18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                controller: _nameController,
                hintText: "Enter User Name",
                onChanged: (String value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                controller: _emailController,
                hintText: "Enter User Email ",
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              CustomTextFormField(
                controller: _phoneController,
                hintText: "Enter User Phone",
                keyboardType: TextInputType.phone,
                onChanged: (String value) {
                  setState(() {
                    phone = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
                  if (!phoneRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              CustomElevatedButton(
                text: 'Enter user',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    User newUser = User(
                      name: name!,
                      email: email!,
                      phone: phone!,
                      image: _image,
                    );
                    widget.onAddUser(newUser);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
