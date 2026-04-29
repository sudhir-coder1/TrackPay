
import 'package:cashkaro/core/pageRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homeController.dart';
import '../data/dataModel.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFE2E8F0),
        onPressed: () {
          _showOption();
        },
        label: Text("Add Entry"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8FAFC),
        title: Text("TRACK PAY", style: TextStyle(fontWeight: FontWeight(400))),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              spacing: 5,

              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "PAY",
                          style: TextStyle(
                            fontWeight: FontWeight(800),
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "₹ 1000",
                          style: TextStyle(
                            fontWeight: FontWeight(500),
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),

                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "RECEIVE",
                          style: TextStyle(
                            fontWeight: FontWeight(800),
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text("234",
                          style: TextStyle(
                            fontWeight: FontWeight(500),
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: Obx((){
                if (controller.detailsList.isEmpty) {
                  return Center(child: Text("Add Entry"));
                } return ListView.builder(
                  itemCount: controller.detailsList.length,
                  itemBuilder: (context, index) {
                    final item=controller.detailsList[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.chat,arguments: item);

                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.white30,
                                child: Text(item.name[0].toUpperCase(),style: TextStyle(
                                  fontWeight: FontWeight(600),
                                ),)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                ),
                                Text(
                                  item.number,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                  item.balance as String,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    fontWeight: FontWeight(500),
                                  ),
                                ),
                                Text(
                                  "Receive",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight(400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            )

          ],
        ),
      ),
    );
  }

  void _showOption() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        decoration: BoxDecoration(
          color: Color(0xFFE2E8F0),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Manual"),
              onTap: () {
                Get.back();
                _showBottomSheet();
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_phone),
              title: Text("Select Contact"),
              onTap: () {
                Get.back();
                controller.selectContact();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showBottomSheet() async {
    final nameController = TextEditingController();
    final numberController = TextEditingController();

    final result = await Get.bottomSheet(
      BottomSheet(
        onClosing: () {
          nameController.dispose();
        },
        builder: (ctx) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFFE2E8F0),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            alignment: Alignment.topCenter,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: "Enter Number",
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Icon(Icons.call_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(
                  width: Get.size.width,
                  child: TextButton(
                    onPressed: () {
                      Get.back(
                        result: DetailDataModel(
                          name: nameController.text,
                          number: numberController.text,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    if (result != null) {
      controller.saveData(result);
    }
  }
}
