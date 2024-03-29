import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../chat/domain/usecases/chat_file_pick_usecase.dart';
import '../../../chat/ui/widgets/chat_file_pick_upload/image_source_sheet.dart';
import '../../../profile/ui/widgets/disabled_text_field.dart';
import '../controllers/create_enquiry_bloc/create_enquiry_bloc.dart';
import '../controllers/enquiry_file_pick_cubit/enquiry_file_pick_cubit.dart';

class AttachmentBox extends StatelessWidget {
  const AttachmentBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnquiryFilePickCubit, EnquiryFilePickState>(
      listener: (context, state) {
        if (state is EnquiryFilePickFailed) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No File selected")));
        }
      },
      builder: (context, state) {
        if (state is EnquiryFilePickSuccess) {
          context.read<CreateEnquiryBloc>().add(UploadEnquiryAttachment(
              filaName: state.file.path.split('/').last,
              filePath: state.file.path));
          return BlocBuilder<CreateEnquiryBloc, CreateEnquiryState>(
            builder: (context, enquiryState) {
              if (enquiryState is EnquiryFileUploading) {
                return LinearProgressIndicator(
                  minHeight: 30,
                  value: enquiryState.value / 100,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                );
              }
              return DisabledTextField(
                  onTap: () {
                    context.read<CreateEnquiryBloc>().url = '';
                    context.read<EnquiryFilePickCubit>().emitInitialState();
                  },
                  hintText: state.file.path.split('/').last,
                  suffix: const Icon(CupertinoIcons.delete));
            },
          );
        }
        if (state is EnquiryFilePickInitial || state is EnquiryFilePickFailed) {
          return DisabledTextField(
            onTap: () {
              openChooseImageSourceSheet(context);
            },
            hintText: kAttach.tr(),
            suffix: const Icon(Icons.attachment_outlined),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  openChooseImageSourceSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ImageSourceSheet(
            onCameraTapped: () {
              context.pop();
              context
                  .read<EnquiryFilePickCubit>()
                  .getImageFromLib(FileSource.camera);
            },
            onFileTapped: () {
              context.pop();
              context
                  .read<EnquiryFilePickCubit>()
                  .getImageFromLib(FileSource.files);
            },
            onGalleryTapped: () {
              context.pop();
              context
                  .read<EnquiryFilePickCubit>()
                  .getImageFromLib(FileSource.gallery);
            },
          );
        });
  }
}
