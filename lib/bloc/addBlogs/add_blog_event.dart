import 'package:equatable/equatable.dart';
import '../../data model/addBlogModel.dart';

abstract class AddBlogEvent extends Equatable {
  const AddBlogEvent();

  @override
  List<Object> get props => [];
}

class AddBlogButtonPressed extends AddBlogEvent {
  final AddBlogModel blogModel;

  const AddBlogButtonPressed(this.blogModel);

  @override
  List<Object> get props => [blogModel];
}
