import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/custom_cached_image.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:admin_dashboard/presentaion/home/pages/bloc/cubit/products_cubit.dart';
import 'package:admin_dashboard/presentaion/home/pages/product/pages/comments/comments_view.dart';
import 'package:admin_dashboard/presentaion/home/pages/product/pages/Edit/edit_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key, required this.product});

  final ProductsEntity product;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductsCubit>();
    return SizedBox(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedImage(
                height: 250,
                width: 200,
                imageUrl:
                    product.imageUrl ??
                    'https://img.freepik.com/free-vector/power-refreshing-energy-drink-product-ad_52683-34035.jpg?t=st=1741187781~exp=1741191381~hmac=d60fd9b9c7b6a41c1d319d6ff53f7f466d3648f689eb75e575edeb7787e79be9&w=740',
              ),

              const SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    product.productName ?? 'Product Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    product.description ?? 'Product Description',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButtonBro(
                    child: const Icon(Icons.edit, color: AppColors.kWhiteColor),
                    onPressed: () {
                      AppNavigator.push(
                        context,
                        EditProductView(productsEntity: product),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    product.price ?? 'product price',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Sale ${product.sale ?? 'product sale'} %",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButtonBro(
                    child: const Icon(
                      Icons.comment,
                      color: AppColors.kWhiteColor,
                    ),
                    onPressed: () {
                      AppNavigator.push(context, const CommentsView());
                    },
                  ),
                ],
              ),
              const SizedBox(width: 20),

              CustomElevatedButtonBro(
                onPressed: () {
                  cubit.deleteProductData(
                    productId: product.productId!,
                    data: {},
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.delete, color: AppColors.kWhiteColor),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
