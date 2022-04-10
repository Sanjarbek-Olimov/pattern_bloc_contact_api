import 'package:equatable/equatable.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';

abstract class UpdateContactState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateContactInit extends UpdateContactState {}

class UpdateContactLoading extends UpdateContactState {}

class UpdateContactLoaded extends UpdateContactState {
  final Contact contact;
  UpdateContactLoaded({required this.contact});
}

class UpdateContactError extends UpdateContactState {
  final error;

  UpdateContactError({this.error});
}
