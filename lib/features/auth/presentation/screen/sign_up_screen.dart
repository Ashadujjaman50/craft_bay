import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../../../shared/presentation/widgets/center_circular_progress.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_up_params.dart';
import '../providers/sign_up_provider.dart';
import '../widgets/app_logo.dart';
import 'sign_in_screen.dart';
import 'verify_otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final SignUpProvider _signUpProvider = SignUpProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _signUpProvider,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    AppLogo(),
                    const SizedBox(height: 24),
                    Text(
                      context.l10n.signUpWithEmail,
                      style: context.textTheme.titleLarge,
                    ),
                    Text(
                      context.l10n.getStartedWithYourDetails,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(hintText: context.l10n.email),
                      validator: (String? value) => Validators.validateEmail(
                        value,
                        context.l10n.emailRequired,
                        context.l10n.invalidEmail,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: context.l10n.firstName),
                      validator: (String? value) => Validators.validateText(
                        value,
                        context.l10n.firstNameRequired,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: context.l10n.lastName),
                      validator: (String? value) => Validators.validateText(
                        value,
                        context.l10n.lastNameRequired,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _phoneTEController,
                      decoration: InputDecoration(hintText: context.l10n.phone),
                      validator: (String? value) => Validators.validateText(
                        value,
                        context.l10n.phoneRequired,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _cityTEController,
                      decoration: InputDecoration(hintText: context.l10n.city),
                      validator: (String? value) => Validators.validateText(
                        value,
                        context.l10n.cityRequired,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: context.l10n.password,
                      ),
                      validator: (String? value) =>
                          Validators.validatePassword(value),
                    ),
                    const SizedBox(height: 16),

                    Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) {
                        if (signUpProvider.signUpInProgress) {
                          return CenterCircularProgress();
                        }

                        return FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Text(context.l10n.signUp),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _onTapSignInButton,
                      child: Text('Already have an account? Sign in'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    SignUpParams signUpParams = SignUpParams(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      email: _emailTEController.text.trim(),
      phone: _phoneTEController.text.trim(),
      city: _cityTEController.text.trim(),
      password: _passwordTEController.text,
    );
    final bool isSuccess = await _signUpProvider.signUp(signUpParams);

    if (isSuccess) {
      Navigator.pushNamed(context, VerifyOtpScreen.name, arguments: _emailTEController.text.trim());
    } else {
      showSnackBarMessage(context, _signUpProvider.errorMessage!);
    }
  }

  void _onTapSignInButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneTEController.dispose();
    _cityTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
