import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Manage Users',
          ),
          centerTitle: true,
          toolbarHeight: 60,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Users',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 500,
                  width: 600,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                        0.6,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    // inside the <> you enter the type of your stream
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              color: Colors.white70,
                              child: ListTile(
                                title: Text(
                                  'Name: ' +
                                      snapshot.data!.docs[index].get('name'),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  'Address: ' +
                                      snapshot.data!.docs[index]
                                          .get('address') +
                                      '\nContact: ' +
                                      snapshot.data!.docs[index].get('contact'),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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
                        return const SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
