import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/kyc_bloc/kyc_file_pick_cubit/kyc_file_pick_cubit.dart';
import '../../../../../core/constants/spaces.dart';
import '../../controllers/kyc_bloc/kyc_bloc.dart';

class AttachmentList extends StatelessWidget {
  const AttachmentList({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Column(children: [
        BlocListener<KycFilePickCubit, KycFilePickState>(
          listener: (context, kycFilePickState) {
            if (kycFilePickState is KycFilePickSuccess) {
              context.read<KycBloc>().add(UploadKycDoc(
                  fileName: kycFilePickState.file.path.split('/').last,
                  filePath: kycFilePickState.file.path));
            }
          },
          child: BlocBuilder<KycBloc, KycState>(builder: (context, state) {
            if (state is KycFIleUploadSuccess) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: context.read<KycBloc>().url.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            width: double.infinity,
                            padding: const EdgeInsets.all(appPadding),
                            margin: const EdgeInsets.all(appPadding),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(context
                                .read<KycBloc>()
                                .url[index]
                                .split(RegExp(r'[/_-]'))
                                .last),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<KycBloc>().add(RemoveKycDoc(index));
                            },
                            icon: const Icon(CupertinoIcons.delete))
                      ],
                    );
                  });
            } else if (state is KycFileUploading) {
              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: context.read<KycBloc>().url.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                padding: const EdgeInsets.all(appPadding),
                                margin: const EdgeInsets.all(appPadding),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Text(context
                                    .read<KycBloc>()
                                    .url[index]
                                    .split('/')
                                    .last),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<KycBloc>()
                                      .add(RemoveKycDoc(index));
                                },
                                icon: const Icon(CupertinoIcons.delete))
                          ],
                        );
                      }),
                  LinearProgressIndicator(
                    minHeight: 30,
                    value: state.progress! / 100,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
              onPressed: () {
                context.read<KycFilePickCubit>().pickFile();
              },
              child: const Text("+ Add KYC Documents")),
        ),
      ]),
    );
  }
}
