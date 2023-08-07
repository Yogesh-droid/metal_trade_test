import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/disabled_text_field.dart';
import 'package:metaltrade/features/rfq/data/models/rfq_enquiry_model.dart';
import 'package:metaltrade/features/rfq/ui/controllers/cubit/download_file_cubit.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/constants/spaces.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/constants/text_tyles.dart';
import '../../../landing/ui/widgets/get_started_btn.dart';

class EnquiryDetailList extends StatelessWidget {
  final String paymentTermsDisplay;
  final String transportationTermsDisplay;
  final String? outlinedButtonText;
  final String? filledBtnText;
  final Function()? onOutlineTapped;
  final Function()? onFilledTapped;
  final List<Item> itemList;
  final String? otherTerms;
  final String? otherAttachmentsName;
  final String? otherAttachmentsUrl;
  const EnquiryDetailList(
      {super.key,
      required this.paymentTermsDisplay,
      required this.transportationTermsDisplay,
      this.outlinedButtonText,
      this.onOutlineTapped,
      this.onFilledTapped,
      this.filledBtnText,
      required this.itemList,
      this.otherTerms,
      this.otherAttachmentsName,
      this.otherAttachmentsUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
      child: Column(children: [
        itemListWidget(context),
        const SizedBox(height: appPadding),
        const Divider(),
        TermsRow(title: kPaymentTerms, terms: paymentTermsDisplay),
        const Divider(),
        TermsRow(title: kTransportTerms, terms: transportationTermsDisplay),
        const Divider(),
        TermsRow(title: kRemarks, terms: otherTerms),
        const Divider(),
        if (otherAttachmentsName != null)
          BlocBuilder<DownloadFileCubit, DownloadFileState>(
            builder: (context, state) {
              if (state is FileDownloading) {
                return LinearProgressIndicator(
                  minHeight: 30,
                  value: state.progress / 100,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                );
              } else if (state is DownloadFileSuccess) {
                Future.delayed(const Duration(seconds: 1), () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("File downloaded successfully")));
                  context.read<DownloadFileCubit>().emitIntial();
                });
                return DisabledTextField(
                    onTap: () async {
                      final dir = Directory(
                          '${(Platform.isAndroid ? "/storage/emulated/0/Download" //FOR ANDROID
                              : await getApplicationSupportDirectory() //FOR IOS
                          )}/Metaltrade');
                      String fullPath =
                          "${dir.path}/${otherAttachmentsUrl!.split(RegExp(r'[/_-]')).last}";
                      File file = File(fullPath);
                    },
                    hintText: otherAttachmentsName);
              } else if (state is FileDownloadFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception.toString())));
                return DisabledTextField(
                    onTap: () async {
                      context
                          .read<DownloadFileCubit>()
                          .downloadFile(otherAttachmentsUrl ?? '');
                    },
                    hintText: otherAttachmentsName,
                    suffix: const Icon(Icons.download));
              }
              return DisabledTextField(
                  onTap: () async {
                    context
                        .read<DownloadFileCubit>()
                        .downloadFile(otherAttachmentsUrl ?? '');
                  },
                  hintText: otherAttachmentsName,
                  suffix: const Icon(Icons.download));
            },
          ),
        const SizedBox(height: appWidgetGap),
        Row(
          children: [
            outlinedButtonText != null
                ? Expanded(
                    child: OutlinedIconButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        title: outlinedButtonText ?? '',
                        onPressed: onOutlineTapped!,
                        icon: const Icon(Icons.add)),
                  )
                : const SizedBox(),
            const SizedBox(width: appPadding * 2),
            filledBtnText != null
                ? Expanded(
                    child: FilledButtonWidget(
                        title: filledBtnText!, onPressed: onFilledTapped!),
                  )
                : const SizedBox()
          ],
        )
      ]),
    );
  }

  Widget itemListWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(kProducts,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.secondary))
            .tr(),
        getItemListTile(context),
      ],
    );
  }

  Widget getItemListTile(BuildContext context) {
    return Column(
        children: itemList
            .map((e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(e.sku!.title ?? '',
                      style: secMed14.copyWith(fontWeight: FontWeight.w700)),
                  subtitle: e.remarks != null
                      ? Text(
                          e.remarks ?? '',
                          style: secMed12.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                        )
                      : null,
                  trailing: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "${e.quantity} ",
                        style: secMed12.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                        children: [
                          TextSpan(text: "${e.quantityUnit}", style: secMed12)
                        ]),
                  ])),
                ))
            .toList());
  }
}

class TermsRow extends StatelessWidget {
  const TermsRow({super.key, required this.title, this.terms});
  final String title;
  final String? terms;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: secMed14.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      Container(
          alignment: Alignment.centerRight,
          width: MediaQuery.of(context).size.width / 2,
          child: Text(
            terms ?? '',
            textAlign: TextAlign.end,
          ))
    ]);
  }
}
