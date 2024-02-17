import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../domain/models/product.dart';
import '../viewmodel/viewmodel.dart';
import '/presentation/resources/constants_manager.dart';
import '/presentation/resources/string_manager.dart';
import '/presentation/resources/values_manager.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  void _bind(BuildContext ctx) {
    context.read<EditProductViewModel>().prodId =
        ModalRoute.of(context)!.settings.arguments as String;
    context.read<EditProductViewModel>().onInit(context);
  }

  @override
  void dispose() {
    _scaffoldKey.currentState!.context.read<EditProductViewModel>().onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bind(context);
    return Consumer<EditProductViewModel>(builder: (context, viewModel, _) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(StringsManager.editAddProduct),
          actions: [
            IconButton(
              onPressed: () {
                viewModel.saveForm(context);
              },
              icon: const Icon(Icons.save),
            )
          ],
        ),
        body: context.watch<EditProductViewModel>().isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              )
            : Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Form(
                  key: viewModel.formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: viewModel.initialValues['title'],
                        decoration: const InputDecoration(
                            label: Text(StringsManager.title)),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => Focus.of(context)
                            .requestFocus(viewModel.priceFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.entertitle;
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          viewModel.newProduct = Product(
                              id: viewModel.newProduct.id,
                              title: newValue.toString(),
                              description: viewModel.newProduct.description,
                              imageUrl: viewModel.newProduct.imageUrl,
                              price: viewModel.newProduct.price);
                        },
                      ),
                      const SizedBox(height: AppSize.s12),
                      TextFormField(
                        initialValue: viewModel.initialValues['price'],
                        decoration: const InputDecoration(
                            label: Text(StringsManager.price)),
                        keyboardType: TextInputType.number,
                        focusNode: viewModel.priceFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => Focus.of(context)
                            .requestFocus(viewModel.descriptionFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.enterPrice;
                          }
                          if (double.tryParse(value.trim()) == null) {
                            return StringsManager.enterValidPrice;
                          }
                          if (double.parse(value.trim()) <= 0) {
                            return StringsManager.enterPriceGreaterZero;
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          viewModel.newProduct = Product(
                              id: viewModel.newProduct.id,
                              title: viewModel.newProduct.title,
                              description: viewModel.newProduct.description,
                              imageUrl: viewModel.newProduct.imageUrl,
                              price: double.parse(newValue.toString().trim()));
                        },
                      ),
                      const SizedBox(height: AppSize.s12),
                      TextFormField(
                        initialValue: viewModel.initialValues['description'],
                        decoration: const InputDecoration(
                            label: Text(StringsManager.description)),
                        keyboardType: TextInputType.multiline,
                        focusNode: viewModel.descriptionFocusNode,
                        maxLines: AppConstants.descMaxLine,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.enterDescription;
                          }
                          if (value.length < AppConstants.descCharacters) {
                            return StringsManager.enterValidDescription;
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          viewModel.newProduct = Product(
                              id: viewModel.newProduct.id,
                              title: viewModel.newProduct.title,
                              description: newValue.toString(),
                              imageUrl: viewModel.newProduct.imageUrl,
                              price: viewModel.newProduct.price);
                        },
                      ),
                      const SizedBox(height: AppSize.s12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: AppMargin.m8, right: AppMargin.m10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: AppSize.s1,
                                  color: Theme.of(context).canvasColor),
                            ),
                            width: AppSize.s100,
                            height: AppSize.s100,
                            child: viewModel.imageUrlController.text.isEmpty
                                ? Center(
                                    child: Text(
                                    StringsManager.enterImage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ))
                                : FittedBox(
                                    child: Image.network(
                                      viewModel.imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: viewModel.imageUrlController,
                              decoration: const InputDecoration(
                                  label: Text(StringsManager.imageUrl)),
                              focusNode: viewModel.imageUrlFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return StringsManager.enterImageUrl;
                                }
                                if ((!value.startsWith('http') ||
                                        !value.startsWith('https')) &&
                                    (!value.endsWith('png') ||
                                        !value.endsWith('jpg') ||
                                        !value.endsWith('jpeg'))) {
                                  return StringsManager.enterValidImageUrl;
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                viewModel.newProduct = Product(
                                    id: viewModel.newProduct.id,
                                    title: viewModel.newProduct.title,
                                    description:
                                        viewModel.newProduct.description,
                                    imageUrl: newValue.toString(),
                                    price: viewModel.newProduct.price);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
