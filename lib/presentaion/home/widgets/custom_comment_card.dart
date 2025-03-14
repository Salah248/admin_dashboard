import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:admin_dashboard/presentaion/home/pages/bloc/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCommentCard extends StatefulWidget {
  const CustomCommentCard({super.key, required this.commentsEntity});

  final CommentsEntity commentsEntity;

  @override
  State<CustomCommentCard> createState() => _CustomCommentCardState();
}

class _CustomCommentCardState extends State<CustomCommentCard> {
  final TextEditingController _replayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductsCubit>();
    return SizedBox(
      height: 200,
      child: Card(
        child: Column(
          spacing: 10,
          children: [
            Text(
              widget.commentsEntity.comment ??
                  'Comment : this is user a comment',
              style: const TextStyle(fontSize: 20),
            ),
            Text(widget.commentsEntity.replay ?? 'Replay : this is a replay'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                label: 'Replay',
                controller: _replayController,
              ),
            ),
            CustomElevatedButtonBro(
              onPressed: () {
                if (_replayController.text.isNotEmpty) {
                  cubit.addRepalyComment(
                    data: {"replay": _replayController.text},
                    commentId: widget.commentsEntity.id!,
                    productId: widget.commentsEntity.forProduct!,
                  );
                  // Clear the text field after submitting
                  _replayController.clear();
                }
              },
              child: const Text('Replay'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _replayController.dispose();
    super.dispose();
  }
}
