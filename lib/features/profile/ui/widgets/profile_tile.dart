import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/landing/ui/widgets/get_started_btn.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/profile_bloc/profile_bloc.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileSuccessState) {
          return state.profileEntity.company != null
              ? Padding(
                  padding: const EdgeInsets.all(appPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              state.profileEntity.company!.name![0],
                              style: secMed20.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                          ),
                          const SizedBox(width: appPadding),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.profileEntity.company!.name ?? '',
                                    style: secMed20.copyWith(
                                        fontWeight: FontWeight.bold)),
                                Text(state.profileEntity.company!.email ?? ''),
                                Text(state.profileEntity.company!.phone ?? '')
                              ]),
                        ],
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                    ],
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: GetStartedBtn(
                        title: kCompleteKyc,
                        width: MediaQuery.of(context).size.width / 1.5,
                        onPressed: () {
                          context.pushNamed(kycPageName);
                        }),
                  ),
                );
        } else if (state is ProfileFailed) {
          return Center(child: Text(state.exception.toString()));
        } else {
          return GetStartedBtn(
              width: MediaQuery.of(context).size.width / 1.5,
              title: kLogin,
              onPressed: () {
                context.push(loginPageRoute);
              });
        }
      },
    );
  }
}
