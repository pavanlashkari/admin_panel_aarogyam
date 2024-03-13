import 'dart:io';

import 'package:admin_panel_aarogyam/bloc/addBlogs/add_blog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/addBlogs/add_blog_bloc.dart';
import '../bloc/addBlogs/add_blog_event.dart';
import '../data model/addBlogModel.dart';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;

   TextEditingController _categoryController = TextEditingController();
  TextEditingController _topicController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Blog'),
      ),
      body: BlocConsumer<AddBlogBloc, AddBlogState>(
        listener: (context, state) {
          if (state is AddBlogSuccess) {
            print('addBlogSuccess');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Blog successfully added',
                  style: TextStyle(color: Colors.black),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            _categoryController.clear();
            _topicController.clear();
            _descriptionController.clear();
            setState(() {
              _pickedImage = null;
            });
           }
        },
        builder: (context, state) {
          if(state is AddBlogLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  if (_pickedImage != null) Image.file(_pickedImage!),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _topicController,
                    decoration: InputDecoration(
                      labelText: 'Topic Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter topic name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 10,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile == null) {
      return;
    }

    final pickedImageTemp = File(pickedImageFile.path);
    setState(() {
      _pickedImage = pickedImageTemp;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final category = _categoryController.text;
    final topic = _topicController.text;
    final description = _descriptionController.text;

    final blogModel = AddBlogModel(
      categoryName: category,
      topicName: topic,
      description: description,
      blogImage: _pickedImage?.path,
    );

    BlocProvider.of<AddBlogBloc>(context).add(AddBlogButtonPressed(blogModel));
  }
}
