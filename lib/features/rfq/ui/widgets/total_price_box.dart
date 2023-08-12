import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import 'package:metaltrade/features/rfq/ui/controllers/submit_quote/submit_quote_bloc.dart';

class TotalPriceBox extends StatelessWidget {
  const TotalPriceBox(
      {super.key, required this.price, required this.onPressed});
  final double price;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: appPadding * 3),
      child: Container(
        padding: const EdgeInsets.all(appPadding),
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text(kTotalOffer).tr(), Text("\$ $price")]),
              BlocConsumer<SubmitQuoteBloc, SubmitQuoteState>(
                listener: (context, state) {
                  if (state is SubmitQuoteSuccessful) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Quote Submitted successfully')));
                  } else if (state is SubmitQuoteFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.exception.toString())));
                  }
                },
                builder: (context, state) {
                  if (state is SubmittingQuote) {
                    return const FilledButton(
                        onPressed: null, child: LoadingDots());
                  }
                  return FilledButtonWidget(
                      title: kSubmit.tr(), onPressed: onPressed);
                },
              )
            ]),
      ),
    );
  }
}
