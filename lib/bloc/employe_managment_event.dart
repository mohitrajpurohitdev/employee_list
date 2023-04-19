// ignore_for_file: must_be_immutable

part of 'employe_managment_bloc.dart';

@immutable
abstract class EmployeManagmentEvent {}

class EmployeeManagmentInitialEvent extends EmployeManagmentEvent {}

class AddEmployeEvent extends EmployeManagmentEvent {
  EmployDetails employDetails;
  AddEmployeEvent({required this.employDetails});
}

class EditEmployeEvent extends EmployeManagmentEvent {
  EmployDetails employDetails;
  EditEmployeEvent({required this.employDetails});
}

class DeleteEmployeEvent extends EmployeManagmentEvent {
  EmployDetails employDetails;
  DeleteEmployeEvent({required this.employDetails});
}

class UndoDeletedEmployeEvent extends EmployeManagmentEvent {}
