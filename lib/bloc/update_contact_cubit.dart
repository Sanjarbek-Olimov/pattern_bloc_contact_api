import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_contact_api/bloc/update_contact_state.dart';
import 'package:pattern_bloc_contact_api/model/contact_model.dart';
import 'package:pattern_bloc_contact_api/service/http_service.dart';

class UpdateContactCubit extends Cubit<UpdateContactState> {
  UpdateContactCubit() : super(UpdateContactInit());

  void apiContactUpdate(Contact contact) async {
    emit(UpdateContactLoading());
    final response = await Network.POST(Network.API_UPDATE+contact.id.toString(), Network.paramsUpdate(contact));
    print(response);
    if (response != null) {
      emit(UpdateContactLoaded(contact: contact));
    } else {
      emit(UpdateContactError(error: "Could not Update contact"));
    }
  }

}
