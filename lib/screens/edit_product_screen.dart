import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const id = 'EditProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  var _imageTextEditingController = TextEditingController();
  var product;
  final _formKey = GlobalKey<FormState>();
  var _editedProduct = Product(
      id: null,
      title: '',
      price: 0.0,
      description: '',
      imageUrl: '',
      isFavorite: false);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageTextEditingController.text.isEmpty ||
          (!_imageTextEditingController.text.startsWith('http') &&
              !_imageTextEditingController.text.startsWith('https')) ||
          (!_imageTextEditingController.text.endsWith('.png') &&
              !_imageTextEditingController.text.endsWith('jpg') &&
              !_imageTextEditingController.text.endsWith('jpeg') &&
              !_imageTextEditingController.text.endsWith('gif'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageTextEditingController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final _isValid = _formKey.currentState.validate();
    if (!_isValid) {
      return;
    }
    _formKey.currentState.save();
    var products = Provider.of<Products>(context, listen: false);
    product != null
        ? products.editProduct(product.id, _editedProduct)
        : products.addProduct(_editedProduct);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      final id = (ModalRoute.of(context).settings.arguments
          as Map<String, String>)['id'];
      product = Provider.of<Products>(context, listen: false).findById(id);
    }
    _imageTextEditingController = product != null
        ? TextEditingController(text: product.imageUrl)
        : TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: product != null ? product.title : '',
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Should not be empty';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite,
                        description: _editedProduct.description);
                  },
                ),
                TextFormField(
                  initialValue: product != null ? product.price.toString() : '',
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Price not be empty';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Not a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Not a valid price';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        price: double.parse(value),
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite,
                        description: _editedProduct.description);
                  },
                ),
                TextFormField(
                  initialValue: product != null ? product.description : '',
                  decoration: InputDecoration(labelText: 'Description'),
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  maxLines: 3,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Should not be empty';
                    }
                    if (value.length <= 10) {
                      return 'Length should be greater than 10 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        isFavorite: _editedProduct.isFavorite,
                        description: value);
                  },
                  // onFieldSubmitted: (_) {
                  //   FocusScope.of(context).requestFocus(_priceFocusNode);
                  // },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageTextEditingController.text.isEmpty
                          ? Text('Empty')
                          : Image.network(_imageTextEditingController.text),
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageTextEditingController,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Should not be empty';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Enter full URL with http/https';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('jpg') &&
                              !value.endsWith('jpeg') &&
                              !value.endsWith('gif')) {
                            return 'Enter the url of an image';
                          }

                          return null;
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (value) {
                          _saveForm();
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              imageUrl: value,
                              isFavorite: _editedProduct.isFavorite,
                              description: _editedProduct.description);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
