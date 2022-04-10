import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/bloc/update_contact_cubit.dart';
import 'package:pattern_bloc_contact_api/bloc/update_contact_state.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';
import 'package:pattern_bloc_contact_api/views/view_of_update.dart';

class UpdatePage extends StatefulWidget {
  static const String id = "update_page";

  Contact contact;

  UpdatePage({Key? key, required this.contact}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context, 'result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateContactCubit(),
      child: Scaffold(body: BlocBuilder<UpdateContactCubit, UpdateContactState>(
        builder: (BuildContext context, UpdateContactState state) {
          if (state is UpdateContactLoading) {
            return viewOfUpdate(
                true, context, nameController, numberController, widget.contact);
          }
          if (state is UpdateContactLoaded) {
            _finish(context);
          }
          if (state is UpdateContactError) {}
          return viewOfUpdate(
              false, context, nameController, numberController, widget.contact);
        },
      )),
    );
  }
}
