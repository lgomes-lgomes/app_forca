import 'package:app_forca/model/ext_string.dart';
import 'package:app_forca/register/register_page_controller.dart';
import 'package:app_forca/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerPageController = RegisterPageController();

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

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name is required'),
  ]);

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return Center(
            child: SizedBox(
              width: constraints.maxWidth / 1.5,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      child: CustomFormField(
                        hintText: 'email',
                        validator: emailValidator,
                        customController: emailController,
                        inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            labelText: 'email'),
                        customObscureText: false,
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
                              labelText: 'password'),
                          customObscureText: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 60,
                        child: CustomFormField(
                          hintText: 'name',
                          validator: nameValidator,
                          customController: nameController,
                          inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            labelText: 'name',
                          ),
                          customObscureText: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          String email = emailController.text;
                          String password = passwordController.text;
                          String name = nameController.text;

                          if (_formKey.currentState!.validate()) {
                            _registerPageController.registerUser(
                              email,
                              password,
                              name,
                              context,
                            );
                          }
                        },
                        child: const Text('Cadastrar'),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('voltar'),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
