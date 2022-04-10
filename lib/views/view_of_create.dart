import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/bloc/create_contact_cubit.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';

Widget viewOfCreate(
    bool isLoading,
    BuildContext context,
    TextEditingController nameController,
    TextEditingController numberController) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Create contact"),
      centerTitle: true,
      actions: [
        TextButton(
            onPressed: () {
              Contact contact = Contact(
                  name: nameController.text.toString(),
                  number: numberController.text.toString(),
              );
              BlocProvider.of<CreateContactCubit>(context).apiContactCreate(contact);
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
                  controller: nameController,
                  maxLines: null,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 10, top: 10),
                      hintText: "Name"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: numberController,
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
