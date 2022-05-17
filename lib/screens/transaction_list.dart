import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ren_task/values/app_colors.dart';
import 'package:ren_task/values/app_images.dart';
import 'package:ren_task/values/app_strings.dart';
import 'package:ren_task/values/size_config.dart';
import 'package:ren_task/values/styles.dart';
import 'package:provider/provider.dart';
import 'package:ren_task/viewModel/base_change_notifier.dart';
import 'package:ren_task/viewModel/transaction_view_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaler = ScaleUtil(context);
    final transactionProvider = Provider.of<TransactionViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppImages.backbuttonIcon,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () => transactionProvider.getTransaction(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.allTransactions,
                      style: AppStyles.heading1
                          .copyWith(fontSize: scaler.fontSizer.sp(80))),
                  SizedBox(
                    height: scaler.sizer.setAdjustedHeight(3),
                  ),
                  Consumer(
                    builder: (BuildContext context,
                        TransactionViewModel transaction, Widget? child) {
                      switch (transaction.state) {
                        case TransactionState.loading:
                          return LoadingWidget(
                            scaler: scaler,
                          );
                        case TransactionState.completed:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0, bottom: 12.0),
                                child: Container(
                                  height: scaler.sizer.setAdjustedHeight(98),
                                  child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: transactionProvider
                                            .transactionResponse
                                            .data
                                            ?.clientTransactions
                                            .length ??
                                        0,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(
                                      height: scaler.sizer.setAdjustedHeight(2),
                                    ),
                                    itemBuilder: ((context, index) =>
                                        buildListItemWidget(transactionProvider,
                                            index, scaler)),
                                  ),
                                ),
                              )
                            ],
                          );
                        case TransactionState.error:
                          return ErrorWidget(scaler: scaler);

                        default:
                          return Container();
                      }
                    },
                  ),
                ],
              )),
        ),
      )),
    );
  }

  InkWell buildListItemWidget(
      TransactionViewModel transactionProvider, int index, ScaleUtil scaler) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppStrings.transactionDetailRoute,
            arguments: transactionProvider
                .transactionResponse.data?.clientTransactions[index]);
      },
      child: Container(
        height: scaler.sizer.setAdjustedHeight(12),
        decoration: BoxDecoration(
            color: AppColors.itemCardColor,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  height: scaler.sizer.setAdjustedHeight(10),
                  width: scaler.sizer.setAdjustedWidth(12),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.transferCircleColor),
                  child: SvgPicture.asset(
                    transactionProvider.transactionResponse.data
                                ?.clientTransactions[index].type ==
                            AppStrings.transfer
                        ? AppImages.transferIcon
                        : AppImages.receivedIcon,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${transactionProvider.transactionResponse.data?.clientTransactions[index].comment}',
                        style: AppStyles.descTextBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        transactionProvider.transactionResponse.data
                                ?.clientTransactions[index].entryDate
                                .toString() ??
                            DateTime.now().toString(),
                        style: AppStyles.bodyText,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                transactionProvider.transactionResponse.data
                        ?.clientTransactions[index].amount
                        .toString() ??
                    '000',
                style: AppStyles.amountText.copyWith(
                    color: transactionProvider.transactionResponse.data
                                ?.clientTransactions[index].type ==
                            AppStrings.transfer
                        ? AppColors.textGreen
                        : AppColors.textRed),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.scaler,
  }) : super(key: key);

  final ScaleUtil scaler;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: scaler.sizer.setAdjustedHeight(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.airtimeCircleColor),
        child: const Center(child: Text("Something Went Wrong")),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    required this.scaler,
  }) : super(key: key);
  final ScaleUtil scaler;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Container(
          height: scaler.sizer.setAdjustedHeight(20),
          decoration: BoxDecoration(
              color: AppColors.itemCardColor,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Chill a Bit, Loading Transactions'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
