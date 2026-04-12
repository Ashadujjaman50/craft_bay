import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/utils/validators.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/create_review_params.dart';
import '../providers/create_review_provider.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId});

  static const String name = '/create-review';
  final String productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _reviewTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CreateReviewProvider _createReviewProvider = CreateReviewProvider();


  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _createReviewProvider,
      child: Scaffold(
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
                Text("Your Rating", style: context.textTheme.bodyLarge),
                const SizedBox(height: 8),

                buildStarRating(),

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
                    onPressed: _onTapReviewButton,
                    child: Text(
                      'Submit',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapReviewButton() async {
    if (_formKey.currentState!.validate()) {
      CreateReviewParams createReviewParams = CreateReviewParams(
        product: widget.productId,
        comment: _reviewTEController.text.trim(),
        rating: _rating.toString(),
      );

      final bool isSuccess = await _createReviewProvider.addNewReview(createReviewParams);

      if(isSuccess){
        Navigator.pop(context);
      }
      else{
        showSnackBarMessage(context, _createReviewProvider.errorMessage!);
      }

    }
  }


  Widget buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1.0;
            });
          },
          icon: Icon(
            Icons.star,
            color: index < _rating ? Colors.amber : Colors.grey,
            size: 32,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _reviewTEController.dispose();
    super.dispose();
  }
}
