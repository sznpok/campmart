import 'package:campmart/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc/login_bloc.dart';
import '../bloc/login_bloc/login_event.dart';
import '../bloc/login_bloc/login_state.dart';
import '../repo/auth_repo.dart';
import '../utils/size.dart';
import '../utils/theme.dart';
import '../widgets/custom_button.dart';
import 'bottom_nav_bar_screen.dart';

@override
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(authRepository: AuthRepo()),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.padding! * 0.035),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.05,
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
                              decoration: InputDecoration(
                                isDense: true,
                                //prefix: Text("+977"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.padding!),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Email Address",
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              obscureText: obscureText,
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.padding!),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Password",
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.01,
                            ),
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.transparent,
                              child: Text(
                                'Forgot Password ?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: textSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'User logged in successfully!')),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBarScreen(),
                                    ),
                                  );
                                  // Navigate to another page or perform other actions
                                } else if (state is LoginFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Error: ${state.error}')),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return state is LoginLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : CustomButton(
                                        title: "Log In",
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final email = _emailController.text;
                                            final password =
                                                _passwordController.text;
                                            context.read<LoginBloc>().add(
                                                  LoginUserEvent(
                                                    email: email,
                                                    password: password,
                                                  ),
                                                );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Please fill all the fields'),
                                              ),
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
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.05,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User?",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: textSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up Now",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
