import 'package:cashkaro/features/addPayment/presentation/controller/paymentController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/presentation/data/dataModel.dart';

class AddPayment extends GetWidget<PaymentController> {
  const AddPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8FAFC),
        title: Text(controller.data.name, style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Obx(
              () => Row(
                spacing: 4,
                children: [
                  // PAY
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.selectPay,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.red),
                          color: controller.isPay.value
                              ? Colors.red
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "PAY",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.isPay.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // RECEIVE
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.selectReceive,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.green),
                          color: !controller.isPay.value
                              ? Colors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "RECEIVE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !controller.isPay.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "₹ 000,00",

                  contentPadding: EdgeInsets.zero,

                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            SizedBox(
              height: 80,
              child: TextFormField(
                controller: controller.notesController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Enter notes...",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            Obx(
              () => SizedBox(
                width: Get.width,
                child: TextButton(
                  onPressed: () {
                    controller.savePayment(
                      TransactionModel(
                        userId: int.parse(controller.data.id.toString()),
                        isSend: controller.isPay.value ? 1 : 0,
                        amount:
                            double.tryParse(controller.amountController.text) ??
                            0.0,
                        remarks: controller.notesController.text,
                        dateTime: DateTime.now(),
                      ),
                    );
                    controller.amountController.clear();
                    controller.notesController.clear();

                  },
                  style: TextButton.styleFrom(
                    backgroundColor: controller.isPay.value
                        ? Colors.red
                        : Colors.green,

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),

                  ),
                  child: Text("SAVE"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
