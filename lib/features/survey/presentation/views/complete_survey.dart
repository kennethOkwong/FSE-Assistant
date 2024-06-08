import 'package:flutter/material.dart';
import 'package:fse_assistant/core/utils/widget_helpers.dart';
import 'package:fse_assistant/features/base/base_ui.dart';
import 'package:fse_assistant/features/survey/domain/models/base_station_data_model.dart';

import '../../../../core/app theme/app_colors.dart';
import '../view models/survey_vm.dart';

class CompleteSurveyScreen extends StatefulWidget {
  CompleteSurveyScreen({super.key, required this.stationsFound});

  final List<BaseStationDataModel> stationsFound;

  @override
  State<CompleteSurveyScreen> createState() => _CompleteSurveyScreenState();
}

class _CompleteSurveyScreenState extends State<CompleteSurveyScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reportNameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _cableLenthController = TextEditingController();
  final TextEditingController _surveyAddressController =
      TextEditingController();
  final TextEditingController _latittudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _altittudeController = TextEditingController();
  final TextEditingController _powerLNController = TextEditingController();
  final TextEditingController _powerLEController = TextEditingController();
  final TextEditingController _powerNEController = TextEditingController();

  @override
  void dispose() {
    _reportNameController.dispose();
    _heightController.dispose();
    _cableLenthController.dispose();
    _powerLNController.dispose();
    _surveyAddressController.dispose();
    _latittudeController.dispose();
    _longitudeController.dispose();
    _altittudeController.dispose();
    _powerLEController.dispose();
    _powerNEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = deviceWidth(context);
    // final height = deviceHeight(context);

    return BaseView<SurveyViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: AppColors.green,
            foregroundColor: AppColors.white,
            title: const Text('Survey Report'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20
                  // bottom: 30,
                  ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Report name'),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: _reportNameController,
                      decoration: InputDecoration(
                        isDense: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Survey Adress'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _latittudeController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                validator: (value) {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Altitude'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _longitudeController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                validator: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Latittude'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _latittudeController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                validator: (value) {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Longitude'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: _longitudeController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                validator: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(border: Border.all()),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            hint: Text('Height type'),
                            items: [],
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _surveyAddressController,
                            decoration: InputDecoration(
                              hintText: 'Height(meters)',
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            hint: Text('Structure'),
                            items: [],
                            onChanged: (value) {},
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _surveyAddressController,
                            decoration: InputDecoration(
                              hintText: 'Cable lenght(m)',
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Closest base stations'),
                    Text('check the ones with  clear line of sight'),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                              ),
                              Text(
                                'Presidential',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.grey, fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: true,
                                onChanged: (value) {},
                              ),
                              Text(
                                'Trans Amadi',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.grey, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                        Text(
                          'Survey successful',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Power Audit'),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _latittudeController,
                            decoration: InputDecoration(
                              hintText: 'L-N',
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _longitudeController,
                            decoration: InputDecoration(
                              hintText: 'L-E',
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _longitudeController,
                            decoration: InputDecoration(
                              hintText: 'N-E',
                              isDense: true,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            validator: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // model.resetPassword(
                                  //   context: context,
                                  //   code: widget.code,
                                  //   newPassword: _confirmPasswordController.text,
                                  // );
                                }
                              },
                              child: const Text(
                                'Save report',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
