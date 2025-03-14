import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/presentaion/home/pages/addAnAdmin/add_an_admin_view.dart';
import 'package:admin_dashboard/presentaion/home/pages/addProduct/add_product._view.dart';
import 'package:admin_dashboard/presentaion/home/pages/product/pages/products/products_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        backgroundColor: AppColors.kPrimaryColor,
        title: Text('Home', style: TextStyle(color: AppColors.kWhiteColor)),
        hideBack: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomElevatedButtonBro(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Products",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.shopping_bag,
                    size: 30,
                    color: AppColors.kWhiteColor,
                  ),
                ],
              ),
              onPressed: () => AppNavigator.push(context, const ProductsView()),
            ),
            CustomElevatedButtonBro(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Product",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.add_circle_outline,
                    size: 30,
                    color: AppColors.kWhiteColor,
                  ),
                ],
              ),
              onPressed:
                  () => AppNavigator.push(context, const AddProductView()),
            ),
            CustomElevatedButtonBro(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add An Admin",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.person_add,
                    size: 30,
                    color: AppColors.kWhiteColor,
                  ),
                ],
              ),
              onPressed:
                  () => AppNavigator.push(context, const AddAnAdminView()),
            ),
          ],
        ),
      ),
    );
  }
}
