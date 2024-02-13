import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var nameController = new TextEditingController();
  var priceController = new TextEditingController();
  var descController = new TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? _image;
  get data => null;

  String dropdownvalue = 'Tech';
  var items = [
    'Tech',
    'Fashion',
    'Grocery',
    'Beauty',
    'General'
  ];
  @override
  Widget build(BuildContext context) {
    showLoaderDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Uploading...")),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: Colors.blue,
            title: const Text('Manage Products',style: TextStyle(color: Colors.black),),
            toolbarHeight: 60,
            centerTitle: true,
          ),
          body: Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            height: 650,
                            width: 600,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  0.6,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                const Text(
                                  'Insert Product Details',
                                  style: TextStyle(fontSize: 28),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 10),
                                  height: 150,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: _image == null
                                                ? const Text('No image selected.')
                                                : Image.file(_image!),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            final image = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.gallery);
                                            if (image != null) {
                                              _image = File(image.path);
                                              setState(() {});
                                            }
                                          },
                                          child: Text('Select image'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 80,
                                    ),
                                    const Text(
                                      'Choose Category',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    DropdownButton(
                                      focusColor: Colors.transparent,
                                      // Initial Value
                                      value: dropdownvalue,
                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons.arrow_drop_down_circle_rounded),
                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: nameController,
                                  maxLength: 50,
                                  decoration: const InputDecoration(
                                      labelText: 'Product Name',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber))),
                                ),
                                TextFormField(
                                  controller: priceController,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: 'Product Price',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.amber))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: descController,
                                    maxLength: 1000,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: const InputDecoration(
                                        labelText: 'Product description',
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.amber))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (nameController.text.isNotEmpty &&
                                        priceController.text.isNotEmpty &&
                                        descController.text.isNotEmpty &&
                                        _image.toString().isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirmation"),
                                            content: const Text(
                                                "Are you sure you want to submit these details?"),
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.amber),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      color: Colors.amber),
                                                ),
                                                onPressed: () async {
                                                  //Upload image file to Firebase Storage
                                                  showLoaderDialog(context);
                                                  var imageName = DateTime.now()
                                                      .millisecondsSinceEpoch
                                                      .toString();
                                                  var storageRef = FirebaseStorage
                                                      .instance
                                                      .ref()
                                                      .child(
                                                          'images/$imageName.jpg');
                                                  var uploadTask =
                                                      storageRef.putFile(_image!);
                                                  var downloadUrl =
                                                      await (await uploadTask)
                                                          .ref
                                                          .getDownloadURL();

                                                  firestore
                                                      .collection(dropdownvalue)
                                                      .add({
                                                    "Name": nameController.text,
                                                    "Price": priceController.text,
                                                    "Description":
                                                        descController.text,
                                                    // Add image reference to document
                                                    "Image":
                                                        downloadUrl.toString()
                                                  });
                                                  Navigator.pop(context);
                                                  Navigator.of(context).pop();
                                                  nameController.clear();
                                                  priceController.clear();
                                                  descController.clear();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: const Text(
                                    "Add Product",
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
