import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ren_task/screens/transaction_list.dart';
import 'package:ren_task/values/app_colors.dart';
import 'package:ren_task/values/app_strings.dart';
import 'package:ren_task/values/size_config.dart';
import 'package:provider/provider.dart';
import 'package:ren_task/viewModel/base_change_notifier.dart';
import 'package:ren_task/viewModel/transaction_view_model.dart';
import 'package:ren_task/values/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionViewModel>(context);
    final scaler = ScaleUtil(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Center(
            child: Consumer(
              builder: (BuildContext context, TransactionViewModel viewModel,
                  Widget? child) {
                switch (viewModel.state) {
                  default:
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 39,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await transactionProvider.getTransaction();
                              debugPrint(transactionProvider.transactionResponse
                                  .toJson()
                                  .toString());
                              if (viewModel.state ==
                                  TransactionState.completed) {
                                Navigator.pushNamed(
                                    context, AppStrings.transactionRoute);
                              }
                            },
                            child: const Text('Print'),
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.resolveWith(
                                    (states) => const Size(70, 28)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => AppColors.buttonColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)))),
                          ),
                        ),
                        Visibility(
                            visible: transactionProvider.state ==
                                    TransactionState.loading
                                ? true
                                : false,
                            child: const Text('Hold On a bit'))
                      ],
                    );
                }
              },
            ),
          ),
        ),
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
                child: const Text('Printing to Logs'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
