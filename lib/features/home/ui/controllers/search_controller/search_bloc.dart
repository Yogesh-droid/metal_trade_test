import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/home/domain/usecases/home_page_enquiry_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomePageEnquiryUsecase homePageEnquiryUsecase;
  final List<String> searchHistory = [];
  SearchBloc({required this.homePageEnquiryUsecase}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {});
  }
}
