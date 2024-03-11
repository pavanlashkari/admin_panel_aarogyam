import 'dart:async';
import 'dart:io';

import 'package:admin_panel_aarogyam/bloc/addBlogs/add_blog_event.dart';
import 'package:admin_panel_aarogyam/bloc/addBlogs/add_blog_state.dart';
import 'package:admin_panel_aarogyam/data%20model/addBlogModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';



class AddBlogBloc extends Bloc<AddBlogEvent, AddBlogState> {
  AddBlogBloc() : super(AddBlogInitial()) {
    on<AddBlogButtonPressed>((event, emit) async{
        try{
          print('AddBlogButtonPressed');
          emit(AddBlogLoading());
          String uidPhoto = const Uuid().v4();
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('BlogsImage')
              .child('$uidPhoto.jpg');
          await storageRef.putFile(File(event.blogModel.blogImage!));
          final medImgUrl = await storageRef.getDownloadURL();
          await _addBlogToFirestore(AddBlogModel(
            blogImage: medImgUrl,
            description: event.blogModel.description,
            categoryName: event.blogModel.categoryName,
            topicName: event.blogModel.topicName,
          ));
          emit(AddBlogSuccess());
          print('bloc success');
        }catch(e){
          emit(AddBlogFailure(error: e.toString()));
        }
    });
  }
  Future<void> _addBlogToFirestore(AddBlogModel blogModel) async {
    await FirebaseFirestore.instance
        .collection("Blogs")
        .doc()
        .set(blogModel.toMap());
  }
}
