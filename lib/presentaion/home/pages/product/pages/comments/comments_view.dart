import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_circle_indicator.dart';
import 'package:admin_dashboard/presentaion/home/pages/bloc/cubit/products_cubit.dart';
import 'package:admin_dashboard/presentaion/home/widgets/custom_comment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocProvider(
        create: (context) => ProductsCubit()..getComments(),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is CommentsLoading || state is ReplayCommentLoading) {
              return const CustomCircularIndicator();
            }
            if (state is CommentsSuccess) {
              return ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  return CustomCommentCard(
                    commentsEntity: state.comments[index],
                  );
                },
              );
            }
            if (state is ReplayCommentSuccess) {
              // Instead of redirecting to HomeView, refresh the comments
              context.read<ProductsCubit>().getComments();
              return const CustomCircularIndicator(); // Show loading while refreshing
            }

            if (state is CommentsFailure) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
