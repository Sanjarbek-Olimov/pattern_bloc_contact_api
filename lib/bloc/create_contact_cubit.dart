import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';
import 'package:pattern_bloc_contact_api/service/http_service.dart';

import 'create_contact_state.dart';

class CreateContactCubit extends Cubit<CreateContactState> {
  CreateContactCubit() : super(CreateContactInit());

  void apiContactCreate(Contact contact) async {
    emit(CreateContactLoading());
    final response = await Network.POST(Network.API_CREATE, Network.paramsCreate(contact));
    print(response);
    if (response != null) {
      emit(CreateContactLoaded(isCreated: true));
    } else {
      emit(CreateContactError(error: "Could not create contact"));
    }
  }

}
