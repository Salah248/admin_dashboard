import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text(
          'Edit Product',
          style: TextStyle(color: AppColors.kWhiteColor),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomCommentCard();
        },
      ),
    );
  }
}

class CustomCommentCard extends StatelessWidget {
  CustomCommentCard({super.key});
  final TextEditingController replayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        child: Column(
          spacing: 10,
          children: [
            const Text(
              'Comment : this is user a comment',
              style: TextStyle(fontSize: 20),
            ),
            const Text('Replay : this is a replay'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                label: 'Replay',
                controller: replayController,
              ),
            ),
            CustomElevatedButtonBro(
              onPressed: () {},
              child: const Text('Replay'),
            ),
          ],
        ),
      ),
    );
  }
}
