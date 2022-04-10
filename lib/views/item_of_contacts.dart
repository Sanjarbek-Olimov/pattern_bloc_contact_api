import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pattern_bloc_contact_api/bloc/list_contact_cubit.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';

Widget itemOfContacts(BuildContext context, Contact contact) {
  return Card(
    child: Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (_) {
              BlocProvider.of<ListContactCubit>(context).apiContactDelete(contact);
            },
            icon: Icons.delete,
          ),
        ],
      ),
      startActionPane: ActionPane(
        dragDismissible: true,
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.blue,
            onPressed: (_) {
              BlocProvider.of<ListContactCubit>(context).callUpdatePage(context, contact);
            },
            icon: Icons.edit,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          contact.name!.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contact.number!),
      ),
    ),
  );
}
