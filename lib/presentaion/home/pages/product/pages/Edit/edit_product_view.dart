import 'package:admin_dashboard/core/function/pick_image.dart';
import 'package:admin_dashboard/core/helper/navigation/app_navigation.dart';
import 'package:admin_dashboard/core/resources/app_colors.dart';
import 'package:admin_dashboard/core/resources/constants.dart';
import 'package:admin_dashboard/core/widgets/app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_cached_image.dart';
import 'package:admin_dashboard/core/widgets/custom_circle_indicator.dart';
import 'package:admin_dashboard/core/widgets/custom_elevated_button.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:admin_dashboard/presentaion/home/home_view.dart';
import 'package:admin_dashboard/presentaion/home/pages/bloc/cubit/products_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.productsEntity});

  final ProductsEntity productsEntity;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  String? selectedCategory;
  String? sale;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _oldPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  Uint8List? _selectedImage;
  String _imageName = 'imageName';

  @override
  void initState() {
    selectedCategory = widget.productsEntity.category ?? 'collections';
    sale = widget.productsEntity.sale ?? '10';
    _productNameController.text =
        widget.productsEntity.productName ?? "product name";
    _priceController.text = widget.productsEntity.price ?? "price";
    _oldPriceController.text = widget.productsEntity.oldPrice ?? "old price";
    _productDescriptionController.text =
        widget.productsEntity.description ?? "description";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is EditProductSuccess) {
            AppNavigator.pushAndRemove(context, const HomeView());
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProductsCubit>();
          return Scaffold(
            appBar: const BasicAppbar(
              backgroundColor: AppColors.kPrimaryColor,
              title: Text(
                'Edit Product',
                style: TextStyle(color: AppColors.kWhiteColor),
              ),
            ),
            body:
                state is EditProductLoading
                    ? const CustomCircularIndicator()
                    : Padding(
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
                                        selectedCategory =
                                            value ?? 'collections';
                                      });
                                    },
                                    dropdownMenuEntries:
                                        kDrop
                                            .map(
                                              (DropMenu menu) =>
                                                  DropdownMenuEntry(
                                                    value: menu.category,
                                                    label: menu.label,
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
                                    child:
                                        _selectedImage != null
                                            ? Image.memory(
                                              _selectedImage!,
                                              width: 300,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            )
                                            : CachedImage(
                                              width: 300,
                                              height: 200,
                                              imageUrl:
                                                  widget
                                                      .productsEntity
                                                      .imageUrl ??
                                                  'image error',
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
                                        onPressed: () async {
                                          await pickImage().then((value) {
                                            if (value != null) {
                                              setState(() {
                                                _imageName =
                                                    value.files.first.name;
                                                Uint8List? bytes =
                                                    value.files.first.bytes;
                                                _selectedImage = bytes;
                                              });
                                            }
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      CustomElevatedButtonBro(
                                        onPressed:
                                            state is UploadImageLoading
                                                ? null
                                                : () async {
                                                  if (_selectedImage != null) {
                                                    cubit.uploadeImage(
                                                      bucketName: 'images',
                                                      image: _selectedImage!,
                                                      imageName: _imageName,
                                                    );
                                                  }
                                                },
                                        child: const Icon(
                                          Icons.upload_file_rounded,
                                          color: AppColors.kWhiteColor,
                                        ),
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
                          CustomTextField(
                            label: 'Old Price',
                            controller: _oldPriceController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}'),
                              ),
                            ],
                            label: 'Price',
                            controller: _priceController,
                            onChanged: (value) {
                              _calculateSale(value);
                            },
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
                              onPressed: () async {
                                cubit.editProduct(
                                  data: {
                                    "product_name": _productNameController.text,
                                    "price": _priceController.text,
                                    "old_price": _oldPriceController.text,
                                    "sale": sale,
                                    "description":
                                        _productDescriptionController.text,
                                    "category": selectedCategory,
                                    "image_url":
                                        cubit.imageUrl ??
                                        widget.productsEntity.imageUrl
                                  },
                                  productId: widget.productsEntity.productId!,
                                );
                              },
                              child: const Text('Update'),
                            ),
                          ),
                        ],
                      ),
                    ),
          );
        },
      ),
    );
  }

  void _calculateSale(String value) {
    try {
      if (value.isNotEmpty && _oldPriceController.text.isNotEmpty) {
        double x =
            (double.parse(_oldPriceController.text) - double.parse(value)) /
            double.parse(_oldPriceController.text) *
            100;

        setState(() {
          sale = x.round().toString();
        });
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
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
