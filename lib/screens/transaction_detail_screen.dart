import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ren_task/model/transaction_response.dart';
import 'package:ren_task/values/app_colors.dart';
import 'package:ren_task/values/app_images.dart';
import 'package:ren_task/values/app_strings.dart';
import 'package:ren_task/values/size_config.dart';
import 'package:ren_task/values/styles.dart';

class TransactionDetailScreen extends StatelessWidget {
  TransactionDetailScreen({Key? key, required this.transactionResponse})
      : super(key: key);
  final ClientTransaction transactionResponse;

  @override
  Widget build(BuildContext context) {
    final scaler = ScaleUtil(context);
    return Scaffold(
      backgroundColor: AppColors.purpleText,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppImages.backbuttonIcon,
            color: AppColors.white,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.transactionDetail,
                style: AppStyles.heading2
                    .copyWith(fontSize: scaler.fontSizer.sp(80))),
            SizedBox(
              height: scaler.sizer.setAdjustedHeight(5),
            ),
            Container(
              height: scaler.sizer.setAdjustedHeight(55),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.detailedSummaryText,
                      style: AppStyles.subHeading
                          .copyWith(fontSize: scaler.fontSizer.sp(60)),
                    ),
                    DetailItemWidget(
                      scaler: scaler,
                      transactionResponse: transactionResponse,
                      parameter: 'Description',
                      value: transactionResponse.comment,
                    ),
                    DetailItemWidget(
                      scaler: scaler,
                      transactionResponse: transactionResponse,
                      parameter: 'Amount',
                      value: transactionResponse.amount.toString(),
                    ),
                    DetailItemWidget(
                      scaler: scaler,
                      transactionResponse: transactionResponse,
                      parameter: 'Transaction Date',
                      value: transactionResponse.entryDate,
                    ),
                    DetailItemWidget(
                      scaler: scaler,
                      transactionResponse: transactionResponse,
                      parameter: 'Reference',
                      value: transactionResponse.transactionId.toString(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          'Type',
                          style: AppStyles.bodyText
                              .copyWith(fontSize: scaler.fontSizer.sp(55)),
                        )),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: scaler.sizer.setAdjustedHeight(1.2),
                                width: scaler.sizer.setAdjustedWidth(2),
                                decoration: const BoxDecoration(
                                    color: AppColors.textGreen,
                                    shape: BoxShape.circle),
                              ),
                              SizedBox(
                                  width: scaler.sizer.setAdjustedWidth(1.5)),
                              Text(
                                transactionResponse.type,
                                style: AppStyles.descTextBlack.copyWith(
                                    fontSize: scaler.fontSizer.sp(55),
                                    color: AppColors.textGreen),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class DetailItemWidget extends StatelessWidget {
  const DetailItemWidget(
      {Key? key,
      required this.scaler,
      required this.transactionResponse,
      required this.parameter,
      this.value = '...'})
      : super(key: key);

  final ScaleUtil scaler;
  final ClientTransaction transactionResponse;
  final String parameter;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          parameter,
          style: AppStyles.bodyText.copyWith(fontSize: scaler.fontSizer.sp(55)),
        )),
        Expanded(
          child: Text(
            value,
            style: AppStyles.descTextBlack
                .copyWith(fontSize: scaler.fontSizer.sp(55)),
          ),
        ),
      ],
    );
  }
}
