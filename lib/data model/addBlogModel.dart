import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;

class AddBlogModel {
  String? categoryName;
  String? topicName;
  String? description;
  String? blogImage;

  AddBlogModel({
    this.categoryName,
    this.topicName,
    this.description,
    this.blogImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'description': description,
      'topicName': topicName,
      'blogImage': blogImage,
    };
  }

  AddBlogModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      :
        categoryName = doc.data()?['categoryName'],
        description = doc.data()?['description'],
        topicName = doc.data()?['topicName'],
        blogImage = doc.data()?['blogImage'];


  AddBlogModel copyWith({
    String? categoryName,
    String? description,
    String? topicName,
    String? blogImage,
  }) {
    return AddBlogModel(
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      topicName: topicName ?? this.topicName,
      blogImage: blogImage ?? this.blogImage,
    );
  }
}
