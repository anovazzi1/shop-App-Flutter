import 'package:flutter/material.dart';
import 'package:shop_app_flutter/models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const route = "/editProductScreen";
  final String? productId;
  const EditProductScreen({this.productId, Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _urlImageController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var isLoading = false;
  var _editProduct =
      Product(id: "", title: "", description: "", imageUrl: "", price: 0);
  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  void updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void saveForm() async {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState?.save();
    setState(() {
      isLoading = true;
    });
    if (widget.productId == null) {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editProduct)
          .catchError((error) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("An Error ocurred"),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("okay"))
                ],
              );
            });
      }).then((_) {
        Navigator.of(context).pop();
        setState(() {
          isLoading = false;
        });
      });
    } else {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(
        widget.productId!,
        Product(
            id: widget.productId!,
            title: _editProduct.title,
            description: _editProduct.description,
            imageUrl: _editProduct.imageUrl,
            price: _editProduct.price,
            isFavorite: _editProduct.isFavorite),
      )
          .catchError((error) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("An Error ocurred"),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("okay"))
                ],
              );
            });
      });
      Navigator.of(context).pop();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit product"),
        actions: [
          IconButton(
              onPressed: () {
                saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                //super importante para funcionar a global key
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "Title"),
                        initialValue: initValues['title'],
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_priceFocusNode),
                        onSaved: (value) => _editProduct = Product(
                            id: _editProduct.id,
                            title: value!,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            price: _editProduct.price,
                            isFavorite: _editProduct.isFavorite),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'please provide a value';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Price"),
                        initialValue: initValues["price"],
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (value) => FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode),
                        onSaved: (value) => _editProduct = Product(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            description: _editProduct.description,
                            imageUrl: _editProduct.imageUrl,
                            price: double.parse(value!),
                            isFavorite: _editProduct.isFavorite),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return "please insert a number";
                          }
                          if (double.tryParse(value) == null) {
                            return "please insert a valid number";
                          }
                          if (double.parse(value) < 0) {
                            return "please do not inser a negative number";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Description"),
                        initialValue: initValues["description"],
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) => _editProduct = Product(
                            id: _editProduct.id,
                            title: _editProduct.title,
                            description: value!,
                            imageUrl: _editProduct.imageUrl,
                            price: _editProduct.price,
                            isFavorite: _editProduct.isFavorite),
                        validator: (value) => value!.isEmpty
                            ? "please insert some Description"
                            : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Image URL"),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _urlImageController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (value) {
                                saveForm();
                              },
                              onSaved: (value) => _editProduct = Product(
                                  id: _editProduct.id,
                                  title: _editProduct.title,
                                  description: _editProduct.description,
                                  imageUrl: value!,
                                  price: _editProduct.price,
                                  isFavorite: _editProduct.isFavorite),
                              validator: (value) => value!.isEmpty
                                  ? "please insert an image"
                                  : null,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: _urlImageController.text.isEmpty
                                ? Center(child: Text("no image to display"))
                                : FittedBox(
                                    child: Image.network(
                                        _urlImageController.text)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlFocusNode.removeListener(updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(updateImageUrl);
    if (widget.productId != null) {
      _editProduct = Provider.of<Products>(context, listen: false)
          .findById(widget.productId!);
      initValues = {
        'title': _editProduct.title,
        'description': _editProduct.description,
        'price': _editProduct.price.toString(),
      };
      _urlImageController.text = _editProduct.imageUrl;
    }

    super.initState();
  }
}
