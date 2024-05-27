import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/drawer/productModel.dart';
import 'package:flutter_application_1/service/drawerService/productService.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AdminProductScreen extends StatelessWidget {
  
  final List products =
      []; // Example list of products, replace with actual data source

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Products'),
      ),
      body: products.isEmpty
          ? Center(child: Text('No data available'))
          : ListView.builder(
              itemCount:
                  products.length, // Replace with actual number of products
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    // Replace with product image
                    backgroundColor: Colors.grey, // Placeholder color
                    radius: 30,
                  ),
                  title: Text(
                      'Product Title $index'), // Replace with actual product title
                  subtitle: Text(
                      'Product Description $index'), // Replace with actual product description
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Handle delete action
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddProductDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddProductDialog extends StatefulWidget {
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
   final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref();
  File? imageFile;
  final TextEditingController _productNameController = TextEditingController();
  String? _category;
  File? _productImage;
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _productImage = File(pickedImage.path);
      });
    }
  }

 

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Handle image upload and get the URL
     String imageUrl = '';

      if (imageFile != null) {
        final storageResult = await storageRef
            .child('profile_images/${_productNameController.text}')
            .putFile(imageFile!);
        imageUrl = await storageResult.ref.getDownloadURL();
      }

      // Handle product save action
      ProductService productService = ProductService();
      ProductModelClass product = ProductModelClass(
        name: _productNameController.text,
        category: _category ?? '',
        img: imageUrl,
      );
      print(product.name);
      print(imageUrl);

      // Save the product (e.g., send to backend or add to local list)
      await productService.createProduct(product);

      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: _category,
                items: ['Fruits', 'Vegetables'].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _category = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _productImage == null
                  ? Text('No image selected.')
                  : Image.file(_productImage!, height: 100, width: 100),
              SizedBox(height: 10),
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Pick Image'),
                onPressed: _pickImage,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
