import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/bloc/list_contact_cubit.dart';
import 'package:pattern_bloc_contact_api/bloc/list_contact_state.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';
import 'package:pattern_bloc_contact_api/views/view_of_home.dart';
class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ListContactCubit>(context).apiContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pattern - BloC"),
        centerTitle: true,
      ),
      body: BlocBuilder<ListContactCubit, ListContactState>(
        builder: (context, state) {
          if (state is ListContactError) {
            return viewOfHome(contacts, true);
          }
          if (state is ListContactLoaded) {
            contacts = state.contacts!;
            return viewOfHome(contacts, false);
          }
          return viewOfHome(contacts, true);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ListContactCubit>(context).callCreatePage(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
