import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';
import 'package:pattern_bloc_contact_api/pages/create_page.dart';
import 'package:pattern_bloc_contact_api/pages/update_page.dart';
import 'package:pattern_bloc_contact_api/service/http_service.dart';

import 'list_contact_state.dart';

class ListContactCubit extends Cubit<ListContactState> {
  ListContactCubit() : super(ListContactInit());

  void apiContactList() async {
    emit(ListContactLoading());
    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    print(response);
    if (response != null) {
      emit(ListContactLoaded(
          contacts: List<Contact>.from(
              jsonDecode(response).map((x) => Contact.fromJson(x)))));
    } else {
      emit(ListContactError(error: "Could not fetch contacts"));
    }
  }

  void apiContactDelete(Contact contact) async {
    emit(ListContactLoading());
    final response = await Network.DELETE(
        Network.API_DELETE + contact.id.toString(), Network.paramsEmpty());
    print(response);
    if (response != null) {
      apiContactList();
    } else {
      emit(ListContactError(error: "Could not delete contact"));
    }
  }

  void callCreatePage(BuildContext context) async {
    var results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CreatePage()));
    if (results != null) {
      BlocProvider.of<ListContactCubit>(context).apiContactList();
    }
  }

  void callUpdatePage(BuildContext context, Contact contact) async {
    var results = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => UpdatePage(contact: contact)));
    if (results != null) {
      BlocProvider.of<ListContactCubit>(context).apiContactList();
    }
  }
}
