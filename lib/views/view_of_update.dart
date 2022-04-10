import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/bloc/update_contact_cubit.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';

Widget viewOfUpdate(
    bool isLoading,
    BuildContext context,
    TextEditingController nameController,
    TextEditingController numberController,
    Contact contact) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Update contact"),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              Contact contactUpdate = Contact(
                  name: nameController.text.toString(),
                  number: numberController.text.toString(),
                  id: contact.id);
              BlocProvider.of<UpdateContactCubit>(context)
                  .apiContactUpdate(contactUpdate);
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ))
      ],
    ),
    body: Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController..text = contact.name!,
                  maxLines: null,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                      hintText: "Name"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: numberController..text = contact.number!,
                  keyboardType: TextInputType.phone,
                  maxLines: null,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "Number",
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : const SizedBox.shrink(),
      ],
    ),
  );
}
