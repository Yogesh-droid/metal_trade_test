import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/profile/ui/controllers/my_order_bloc/my_order_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/my_order_card.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  late MyOrderBloc myOrderBloc;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    myOrderBloc = context.read<MyOrderBloc>();
    myOrderBloc.myOrderList.clear();
    if (myOrderBloc.myOrderList.isEmpty) {
      myOrderBloc.add(GetMyOrderEvent(isLoadMore: false, pageNo: 0));
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myOrderBloc.isMyOrderListEnd! &&
          myOrderBloc.state is MyOrderSuccess) {
        myOrderBloc.add(GetMyOrderEvent(
            isLoadMore: true, pageNo: ++myOrderBloc.myOrderPage));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      appBar: ContextMenuAppBar(title: kMyOrders.tr()),
      body: Column(
        children: [
          BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              if (state is MyOrderInitial) {
                return const Dialog.fullscreen(
                    child: Center(child: LoadingDots()));
              } else if (state is MyOrderSuccess || state is MyOrderLoading) {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return MyOrderCard(
                          content: myOrderBloc.myOrderList[index],
                          itemList: myOrderBloc.myOrderList[index].item,
                          uuid: myOrderBloc.myOrderList[index].uuid,
                        );
                      },
                      itemCount: myOrderBloc.myOrderList.length),
                );
              } else if (state is MyOrderFailed) {
                return const Center(child: Text("No Order Found"));
              }
              return const Center(child: Text("No Order Found"));
            },
          ),
          BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              if (state is MyOrderLoading) {
                return const SizedBox(height: 50, child: LoadingDots());
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
