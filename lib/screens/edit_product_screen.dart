import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const id = 'EditProductScreen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments != null) {
      final id = (ModalRoute.of(context).settings.arguments
          as Map<String, String>)['id'];
      final product =
          Provider.of<Products>(context, listen: false).findById(id);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add/Edit'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
