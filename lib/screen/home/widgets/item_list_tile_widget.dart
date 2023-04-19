import 'package:employee_list_ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ItemListTileWidget extends StatelessWidget {
  ItemListTileWidget(
      {super.key,
      required this.name,
      required this.title,
      required this.date,
      this.toDate});
  String name;
  String title;
  String date;
  String? toDate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 106.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppStyles.normalText),
                  Text(title, style: AppStyles.smallText),
                  Row(
                    children: [
                      toDate == null
                          ? Text('From ', style: AppStyles.exsmallText)
                          : Container(),
                      Text(date, style: AppStyles.exsmallText),
                      toDate != null
                          ? Row(
                              children: [
                                Text(' - ', style: AppStyles.exsmallText),
                                Text(toDate!, style: AppStyles.exsmallText)
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1.h,
          )
        ],
      ),
    );
  }
}
