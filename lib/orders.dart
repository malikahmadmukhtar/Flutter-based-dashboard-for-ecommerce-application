import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String username = '';
  late String price='';
  String image = '';
  String productname = '';
  String quantity = '';
  String method = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"), // <-- BACKGROUND IMAGE
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.blue,
              title: const Text('Manage Orders',
                  style: TextStyle(color: Colors.black)),
              centerTitle: true),
          body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Orders',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      height: 500,
                                      width: 500,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(
                                            0.6,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance
                                            .collection("ordermanager")
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  elevation: 3,
                                                  color: Colors.white60,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        username = snapshot
                                                            .data!.docs[index]
                                                            .get('username');
                                                        price = snapshot
                                                            .data!.docs[index]
                                                            .get('price');
                                                        quantity = snapshot
                                                            .data!.docs[index]
                                                            .get('quantity');
                                                        image = snapshot
                                                            .data!.docs[index]
                                                            .get('image');
                                                        method = snapshot
                                                            .data!.docs[index]
                                                            .get('method');
                                                        productname = snapshot
                                                            .data!.docs[index]
                                                            .get('productname');
                                                      });
                                                    },
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors.click,
                                                      child: ListTile(
                                                        textColor: Colors.black,
                                                        title: Text(
                                                          'Ordered By: ' +
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      'username'),
                                                        ),
                                                        subtitle: Text(
                                                          'Product: ' +
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get(
                                                                      'productname'),
                                                        ),
                                                        trailing: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  showAlertDialog(
                                                                      BuildContext
                                                                          context) {
                                                                    // set up the buttons
                                                                    Widget
                                                                        cancelButton =
                                                                        ElevatedButton(
                                                                      child: const Text(
                                                                          "Cancel"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(
                                                                                context,
                                                                                rootNavigator: true)
                                                                            .pop();
                                                                      },
                                                                    );
                                                                    Widget
                                                                        yesButton =
                                                                        ElevatedButton(
                                                                      child: const Text(
                                                                          "Yes"),
                                                                      onPressed:
                                                                          () async {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .runTransaction((Transaction
                                                                                myTransaction) async {
                                                                          await myTransaction.delete(snapshot
                                                                              .data!
                                                                              .docs[index]
                                                                              .reference);
                                                                        });
                                                                        Navigator.of(
                                                                                context,
                                                                                rootNavigator: true)
                                                                            .pop();
                                                                      },
                                                                    );
                                                                    // set up the AlertDialog
                                                                    AlertDialog
                                                                        alert =
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          "Confirmation"),
                                                                      content:
                                                                          const Text(
                                                                              "Would you like to Remove this Order as Delivered?"),
                                                                      actions: [
                                                                        cancelButton,
                                                                        yesButton,
                                                                      ],
                                                                    );
                                                                    // show the dialog
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return alert;
                                                                      },
                                                                    );
                                                                  }

                                                                  showAlertDialog(
                                                                      context);
                                                                },
                                                                icon: Icon(Icons
                                                                    .delete)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return const Text('Error');
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Container(
                        height: 600,
                        width: 600,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.6,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(image),
                                            fit: BoxFit.cover),
                                        color: Colors.transparent),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                          bottom: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Product: $productname',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Ordered by: $username',
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  width: 600,
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20, bottom: 20, right: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Quantity: $quantity',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Method of Delivery: $method',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Total Price: $price',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
