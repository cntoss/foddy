import 'package:foody/function/firebase_helper.dart';
import 'package:foody/presentation/user/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../profile/profile_screen.dart';

class AddUserScreen extends StatefulWidget {
  final UserModel? user;
  const AddUserScreen({Key? key, this.user}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _address;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(
        text: widget.user != null ? widget.user!.userDisplayName : null);
    _phone = TextEditingController(
        text: widget.user != null ? widget.user!.phone : null);
    _address = TextEditingController(
        text: widget.user != null ? widget.user!.address : null);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
          appBar: AppBar(
            title:
                Text(widget.user == null ? 'Create Profile' : 'Update Profile'),
            centerTitle: true,
          ),
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person_outline)),
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Name must not be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _phone,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: 'Phone',
                                prefixIcon: Icon(Icons.phone_android_outlined)),
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Phone number must not be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _address,
                            decoration: const InputDecoration(
                                labelText: 'Address',
                                prefixIcon: Icon(Icons.location_city_outlined)),
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Address must not be empty";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    String uuId =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    UserModel _user = UserModel(
                                        id: uuId,
                                        userDisplayName: _name.text,
                                        address: _address.text,
                                        phone: _phone.text);
                                    await FirebaseHelper().updateUser(_user);
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    Navigator.pop(context, true);
                                    /* if (widget.user == null) {
          
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ProfileScreen()));
                                    } else {
                                      Navigator.pop(context, true);
                                    } */
                                  } catch (e) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  }
                                }
                              },
                              child: const Text('Submit'))
                        ],
                      ),
                    ),
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                ],
              ),
            ),
          )),
    );
  }
}
