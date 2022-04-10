import 'package:flutter/material.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';

import 'item_of_contacts.dart';

Widget viewOfHome(List<Contact> contacts, bool isLoading){
  return Stack(
    children: [
      ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return itemOfContacts(context, contacts[index]);
        },
      ),
      isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : Container(),
    ],
  );
}