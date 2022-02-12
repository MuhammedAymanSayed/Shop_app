// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:max_shop_app_12_1_22/Models/products.dart';
import 'package:max_shop_app_12_1_22/Models/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen({Key? key}) : super(key: key);
  EditProductScreen.special(
      {required this.id, required this.isEditing, Key? key})
      : super(key: key);
  String id = 'p4';
  bool isEditing = false;

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _textController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final addProduct = Provider.of<Products>(context, listen: false);
    //final Product _editProduct = addProduct.findById(widget.id);
    Future<void> _saveForm() async {
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return;
      }
      _form.currentState!.save();
      setState(() {
        isLoading = true;
      });
      if (widget.isEditing) {
        await addProduct.updateProduct(
            addProduct.findById(widget.id).id, _product);
        widget.isEditing = false;
      } else {
        await addProduct.addProduct(_product);
      }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          _saveForm();
        },
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: widget.isEditing
                          ? addProduct.findById(widget.id).title
                          : null,
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _product = Product(
                          id: DateTime.now().toString(),
                          title: value.toString(),
                          description: _product.description,
                          price: _product.price,
                          imageUrl: _product.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: widget.isEditing
                          ? addProduct.findById(widget.id).price.toString()
                          : null,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.tryParse(value)! <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: _product.description,
                          price: double.parse(value.toString()),
                          imageUrl: _product.imageUrl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: widget.isEditing
                          ? addProduct.findById(widget.id).description
                          : null,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid decription';
                        }
                        return null;
                      },
                      maxLines: 4,
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: value.toString(),
                          price: _product.price,
                          imageUrl: _product.imageUrl,
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.isEditing
                                ? addProduct.findById(widget.id).imageUrl
                                : null,
                            maxLines: 4,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid ImageURL0';
                              }
                              if (value.startsWith('http:') &&
                                  value.startsWith('https:')) {
                                return 'Please enter a valid ImageURL1';
                              }
                              if (value.endsWith('jgp') &&
                                  value.endsWith('png') &&
                                  value.endsWith('jpeg')) {
                                return 'Please enter a valid ImageURL2';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            controller:
                                widget.isEditing ? null : _textController,
                            onFieldSubmitted: (x) {
                              setState(() {});
                            },
                            onSaved: (value) {
                              _product = Product(
                                id: _product.id,
                                title: _product.title,
                                description: _product.description,
                                price: _product.price,
                                imageUrl: value.toString(),
                              );
                            },
                          ),
                        ),
                        _textController.text.isEmpty && !widget.isEditing
                            ? const Card(
                                elevation: 5,
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Text('Enter a URL'),
                                    )),
                              )
                            : InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: const Text('Your Image :'),
                                          content: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                100,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                50,
                                            child: Image.network(
                                              widget.isEditing
                                                  ? addProduct
                                                      .findById(widget.id)
                                                      .imageUrl
                                                  : _textController.text,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _textController.clear();
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Confirm'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Card(
                                  elevation: 5,
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      widget.isEditing
                                          ? addProduct
                                              .findById(widget.id)
                                              .imageUrl
                                          : _textController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
