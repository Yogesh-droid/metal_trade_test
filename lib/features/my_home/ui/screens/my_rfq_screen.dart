import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/my_home/ui/controllers/filter_status_cubit/filter_status_cubit.dart';
import 'package:metaltrade/features/my_home/ui/controllers/my_rfq_bloc/my_rfq_bloc.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_form.dart';
import 'package:metaltrade/features/my_home/ui/screens/create_enquiry_screen.dart';
import 'package:metaltrade/features/my_home/ui/widgets/filter_chips_list.dart';

import '../../../rfq/ui/widgets/home_page_card.dart';

class MyRfqScreen extends StatefulWidget {
  const MyRfqScreen({super.key});

  @override
  State<MyRfqScreen> createState() => _MyRfqScreenState();
}

class _MyRfqScreenState extends State<MyRfqScreen> {
  late ScrollController scrollController = ScrollController();
  late MyRfqBloc myRfqBloc;
  late FilterStatusCubit filterStatusCubit;

  @override
  void initState() {
    myRfqBloc = context.read<MyRfqBloc>();
    filterStatusCubit = context.read<FilterStatusCubit>();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myRfqBloc.isMyRfqListEnd) {
        myRfqBloc.add(GetMyRfqList(
            page: myRfqBloc.myRfqListPage,
            status: filterStatusCubit.statusList));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            CreateEnquiryForm(),
            const FilterChipList(),
            BlocBuilder<MyRfqBloc, MyRfqState>(builder: (context, state) {
              if (state is MyRfqInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MyRfqFetchedState) {
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: state.contentList
                      .map((e) => HomePageCard(
                            content: e,
                            isSeller: false,
                            companyAddress: e.enquiryCompany!.address,
                            enquiryCommpanyName: e.enquiryCompany!.name,
                            itemList: e.item,
                            ownerName: e.enquiryCompany!.name,
                            datePosted: e.enquiryCompany!.lastModifiedDate,
                            country: e.enquiryCompany!.country!.name,
                            uuid: e.uuid,
                          ))
                      .toList(),
                );
              } else {
                return const Center(child: Text("Some Error"));
              }
            }),
          ],
        ),
      ),
    );
  }
}
