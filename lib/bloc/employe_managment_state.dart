part of 'employe_managment_bloc.dart';

@immutable
abstract class EmployeManagmentState {}

class EmployeManagmentInitial extends EmployeManagmentState {}

class EmployeManagmentLoadingState extends EmployeManagmentState {}

// ignore: must_be_immutable
class EmployeManagmentLoadedState extends EmployeManagmentState {
  List<EmployDetails>? employeeDetails;
  List<EmployDetails>? currentDetails;
  List<EmployDetails>? previousDetails;

  EmployeManagmentLoadedState(
      {required this.employeeDetails,
      required this.currentDetails,
      required this.previousDetails});
}

class EmployeManagmentDeletedState extends EmployeManagmentState {}
