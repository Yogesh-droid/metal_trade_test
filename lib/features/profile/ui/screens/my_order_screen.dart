import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
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
    if (myOrderBloc.myOrderList.isEmpty) {
      myOrderBloc.add(GetMyOrderEvent(isLoadMore: false, pageNo: 0));
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !myOrderBloc.isMyOrderListEnd!) {
        myOrderBloc.add(GetMyOrderEvent(
            isLoadMore: true, pageNo: myOrderBloc.myOrderPage++));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextMenuAppBar(title: kMyOrders),
      body: Column(
        children: [
          BlocBuilder<MyOrderBloc, MyOrderState>(
            builder: (context, state) {
              if (state is MyOrderInitial) {
                return const Dialog.fullscreen(
                    child: Center(child: LoadingDots()));
              } else if (state is MyOrderSuccess || state is MyOrderLoading) {
                return Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return MyOrderCard(
                          content: myOrderBloc.myOrderList[index],
                          itemList: myOrderBloc.myOrderList[index].item,
                          uuid: myOrderBloc.myOrderList[index].uuid,
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: appPadding);
                      },
                      itemCount: myOrderBloc.myOrderList.length),
                );
              } else if (state is MyOrderFailed) {
                return const Center(child: Text("No Order Found"));
              }
              return const Center(child: Text("No Order Found"));
            },
          ),
          SizedBox(
            height: 100,
            child: BlocBuilder<MyOrderBloc, MyOrderState>(
              builder: (context, state) {
                if (state is MyOrderLoading) {
                  return const LoadingDots();
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
