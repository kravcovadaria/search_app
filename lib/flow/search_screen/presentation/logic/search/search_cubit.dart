import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_app/flow/search_screen/presentation/logic/search/search_state.dart';
export 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState(status: SearchStatus.initial));

  void fetch() {
    emit(state.copyWith(status: SearchStatus.loading));
  }
}
