import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/resources/constants.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  String selectedCategory = 'Collections';
  String sale = '10';
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    DropdownMenu(
                      initialSelection: selectedCategory,
                      onSelected: (String? value) {
                        setState(() {
                          selectedCategory = value ?? 'Collections';
                        });
                      },
                      dropdownMenuEntries:
                          kCategories
                              .map(
                                (category) => DropdownMenuEntry(
                                  value: category,
                                  label: category,
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [const Text('Sale'), Text('$sale %')],
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'asset/image/128645-ORKO36-68.jpg',
                        height: 250,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CustomElevatedButtonBro(
                          child: const Icon(
                            Icons.image,
                            color: AppColors.kWhiteColor,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 10),
                        CustomElevatedButtonBro(
                          child: const Icon(
                            Icons.upload_file_rounded,
                            color: AppColors.kWhiteColor,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
            CustomTextField(
              label: 'Product Name',
              controller: _productNameController,
            ),
            const SizedBox(height: 10),
            CustomTextField(label: 'Price', controller: _priceController),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Old Price',
              controller: _oldPriceController,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Product Description',
              controller: _productDescriptionController,
            ),
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomElevatedButtonBro(
                onPressed: () {},
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _productNameController.dispose();
    _priceController.dispose();
    _oldPriceController.dispose();
    _productDescriptionController.dispose();
    super.dispose();
  }
}