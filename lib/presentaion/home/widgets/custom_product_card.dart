import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/presentaion/home/pages/product/view/comments_view.dart';
import 'package:admin_dashboard/presentaion/home/pages/product/view/edit_product_view.dart';
import 'package:flutter/material.dart';

class CustomProductCard extends StatelessWidget {
  const CustomProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const CachedImage(
              //   height: 150,
              //   width: 200,
              //   imageUrl:
              //       'https://img.freepik.com/free-vector/power-refreshing-energy-drink-product-ad_52683-34035.jpg?t=st=1741187781~exp=1741191381~hmac=d60fd9b9c7b6a41c1d319d6ff53f7f466d3648f689eb75e575edeb7787e79be9&w=740',
              // ),
              Image.asset(
                'asset/image/128645-ORKO36-68.jpg',
                height: 150,
                width: 200,
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'Product Name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Product Description',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButtonBro(
                    child: const Icon(Icons.edit, color: AppColors.kWhiteColor),
                    onPressed: () {
                      AppNavigator.push(context, const EditProductView());
                    },
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    'product price',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text('product sale', style: TextStyle(fontSize: 16)),
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
                onPressed: () {},
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
