import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/bloc/create_contact_cubit.dart';
import 'package:pattern_bloc_contact_api/bloc/create_contact_state.dart';
import 'package:pattern_bloc_contact_api/views/view_of_create.dart';

class CreatePage extends StatefulWidget {
  static const String id = "create_page";

  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  _finish(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.pop(context, 'result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateContactCubit(),
      child: Scaffold(
          body: BlocBuilder<CreateContactCubit, CreateContactState>(
            builder: (BuildContext context, CreateContactState state) {
              if (state is CreateContactLoading) {
                return viewOfCreate(
                    true, context, titleController, bodyController);
              }
              if (state is CreateContactLoaded) {
                _finish(context);
              }
              if (state is CreateContactError) {}
              return viewOfCreate(
                  false, context, titleController, bodyController);
            },
          )),
    );
  }
}
