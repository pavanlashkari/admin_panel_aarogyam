import 'package:equatable/equatable.dart';

abstract class AddBlogState extends Equatable {
  const AddBlogState();

  @override
  List<Object> get props => [];
}

class AddBlogInitial extends AddBlogState {}

class AddBlogLoading extends AddBlogState {}

class AddBlogSuccess extends AddBlogState {}

class AddBlogFailure extends AddBlogState {
  final String error;

  const AddBlogFailure({required this.error});

  @override
  List<Object> get props => [error];
}
