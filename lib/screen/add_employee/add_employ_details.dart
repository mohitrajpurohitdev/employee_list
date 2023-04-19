import 'dart:ffi';
import 'dart:math';

import 'package:employee_list_ui/bloc/employe_managment_bloc.dart';
import 'package:employee_list_ui/model/employ_data_model.dart';
import 'package:employee_list_ui/screen/add_employee/widgets/custom_calendar.dart';
import 'package:employee_list_ui/utils/app_string.dart';
import 'package:employee_list_ui/utils/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? initialForToDate;
  void _showRolesDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      builder: (BuildContext context) {
        return SizedBox(
          height: 245,
          child: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              title: const Text(
                AppString.productDesigner,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                _roleController.text = 'Product Designer';
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:
                  const Text('Flutter Developer', textAlign: TextAlign.center),
              onTap: () {
                _roleController.text = 'Flutter Developer';
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('QA Tester', textAlign: TextAlign.center),
              onTap: () {
                _roleController.text = 'QA Tester';
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Product Owner', textAlign: TextAlign.center),
              onTap: () {
                _roleController.text = 'Product Owner';
                Navigator.pop(context);
              },
            )
          ]).toList()),
        );
      },
    );
  }

  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();

  DateTime? date;
  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.r)),
      borderSide: const BorderSide(color: Color(0xffE5E5E5)));
  // Callback function to handle data updates from child widget

  void _toCallBack(DateTime? data) {
    initialForToDate = data;
    _toDateController.text =
        data != null ? DateFormat('d MMM y').format(data) : '';
  }

  void _noCallback(DateTime? data) {
    _fromDateController.text =
        data != null ? DateFormat('d MMM y').format(data) : '';
  }

  @override
  Widget build(BuildContext context) {
    String generateUniqueId() {
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      int random = Random().nextInt(10000);
      String uniqueId = '$timestamp$random';
      return uniqueId;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.addEmployeeDetails),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  TextFormField(
                    controller: _employeeNameController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      } else {
                        return AppString.valueCanNotBeEmpty;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      hintText: AppString.employeeName,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: SvgPicture.asset(
                          AppIcon.person,
                        ),
                      ),
                      border: border,
                      // errorBorder: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border,
                      // focusedErrorBorder: border,
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return AppString.roleCanNotBeEmpty;
                    },
                    readOnly: true,
                    controller: _roleController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: border,
                      // errorBorder: border,
                      focusedBorder: border,
                      enabledBorder: border,
                      disabledBorder: border,
                      // focusedErrorBorder: border,
                      hintText: AppString.selectRole,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: SvgPicture.asset(AppIcon.profession),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(AppIcon.arrowDown),
                        onPressed: _showRolesDialog,
                      ),
                    ),
                    onTap: _showRolesDialog,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                return null;
                              }
                              return AppString.dateCanNotBeEmpty;
                            },
                            readOnly: true,
                            onTap: () {
                              showCalendar(context, Theme.of(context), true,
                                  null, _toCallBack);
                            },
                            controller: _toDateController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: SvgPicture.asset(
                                  AppIcon.datePicker,
                                ),
                              ),
                              border: border,
                              focusedBorder: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              focusedErrorBorder: border,
                              hintText: AppString.today,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.r),
                        child: SvgPicture.asset(
                          AppIcon.arrowRight,
                          height: 9.h,
                          width: 13.w,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            if (_toDateController.text.isNotEmpty) {
                              showCalendar(context, Theme.of(context), false,
                                  initialForToDate, _noCallback);
                            }
                          },
                          controller: _fromDateController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: SvgPicture.asset(
                                AppIcon.datePicker,
                              ),
                            ),
                            border: border,
                            errorBorder: border,
                            focusedBorder: border,
                            enabledBorder: border,
                            disabledBorder: border,
                            focusedErrorBorder: border,
                            hintText: AppString.noDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Divider(
              height: 2.h,
              color: Colors.grey.withOpacity(0.4),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 73.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Color(0xffEDF8FF)),
                      child: Center(
                        child: Text(
                          AppString.cancel,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: const Color(0xff1DA1F2)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<EmployeeManagementBloc>(context).add(
                            AddEmployeEvent(
                                employDetails: EmployDetails(
                                    id: generateUniqueId(),
                                    name: _employeeNameController.text,
                                    toDate: _fromDateController.text,
                                    date: _toDateController.text,
                                    tittle: _roleController.text)));
                        Navigator.pop(context, true);
                      }
                    },
                    child: Container(
                      width: 73.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Color(0xff1DA1F2)),
                      child: Center(
                        child: Text(
                          AppString.save,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: const Color(0xffFFFFFF)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
