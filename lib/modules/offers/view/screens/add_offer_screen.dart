import 'package:ared/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/routing/navigation_services.dart';
import '../../../../core/extensions/non_null_extensions.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/view/widgets/custom_text.dart';
import '../../../../core/view/widgets/status_bar.dart';
import '../../providers/add_offer_provider.dart';
import '../components/add_offer_step_one.dart';
import '../components/add_offer_step_two.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({Key? key}) : super(key: key);

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  late final AddOfferProvider addOfferProvider;

  @override
  void initState() {
    addOfferProvider = Provider.of<AddOfferProvider>(context, listen: false);
    addOfferProvider.addOfferBody.resetValues();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addOfferProvider.setCurrentStep(0);
    });

    addOfferProvider.getOfferAttributes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool goBack = false;
        switch (addOfferProvider.currentStep) {
          case 0:
            final bool? pop = await Alerts.showAppDialog(
              context,
              title: AppStrings.closeAddOfferScreen,
              description: AppStrings.leavingWillEraseData,
              onConfirm: () => NavigationService.goBack(context, true),
              confirmText: AppStrings.goBack,
            );
            goBack = pop.orFalse;
            break;
          case 1:
            addOfferProvider.setCurrentStep(0);
            goBack = false;
            break;
          case 2:
            addOfferProvider.setCurrentStep(1);
            goBack = false;
            break;
        }
        return goBack;
      },
      child: StatusBar(
        child: Scaffold(
          body: SafeArea(
            child: Consumer<AddOfferProvider>(
              builder: (context, value, child) {
                if (value.offerAttributesLoading) return const Center(child: CircularProgressIndicator());
                if (value.getOfferAttributesFailure != null)
                  return ErrorView(
                    refresh: () => value.getOfferAttributes(),
                    failure: value.getOfferAttributesFailure!,
                  );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        BackButton(color: AppColors.black),
                        CustomText(AppStrings.offerDetails, fontSize: FontSize.s16, fontWeight: FontWeightManager.bold),
                      ],
                    ),
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: AppColors.pink,
                                onSurface: AppColors.pink,
                              ),
                          sliderTheme: const SliderThemeData(
                            activeTickMarkColor: AppColors.transparent,
                            inactiveTickMarkColor: AppColors.transparent,
                            thumbColor: AppColors.white,
                          ),
                        ),
                        child: Selector<AddOfferProvider, int>(
                          selector: (context, addOfferProvider) => addOfferProvider.currentStep,
                          builder: (context, currentStep, child) {
                            return Stepper(
                              elevation: AppSize.s0,
                              type: StepperType.horizontal,
                              currentStep: currentStep,
                              onStepTapped: (step) {
                                if (currentStep > step) {
                                  Provider.of<AddOfferProvider>(context, listen: false).setCurrentStep(step);
                                }
                              },
                              controlsBuilder: (context, _) => Container(),
                              steps: [
                                Step(
                                  title: const CustomText(Constants.empty),
                                  content: const AddOfferStepOne(),
                                  isActive: currentStep == 0,
                                  state: currentStep > 0 ? StepState.complete : StepState.indexed,
                                ),
                                Step(
                                  title: const CustomText(Constants.empty),
                                  content: const AddOfferStepTwo(),
                                  isActive: currentStep == 1,
                                  state: currentStep > 1 ? StepState.complete : StepState.indexed,
                                ),
                                // Step(
                                //   title: const CustomText(Constants.empty),
                                //   content: const AddOfferStepThree(),
                                //   isActive: currentStep == 2,
                                //   state: currentStep > 2 ? StepState.complete : StepState.indexed,
                                // )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
