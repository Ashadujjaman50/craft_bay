import 'package:craft_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

import '../../../../app/extensions/localization_extension.dart';
import '../../../shared/presentation/utils/validators.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  static const String name = '/create-review';

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _reviewTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Review'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameTEController,
                decoration: InputDecoration(hintText: context.l10n.firstName),
                validator: (String? value) =>
                    Validators.validateText(value, context.l10n.firstNameRequired),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameTEController,
                decoration: InputDecoration(hintText: context.l10n.lastName),
                validator: (String? value) =>
                    Validators.validateText(value, context.l10n.lastNameRequired),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reviewTEController,
                maxLines: 8,
                decoration: InputDecoration(hintText: 'Write Review'),
                validator: (String? value) =>
                    Validators.validateText(value, 'Required your review'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                    onPressed: (){},
                    child: Text('Submit', style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white),
                    ),
                ),

              ),
            ],
          ),
        ),
      ),

    );
  }


  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _reviewTEController.dispose();
    super.dispose();
  }
}