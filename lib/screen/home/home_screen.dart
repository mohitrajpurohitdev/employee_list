import 'package:employee_list_ui/bloc/employe_managment_bloc.dart';
import 'package:employee_list_ui/screen/edit_employee/Edit_screen.dart';
import 'package:employee_list_ui/screen/add_employee/add_employ_details.dart';
import 'package:employee_list_ui/screen/home/widgets/item_list_tile_widget.dart';
import 'package:employee_list_ui/utils/app_string.dart';
import 'package:employee_list_ui/utils/app_styles.dart';
import 'package:employee_list_ui/utils/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<EmployeeManagementBloc>(context)
        .add(EmployeeManagmentInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeManagmentState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text(AppString.employeeList),
              ),
              body: (state is EmployeManagmentLoadingState)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (state is EmployeManagmentLoadedState &&
                          state.employeeDetails != null &&
                          state.employeeDetails!.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 52.h,
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  const Text(
                                    AppString.currentEmployees,
                                    style: TextStyle(color: Color(0xff1DA1F2)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.currentDetails!.length,
                                itemBuilder: (ctx, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      BlocProvider.of<EmployeeManagementBloc>(
                                              context)
                                          .add(DeleteEmployeEvent(
                                              employDetails: state
                                                  .currentDetails![index]));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              AppString.dataIsDeleted),
                                          action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {
                                              BlocProvider.of<
                                                          EmployeeManagementBloc>(
                                                      context)
                                                  .add(
                                                      UndoDeletedEmployeEvent());
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.r),
                                            child: SvgPicture.asset(
                                                AppIcon.delete),
                                          )
                                        ],
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EditEmployeeDetails(
                                                        employeeDetails: state
                                                                .currentDetails![
                                                            index])))
                                            .then((value) {
                                          if (value == true) {
                                            BlocProvider.of<
                                                        EmployeeManagementBloc>(
                                                    context)
                                                .add(
                                                    EmployeeManagmentInitialEvent());
                                          }
                                        });
                                      },
                                      child: ItemListTileWidget(
                                          name:
                                              state.currentDetails![index].name,
                                          title: state
                                              .currentDetails![index].tittle,
                                          date: state
                                              .currentDetails![index].date),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 52.h,
                              color: Colors.grey.shade100,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  const Text(
                                    AppString.previousEmployees,
                                    style: TextStyle(color: Color(0xff1DA1F2)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.previousDetails!.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      BlocProvider.of<EmployeeManagementBloc>(
                                              context)
                                          .add(DeleteEmployeEvent(
                                              employDetails: state
                                                  .previousDetails![index]));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                              AppString.dataIsDeleted),
                                          action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {
                                              BlocProvider.of<
                                                          EmployeeManagementBloc>(
                                                      context)
                                                  .add(
                                                      UndoDeletedEmployeEvent());
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8.r),
                                            child: SvgPicture.asset(
                                                AppIcon.delete),
                                          )
                                        ],
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EditEmployeeDetails(
                                                        employeeDetails: state
                                                                .previousDetails![
                                                            index])))
                                            .then((value) {
                                          if (value == true) {
                                            BlocProvider.of<
                                                        EmployeeManagementBloc>(
                                                    context)
                                                .add(
                                                    EmployeeManagmentInitialEvent());
                                          }
                                        });
                                      },
                                      child: ItemListTileWidget(
                                        name:
                                            state.previousDetails![index].name,
                                        title: state
                                            .previousDetails![index].tittle,
                                        date:
                                            state.previousDetails![index].date,
                                        toDate: state
                                            .previousDetails![index].toDate,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: 96.h,
                              color: Colors.grey.shade100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: Text(
                                      AppString.swipeLeftDelete,
                                      style: AppStyles.greyText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcon.noemail),
                            const Center(
                              child: Text(AppString.noRecordFound),
                            )
                          ],
                        ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => const AddEmployee()))
                      .then((value) =>
                          BlocProvider.of<EmployeeManagementBloc>(context)
                              .add(EmployeeManagmentInitialEvent()));
                },
                backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: const Icon(Icons.add),
              ));
        });
  }
}
