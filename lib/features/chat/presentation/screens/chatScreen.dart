import 'package:cashkaro/core/pageRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../addPayment/presentation/controller/paymentController.dart';

class ChatScreen extends GetWidget<PaymentController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFE2E8F0),
        onPressed: () {
          Get.toNamed(AppPages.payment, arguments: controller.data);
        },
        icon: Icon(Icons.add),
        label: Text("Add"),
      ),

      appBar: AppBar(
        backgroundColor: Color(0xFFF8FAFC),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(controller.data.name, style: TextStyle(fontSize: 15)),
            Text(controller.data.number, style: TextStyle(fontSize: 13)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () => controller.makeCall(controller.data.number),
          ),
          IconButton(icon: Icon(Icons.delete), onPressed: () {}),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildHeader(),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10, bottom: 90),
                  itemCount: controller.paymentList.length,
                  itemBuilder: (context, index) {
                    final item = controller.paymentList[index];

                    if (item.isSend == 1) {
                      return _buildSendItem(
                        "₹ ${item.amount.toStringAsFixed(0)}",
                        item.remarks,
                        item.dateTime,
                        item.dateTime,
                      );
                    } else {
                      return _buildReceiveItem(
                        "₹ ${item.amount.toStringAsFixed(0)}",
                        item.remarks,
                        item.dateTime,
                        item.dateTime,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: controller.netBalance < 0
                ? [Color(0xFF16A34A), Color(0xFF22C55E)]
                : controller.netBalance > 0
                ? [Color(0xFFDC2626), Color(0xFFEF4444)]
                : [Colors.grey, Colors.grey.shade600],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(controller.balanceIcon, color: Colors.white),
            ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Balance",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 2),
                  Text(
                    controller.balanceLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              "₹ ${controller.netBalance.abs().toStringAsFixed(0)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SEND =================
  Widget _buildSendItem(
    String amount,
    String remarks,
    DateTime time,
    DateTime date,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: Get.size.width * 0.78),
        decoration: BoxDecoration(
          color: Color(0xFFFFF1F2),
          border: Border(right: BorderSide(color: Color(0xFFEF4444), width: 3)),
          borderRadius: BorderRadius.circular(
            14,
          ).copyWith(topRight: Radius.zero),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _amountRow(Icons.arrow_upward, Color(0xFFEF4444), amount),
            SizedBox(height: 6),
            _remarks(remarks),
            SizedBox(height: 8),
            _timeRow(date, time),
          ],
        ),
      ),
    );
  }

  // ================= RECEIVE =================
  Widget _buildReceiveItem(
    String amount,
    String remarks,
    DateTime time,
    DateTime date,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: Get.size.width * 0.78),
        decoration: BoxDecoration(
          color: Color(0xFFF0FDF4),
          border: Border(left: BorderSide(color: Color(0xFF22C55E), width: 3)),
          borderRadius: BorderRadius.circular(
            14,
          ).copyWith(topLeft: Radius.zero),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _amountRow(Icons.arrow_downward, Color(0xFF22C55E), amount),
            SizedBox(height: 6),
            _remarks(remarks),
            SizedBox(height: 8),
            _timeRow(date, time),
          ],
        ),
      ),
    );
  }

  // ================= REUSABLE =================

  Widget _amountRow(IconData icon, Color color, String amount) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _remarks(String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.3),
    );
  }

  Widget _timeRow(DateTime date, DateTime time) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _chip(controller.formatDate(date)),
        SizedBox(width: 6),
        _chip(controller.formatTime(time)),
      ],
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, color: Colors.black54)),
    );
  }
}
