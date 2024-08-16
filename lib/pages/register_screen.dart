import 'package:campmart/pages/login_screen.dart';
import 'package:campmart/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/size.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../bloc/register_bloc/register_event.dart';
import '../bloc/register_bloc/register_state.dart';
import '../repo/auth_repo.dart';
import '../utils/theme.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(authRepo: AuthRepo()),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.padding! * 0.035),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                Icon(
                  Icons.campaign,
                  size: SizeConfig.padding! * 0.1,
                  color: primaryColor,
                ),
                Text(
                  'Camp Mart',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: shadowColor,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.padding! * 0.05),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            Text(
                              'Full Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "John Doe",
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            Text(
                              'Username',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "username",
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            Text(
                              'Email Address',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email address';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                hintText: "john.doe@gmail.com",
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            Text(
                              'Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              obscureText: obscureText,
                              decoration: InputDecoration(
                                hintText: "******",
                                suffixIcon: IconButton(
                                  icon: obscureText
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.05,
                            ),
                            BlocConsumer<RegisterBloc, RegisterState>(
                              listener: (context, state) {
                                if (state is RegisterSuccess) {
                                  showToast(
                                    title: "User registered successfully",
                                    color: Colors.green,
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                } else if (state is RegisterFailure) {
                                  showToast(
                                    title: "Registered Failed",
                                    color: Colors.red,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is RegisterLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CustomButton(
                                        title: "Continue",
                                        onPressed: () {
                                          final name = _nameController.text;
                                          final username =
                                              _usernameController.text;
                                          final email = _emailController.text;
                                          final password =
                                              _passwordController.text;

                                          if (_formKey.currentState!
                                              .validate()) {
                                            context.read<RegisterBloc>().add(
                                                  RegisterUserEvent(
                                                    name: name,
                                                    username: username,
                                                    email: email,
                                                    password: password,
                                                  ),
                                                );
                                          } else {
                                            showToast(
                                              title:
                                                  "Please fill all the fields",
                                              color: Colors.grey,
                                            );
                                          }
                                        },
                                        width: 1,
                                        height: 0.05,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              color: Colors.white,
                                            ),
                                        borderRadius: 12,
                                      );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                Text(
                  "Need to Help?",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
