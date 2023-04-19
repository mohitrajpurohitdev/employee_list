import 'package:bloc/bloc.dart';
import 'package:employee_list_ui/model/employ_data_model.dart';
import 'package:employee_list_ui/repo/employee_repo.dart';
import 'package:meta/meta.dart';

part 'employe_managment_event.dart';
part 'employe_managment_state.dart';

class EmployeeManagementBloc
    extends Bloc<EmployeManagmentEvent, EmployeManagmentState> {
  EmployeeManagementBloc() : super(EmployeManagmentInitial()) {
    EmployDetailsManager employDetailsManager = EmployDetailsManager();
    on<EmployeeManagmentInitialEvent>((event, emit) async {
      emit(EmployeManagmentLoadingState());
      List<EmployDetails>? employeeDetails =
          await employDetailsManager.getEmployDetailsList();
      List<EmployDetails>? previousDetails = [];
      List<EmployDetails>? currentDetails = [];
      if (employeeDetails != null) {
        for (var element in employeeDetails!) {
          if (element.toDate!.isEmpty) {
            currentDetails.add(element);
          }
        }

        for (var element in employeeDetails) {
          if (element.toDate!.isNotEmpty) {
            previousDetails.add(element);
          }
        }
      }

      emit(EmployeManagmentLoadedState(
          employeeDetails: employeeDetails,
          currentDetails: currentDetails,
          previousDetails: previousDetails));
    });

    on<AddEmployeEvent>((event, emit) async {
      await employDetailsManager.saveEmployee(event.employDetails);
    });
    on<EditEmployeEvent>((event, emit) async {
      await employDetailsManager.editEmployDetailsList(event.employDetails);
    });
    on<DeleteEmployeEvent>((event, emit) async {
      List<EmployDetails>? employeeDetails = await employDetailsManager
          .deleteEmployDetailsFromList(event.employDetails.id);
      List<EmployDetails>? previousDetails = [];
      List<EmployDetails>? currentDetails = [];

      if (employeeDetails != null) {
        for (var element in employeeDetails!) {
          if (element.toDate!.isEmpty) {
            currentDetails.add(element);
          }
        }

        for (var element in employeeDetails) {
          if (element.toDate!.isNotEmpty) {
            previousDetails.add(element);
          }
        }
      }
      emit(EmployeManagmentLoadedState(
          employeeDetails: employeeDetails,
          currentDetails: currentDetails,
          previousDetails: previousDetails));
    });

    on<UndoDeletedEmployeEvent>((event, emit) async {
      List<EmployDetails> employeeDetails =
          await employDetailsManager.undoLastAction();
      List<EmployDetails>? previousDetails = [];
      List<EmployDetails>? currentDetails = [];

      if (employeeDetails != null) {
        for (var element in employeeDetails!) {
          if (element.toDate!.isEmpty) {
            currentDetails.add(element);
          }
        }

        for (var element in employeeDetails) {
          if (element.toDate!.isNotEmpty) {
            previousDetails.add(element);
          }
        }
      }
      emit(EmployeManagmentLoadedState(
          employeeDetails: employeeDetails,
          currentDetails: currentDetails,
          previousDetails: previousDetails));
    });
  }
}
