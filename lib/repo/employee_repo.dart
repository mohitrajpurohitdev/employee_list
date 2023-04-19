import 'dart:convert';

import 'package:employee_list_ui/model/employ_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployDetailsManager {
  String employeeListKey = 'employees';
  EmployDetails? lastDeletedEmployee;
  int? lastDeleteIndex;
  Future saveEmployee(EmployDetails employee) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> employees = prefs.getStringList(employeeListKey) ?? [];
    employees.add(json.encode(employee.toJson()));
    await prefs.setStringList(employeeListKey, employees);
    return employees;
  }

  Future<void> editEmployDetailsList(EmployDetails employDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<EmployDetails>? employDetailsList = await getEmployDetailsList();
    int index = employDetailsList!
        .indexWhere((employee) => employee.id == employDetails.id);
    if (index != -1) {
      employDetailsList[index].name = employDetails.name;
      employDetailsList[index].tittle = employDetails.tittle;
      employDetailsList[index].date = employDetails.date;
      employDetailsList[index].toDate = employDetails.toDate;
    }
    List<String> updatedList = employDetailsList
        .map((employDetails) => jsonEncode(employDetails.toJson()))
        .toList();
    if (updatedList.isNotEmpty) {
      await prefs.setStringList(employeeListKey, updatedList);
    }
  }

  Future<void> deleteEmployDetailsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(employeeListKey);
  }

  Future<List<EmployDetails>?> getEmployDetailsList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(employeeListKey);
    if (jsonList != null) {
      List<EmployDetails> employDetailsList = jsonList
          .map((json) => EmployDetails.fromJson(jsonDecode(json)))
          .toList();
      return employDetailsList;
    } else {
      return null;
    }
  }

  Future<List<EmployDetails>?> deleteEmployDetailsFromList(
      String employeeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<EmployDetails>? employDetailsList = await getEmployDetailsList();
    lastDeleteIndex =
        employDetailsList?.indexWhere((element) => element.id == employeeId);
    lastDeletedEmployee = employDetailsList![lastDeleteIndex ?? 0];
    employDetailsList.removeWhere((element) => element.id == employeeId);
    List<String> updatedList = employDetailsList
        .map((employDetails) => jsonEncode(employDetails.toJson()))
        .toList();
    await prefs.setStringList(employeeListKey, updatedList);
    return employDetailsList;
  }

  Future undoLastAction() async {
    if (lastDeletedEmployee != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> employees = prefs.getStringList(employeeListKey) ?? [];
      if (employees.isNotEmpty) {
        employees.insert(lastDeleteIndex!, json.encode(lastDeletedEmployee));
      } else {
        employees.add(json.encode(lastDeletedEmployee));
      }
      await prefs.setStringList(employeeListKey, employees);
      return await getEmployDetailsList();
    }
  }
}
