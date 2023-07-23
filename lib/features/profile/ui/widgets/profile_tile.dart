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
          // return state.profileEntity.company != null
          //     ?
          return Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(appPadding * 2),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: Text(
                        state.profileEntity.company!.name![0],
                        style: secMed20.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const SizedBox(width: appPadding * 2),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.profileEntity.company!.name ?? '',
                              style: secMed20.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary)),
                          Text(
                            state.profileEntity.company!.email ?? '',
                            style: secMed14.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          Text(
                            state.profileEntity.company!.phone ?? '',
                            style: secMed14.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary),
                          )
                        ]),
                  ],
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.indigo,
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onSecondary,
                            value: state.profileEntity.company!
                                    .profileCompletion!.completion! /
                                100,
                          ),
                        ),
                        Text(
                          "${((state.profileEntity.company!.profileCompletion!.completion! / 100) * 100).toInt()} %"
                              .toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    ),
                    FilledButtonWidget(
                        color: Theme.of(context).colorScheme.onPrimary,
                        title: state.profileEntity.company!.profileCompletion!
                                .next ??
                            '',
                        textColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {})
                  ],
                ),
              ],
            ),
          );
          // : Center(
          //     child: Padding(
          //       padding: const EdgeInsets.all(appPadding),
          //       child: GetStartedBtn(
          //           title: kCompleteKyc,
          //           width: MediaQuery.of(context).size.width / 1.5,
          //           onPressed: () {
          //             context.pushNamed(kycPageName);
          //           }),
          //     ),
          //   );
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
