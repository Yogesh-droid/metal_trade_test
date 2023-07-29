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
                        backgroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        child: const Icon(Icons.person_outlined)),
                    const SizedBox(width: appPadding * 2),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello !",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontFamily: "Nunito"),
                          ),
                          Text(state.profileEntity.mobileNumber ?? '',
                              style: secMed20.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontFamily: "Nunito")),
                        ]),
                  ],
                ),
                Divider(
                  color: Theme.of(context).colorScheme.outline,
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
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator(
                              color: Colors.deepPurpleAccent,
                              value: state.profileEntity.company != null
                                  ? state.profileEntity.company!
                                          .profileCompletion!.completion! /
                                      100
                                  : 0,
                            ),
                          ),
                        ),
                        Text(
                          state.profileEntity.company != null
                              ? "${((state.profileEntity.company!.profileCompletion!.completion! / 100) * 100).toInt()} %"
                                  .toString()
                              : "0 %",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )
                      ],
                    ),
                    FilledButtonWidget(
                        color: Theme.of(context).colorScheme.onPrimary,
                        title: state.profileEntity.company != null
                            ? state.profileEntity.company!.profileCompletion!
                                    .next ??
                                ''
                            : "Edit Profile",
                        textColor: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          context.pushNamed(kycPageName,
                              extra: state.profileEntity);
                        })
                  ],
                ),
              ],
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
