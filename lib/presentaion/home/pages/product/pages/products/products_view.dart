import 'package:admin_dashboard/core/function/show_msg_snack.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_circle_indicator.dart';
import 'package:admin_dashboard/presentaion/home/pages/bloc/cubit/products_cubit.dart';
import 'package:admin_dashboard/presentaion/home/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Products', style: TextStyle(color: AppColors.kWhiteColor)),
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (context) => ProductsCubit()..getProducts(),
          child: BlocListener<ProductsCubit, ProductsState>(
            listener: (context, state) {
              if (state is DeleteProductDataSuccess) {
                showMsgSnackBar(context, 'Product deleted successfully');
                context.read<ProductsCubit>().getProducts(); // Refresh the product list
              } else if (state is DeleteProductDataFailure) {
                showMsgSnackBar(context, 'Failed to delete product: ${state.message}');
              }
            },
            child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading || state is DeleteProductDataLoading) {
                  return const CustomCircularIndicator();
                }

                if (state is ProductsSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return CustomProductCard(product: state.products[index]);
                      },
                    ),
                  );
                }

                if (state is ProductsFailure) {
                  return Center(child: Text(state.message));
                }

                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}