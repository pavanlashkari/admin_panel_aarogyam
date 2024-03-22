import 'package:admin_panel_aarogyam/bloc/addBlogs/add_blog_bloc.dart';
import 'package:admin_panel_aarogyam/screens/add_blog_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/doctor_details_widget.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Doctor Requests')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Aarogyam',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Add Blog'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => AddBlogBloc(),
                          child: const AddBlogScreen()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('request')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // or any other loading indicator
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                String documentId = snapshot.data!.docs[index].id;
                String name = data['name'] ?? '';
                String age = data['dob'] ?? '';
                return Material(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorDetails(
                          dname: name,
                          daddress: data['address'],
                          dage: age,
                          dcertificate: data['certificate'],
                          demail: data['email'],
                          dfee: data['generalFee'],
                          dimage: data['image'],
                          dpass: data['password'],
                          dstatus: data['status'],
                          dtype: data['specialist'],
                          documentId: documentId,
                        ),
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text('name :- $name'),
                        subtitle: Text('birthDate :- $age'),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
