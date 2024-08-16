import 'dart:developer';
import 'dart:io';

import 'package:campmart/bloc/add_product_bloc/add_product_bloc.dart';
import 'package:campmart/pages/cart_screen.dart';
import 'package:campmart/pages/proudct_list_view.dart';
import 'package:campmart/utils/size.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/theme.dart';
import '../bloc/bottom_nav_bar_bloc/home_page_bloc.dart';
import '../bloc/fetch_product_bloc/fetch_product_bloc.dart';
import '../widgets/custom_button.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({
    super.key,
  });

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  DateTime? backButtonPressTime;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          switch (state) {
            case Page1():
              return ProductGrid();
            case Page2():
              return const CartScreen();
            default:
              return const SizedBox();
          }
        },
      ),
      /* floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return state is Page1
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProductBottomSheet(),
                      ),
                    );
                  },
                  label: const Text("Add"),
                  icon: const Icon(Icons.add),
                )
              : const SizedBox.shrink();
        },
      ),*/
      bottomNavigationBar: Container(
        height: Platform.isAndroid ? 60 : null,
        margin: Platform.isAndroid
            ? const EdgeInsets.only(
                left: 20,
                bottom: 20,
                right: 20,
              )
            : null,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            showSelectedLabels: true,
            unselectedItemColor: shadowColor,
            showUnselectedLabels: false,
            selectedItemColor: primaryColor,
            currentIndex: _selectedIndex,
            onTap: (currentIndex) {
              _selectedIndex = currentIndex;
              context
                  .read<HomePageBloc>()
                  .add(HomePageClickEvent(id: _selectedIndex));
              log('Current Index: $_selectedIndex');
              (context as Element).markNeedsBuild();
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddProductBottomSheet extends StatefulWidget {
  const AddProductBottomSheet({super.key});

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  XFile? pickedFile;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Product Name",
                      hintText: "Enter Product Name",
                    ),
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter product name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Price",
                      hintText: "Enter Price",
                    ),
                    controller: _priceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter price";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Product Category",
                      hintText: "Enter Product Category",
                    ),
                    controller: _categoryController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter product category";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Product Description",
                      hintText: "Enter Product Description",
                    ),
                    controller: _descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter product description";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Location",
                      hintText: "Enter Location",
                    ),
                    controller: _locationController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter location";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  DottedBorder(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                    radius: const Radius.circular(8),
                    child: TextButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: [
                            'jpg',
                            'jpeg',
                            'png',
                            'doc',
                          ],
                        );
                        if (result != null) {
                          String? filePath = result.files.first.path;
                          if (filePath != null) {
                            setState(() {
                              pickedFile = XFile(filePath);
                            });
                          }
                        } else {
                          // User canceled the picker
                          print('User canceled the picker');
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            "+ Upload image [ jpeg/png ]",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  pickedFile != null
                      ? Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                pickedFile!.path.split('/').last.length > 15
                                    ? '${pickedFile!.path.split('/').last.substring(0, 15)}.${pickedFile!.path.split('/').last.split('.').last.substring(0, 3)}'
                                    : pickedFile!.path.split('/').last,
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  pickedFile = null;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(height: SizeConfig.screenHeight! * 0.02),
                  BlocConsumer<AddProductBloc, AddProductState>(
                    listener: (context, state) {
                      if (state is AddProductAuthState) {
                      } else if (state is AddProductFailure) {
                        const Center(child: Text("Error Occured"));
                      } else if (state is AddProductSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Product Added"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.read<FetchProductBloc>().add(FetchProduct());
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return state is AddProductLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              title: "Add",
                              width: double.infinity,
                              borderRadius: 30,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AddProductBloc>().add(
                                        AddProduct(
                                          productName: _nameController.text,
                                          productPrice: _priceController.text,
                                          productCategory:
                                              _categoryController.text,
                                          productDescription:
                                              _descriptionController.text,
                                          productLocation:
                                              _locationController.text,
                                          document: pickedFile,
                                        ),
                                      );
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
