import 'package:app_forca/login/login_page_controller.dart';
import 'package:app_forca/register/register_page.dart';
import 'package:app_forca/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(6, errorText: 'Password must be at least 6 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at leats one special character'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Invalid E-mail')
  ]);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  final String imagePath = 'assets/forca1.png';

  final LoginPageController _loginPageController = LoginPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SizedBox(
              width: constraints.maxWidth / 1.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth / 2,
                      height: constraints.maxHeight / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              imagePath,
                            ),
                            const Expanded(
                              child: Text(
                                'JOGO DA FORCA',
                                style: TextStyle(
                                  fontSize: 20,
                                  overflow: TextOverflow.clip,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 60,
                        child: CustomFormField(
                          hintText: 'email',
                          validator: emailValidator,
                          customController: emailController,
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            labelText: 'email',
                          ),
                          customObscureText: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 60,
                        child: CustomFormField(
                          hintText: 'password',
                          validator: passwordValidator,
                          customController: passwordController,
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            labelText: 'password',
                          ),
                          customObscureText: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                String email = emailController.text;
                                String password = passwordController.text;

                                if (_formKey.currentState!.validate()) {
                                  _loginPageController.loginUser(
                                    email,
                                    password,
                                    context,
                                  );
                                }
                              },
                              child: const Text('Login')),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text('ou'),
                          ),
                          TextButton(
                              onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterPage(),
                                    ),
                                  ),
                              child: const Text('cadastre-se')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
