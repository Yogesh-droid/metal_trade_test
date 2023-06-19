import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/spaces.dart';
import '../../data/models/country_code_model.dart';
import '../controllers/country_code_controller.dart';

class CountryCodePicker extends StatefulWidget {
  const CountryCodePicker({super.key, required this.countryList});
  final List<CountryCodeModel> countryList;

  @override
  State<CountryCodePicker> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  late List<CountryCodeModel> _countryList;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _countryList = widget.countryList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: grey5,
      backgroundColor: transparent,
      insetPadding: const EdgeInsets.all(appPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                children: [
                  TextField(
                      controller: searchController,
                      onChanged: (value) => loadCountry(),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Search by country name or code")),
                  FutureBuilder<List<CountryCodeModel>>(
                      future: loadCountry(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        context
                                            .read<CountryCodeController>()
                                            .changeCountryCode(
                                                snapshot.data![index]);
                                        Navigator.pop(context);
                                      },
                                      title: Text(
                                          "${snapshot.data![index].emoji}   ${snapshot.data![index].name!}"),
                                      trailing:
                                          Text(snapshot.data![index].dialCode!),
                                    );
                                  }),
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
            const SizedBox(height: appPadding),
            Container(
                decoration:
                    const BoxDecoration(color: grey2, shape: BoxShape.circle),
                child: IconButton(
                  splashColor: transparent,
                  splashRadius: 10,
                  visualDensity:
                      const VisualDensity(horizontal: 1, vertical: 1),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: grey5,
                )),
          ],
        ),
      ),
    );
  }

  Future<List<CountryCodeModel>> loadCountry() async {
    if (_countryList.isEmpty) {
      String json = await rootBundle.loadString('assets/country.json');
      List map = jsonDecode(json);
      for (var element in map) {
        _countryList.add(CountryCodeModel.fromJson(element));
      }
    }

    List<CountryCodeModel> list1 = _countryList
        .where((element) =>
            element.dialCode!.contains(searchController.text) ||
            element.name!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
        .toList();

    setState(() {});
    return list1;
  }
}
