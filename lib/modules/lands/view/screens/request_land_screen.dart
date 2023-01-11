import 'package:ared/config/routing/navigation_services.dart';
import 'package:ared/config/routing/routes.dart';
import 'package:ared/core/extensions/num_extensions.dart';
import 'package:ared/core/utils/echo.dart';
import 'package:ared/core/utils/globals.dart';
import 'package:ared/modules/lands/models/cities_areas_response.dart';
import 'package:ared/modules/lands/provider/lands_provider.dart';
import 'package:ared/modules/lands/view/widgets/custom_input_text_title.dart';
import 'package:ared/widgets/auth_error.dart';
import 'package:ared/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/resources.dart';
import '../../../../core/view/app_views.dart';

class RequestLandScreen extends StatefulWidget {
  const RequestLandScreen({Key? key}) : super(key: key);

  @override
  State<RequestLandScreen> createState() => _RequestLandScreenState();
}

class _RequestLandScreenState extends State<RequestLandScreen> {
  late final LandsProvider landProvider;
  @override
  void initState() {
    landProvider = Provider.of<LandsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      landProvider.init();
      landProvider.getOfferAttributes();
      landProvider.getCitiesAndAreas();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: AuthErrorWidget(
            action: () => () {
                  NavigationService.push(context, Routes.authScreen);
                }),
      );
    }

    return Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: const MainAppbar(title: AppStrings.requestLand),
        body: Consumer<LandsProvider>(
          builder: (context, provider, child) {
            if (provider.failure != null) {
              return ErrorView(
                  failure: provider.failure!,
                  refresh: () {
                    provider.getOfferAttributes();
                    provider.getCitiesAndAreas();
                  });
            }
            if (provider.isLoading) return const Center(child: CircularProgressIndicator());

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpace(AppSize.s16.h),
                  //*select type
                  customerDropDownWithTitle(
                    title: AppStrings.selectType,
                    dropdownMenuItem: provider.getLandTypeDropDownItems(),
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(
                        offerTypeId: provider.offerAttributes!.type!.firstWhere((element) => element.title == newVal).id,
                      );
                    },
                    value: provider.getSelectedLandTypeValue(),
                  ),
                  //*select specilist
                  customerDropDownWithTitle(
                    title: AppStrings.selectSpecialist,
                    dropdownMenuItem: provider.getSpecialistDropDownItems(),
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(usage: newVal);
                    },
                    value: provider.getSpecialistValue(),
                  ),
                    //*select area
                  Container(
                    key: Key('area_${provider.landRequestModel.cityId}}'),
                    child: customerDropDownWithTitle(
                      title: AppStrings.selectArea,
                      dropdownMenuItem: provider.getAreasDropDownItems(),
                      onChange: (newVal) {
                        //selected city
                        City selectedCity = provider.cities.firstWhere((element) => element.id == provider.landRequestModel.cityId);
                        //City areas
                        List<Area> areas = selectedCity.area;
                        //selected area
                        Area selectedArea = areas.firstWhere((element) => element.title == newVal);
                        kEcho("selected area id: ${selectedArea.id}");
                        provider.landRequestModel = provider.landRequestModel.copyWith(
                          areaId: selectedArea.id,
                        );
                      },
                      value: provider.getAreaValue(),
                    ),
                  ),
                
                //*select city
                  customerDropDownWithTitle(
                    title: AppStrings.selectCity,
                    dropdownMenuItem: provider.getCitiesDropDownItems(),
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(
                        cityId: provider.cities.firstWhere((element) => element.tite == newVal).id,
                      );
                      provider.landRequestModel = provider.landRequestModel.copyWith(areaId: null);
                      provider.refresh();
                    },
                    value: provider.getCityValue(),
                  ),
                  //*type district
                  CustomInputTextWithTitle(
                    initValue: provider.landRequestModel.district ?? '',
                    title: AppStrings.district,
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(district: newVal);
                    },
                  ),
                  //*land size
                  CustomInputTextWithTitle(
                    initValue: provider.landRequestModel.landSpace ?? '',
                    textInputType: TextInputType.number,
                    title: AppStrings.requestedArea,
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(landSpace: newVal);
                    },
                  ),
                  //*land price
                  CustomInputTextWithTitle(
                    initValue: provider.landRequestModel.price ?? '',
                    textInputType: const TextInputType.numberWithOptions(decimal: true),
                    title: AppStrings.requestedPrice,
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(price: newVal);
                    },
                  ),
                  //*contact
                  CustomInputTextWithTitle(
                    initValue: provider.landRequestModel.contact ?? '',
                    textInputType: const TextInputType.numberWithOptions(decimal: true),
                    title: AppStrings.contactNumber,
                    onChange: (newVal) {
                      provider.landRequestModel = provider.landRequestModel.copyWith(contact: newVal);
                    },
                  ),

                  //*contact by
                  //checkbox mobile or whats app
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Checkbox(
                          value: provider.landRequestModel.contactBy == 'mobile',
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(Colors.redAccent),
                          onChanged: (val) {
                            provider.landRequestModel = provider.landRequestModel.copyWith(contactBy: val == true ? 'mobile' : 'whatsapp');
                            provider.refresh();
                          },
                        ),
                        const CustomText(
                          AppStrings.mobile,
                          color: AppColors.blue,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s16,
                        ),
                        const Spacer(),
                        Checkbox(
                          value: provider.landRequestModel.contactBy == 'whatsapp',
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(Colors.redAccent),
                          onChanged: (val) {
                            provider.landRequestModel = provider.landRequestModel.copyWith(contactBy: val == true ? 'whatsapp' : 'mobile');
                            provider.refresh();
                          },
                        ),
                        const CustomText(
                          AppStrings.whatsapp,
                          color: AppColors.blue,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s16,
                        ),
                      ],
                    ),
                  ),
                  VerticalSpace(AppSize.s12.h),
                  //* send request
                  CustomButton(
                    text: AppStrings.sendRequest,
                    loading: provider.sendRequestLoading,
                    onPressed: () async {
                      bool status = await provider.sendLandRequest();
                      if (status) NavigationService.goBack(context);
                    },
                  ),
                  VerticalSpace(AppSize.s100.h),
                ],
              ),
            );
          },
        ));
  }

  Widget customerDropDownWithTitle({
    required String title,
    required Function(String newVal) onChange,
    required String? value,
    required List<DropdownMenuItem<String>> dropdownMenuItem,
  }) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomText(
            title,
            color: AppColors.blue,
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s16,
            textAlign: TextAlign.start,
          ),
        ),
        VerticalSpace(AppSize.s8.h),
        if (landProvider.offerAttributes?.type != null)
          CustomDropDownField<String>(
            hintText: title,
            value: value,
            onChanged: (val) {
              if (val != null) onChange(val);
            },
            items: dropdownMenuItem,
          ),
        VerticalSpace(AppSize.s16.h),
      ],
    );
  }
}
