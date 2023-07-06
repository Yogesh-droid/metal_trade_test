import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/country_code_model.dart';
import '../controllers/country_code_controller.dart';
import 'country_code_picker.dart';

class CountryChooserIconBtn extends StatelessWidget {
  const CountryChooserIconBtn({super.key, required this.countryList});
  final List<CountryCodeModel> countryList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCodeController, CountryCodeModel>(
      builder: (context, state) {
        return SizedBox(
          width: 100,
          child: InkWell(
              onTap: () {
                showGeneralDialog(
                    context: context,
                    pageBuilder: (ctx, a1, a2) {
                      return const SizedBox();
                    },
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return Transform.scale(
                          scale: Curves.easeIn.transform(animation.value),
                          child: CountryCodePicker(
                            countryList: countryList,
                          ));
                    },
                    transitionDuration: const Duration(milliseconds: 500));
              },
              child: state.dialCode != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("${state.emoji}  ${state.dialCode ?? ''}")
                        ],
                      ),
                    )
                  : const Icon(Icons.flag_circle_rounded)),
        );
      },
    );
  }
}
