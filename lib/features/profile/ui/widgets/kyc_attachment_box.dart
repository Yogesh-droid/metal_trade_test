import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/features/profile/ui/controllers/kyc_bloc/kyc_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/kyc_bloc/kyc_file_pick_cubit/kyc_file_pick_cubit.dart';
import 'disabled_text_field.dart';

class KycAttachmentBox extends StatelessWidget {
  const KycAttachmentBox(
      {super.key, required this.onDelete, required this.index});
  final Function(int index) onDelete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: appPadding),
      child: Row(
        children: [
          index > 0
              ? IconButton(
                  onPressed: () {
                    onDelete(index);
                  },
                  icon: Icon(Icons.remove_circle, color: Colors.grey.shade400))
              : const SizedBox.shrink(),
          Expanded(
            child: BlocBuilder<KycFilePickCubit, KycFilePickState>(
              builder: (context, state) {
                if (state is KycFilePickSuccess) {
                  context.read<KycBloc>().add(UploadKycDoc(
                      fileName: state.file[index].path.split('/').last,
                      filePath: state.file[index].path));
                  return BlocBuilder<KycBloc, KycState>(
                    builder: (context, kycState) {
                      if (kycState is KycFileUploading) {
                        return LinearProgressIndicator(
                          minHeight: 30,
                          value: kycState.progress! / 100,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        );
                      }
                      return DisabledTextField(
                          onTap: () {
                            context.read<KycBloc>().url.clear();
                            context.read<KycFilePickCubit>().emitInitiaState();
                            onDelete(index);
                          },
                          hintText: state.file[index].path.split('/').last,
                          suffix: const Icon(CupertinoIcons.delete));
                    },
                  );
                }
                if (state is KycFilePickInitial ||
                    state is KycFilePickeFailed) {
                  return DisabledTextField(
                    onTap: () {
                      context.read<KycFilePickCubit>().pickFile();
                    },
                    hintText: "Attach",
                    suffix: const Icon(Icons.attachment_outlined),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
