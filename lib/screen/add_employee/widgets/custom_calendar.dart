import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Mcalendar extends StatefulWidget {
  Mcalendar(
      {required this.isToDateCalendar,
      required this.callback,
      this.initialDate,
      super.key});
  bool isToDateCalendar;
  DateTime? initialDate;
  final Function(DateTime?) callback;

  @override
  State<Mcalendar> createState() => _McalendarState();
}

class _McalendarState extends State<Mcalendar> {
  DateTime calenderDate = DateTime.now();
  DateTime today = DateTime.now();
  DateTime? _selectedFirst;
  String? selectedButton;

  int lastDay = 1;
  List<String> weekDayByName = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      child: Container(
        width: 328,
        decoration: BoxDecoration(
            color: const Color(0xffF8F8FF),
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16.h,
            ),
            widget.isToDateCalendar
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          height: 41.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _onDateSelected(DateTime.now());
                                    selectedButton = 'Today';
                                  },
                                  child: button('Today'),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    DateTime now =
                                        _selectedFirst ?? DateTime.now();

                                    // Find the next Monday
                                    DateTime nextMonday;
                                    if (now.weekday == DateTime.monday) {
                                      // If today is Monday, add 7 days to get next Monday
                                      nextMonday =
                                          now.add(const Duration(days: 7));
                                    } else {
                                      // If today is not Monday, find the next Monday in the future
                                      int daysUntilNextMonday =
                                          DateTime.monday - now.weekday;
                                      if (daysUntilNextMonday < 0) {
                                        // If today is after Monday, add 7 days to get next Monday
                                        daysUntilNextMonday += 7;
                                      }
                                      nextMonday = now.add(
                                          Duration(days: daysUntilNextMonday));
                                    }
                                    _selectedFirst = nextMonday;
                                    selectedButton = 'Next Monday';
                                    _onDateSelected(nextMonday);
                                  },
                                  child: button('Next Monday'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          height: 41.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    DateTime now =
                                        _selectedFirst ?? DateTime.now();

                                    DateTime nextTuesday;
                                    if (now.weekday == DateTime.tuesday) {
                                      // If today is Tuesday, add 7 days to get next Tuesday
                                      nextTuesday =
                                          now.add(const Duration(days: 7));
                                    } else {
                                      // If today is not Tuesday, find the next Tuesday in the future
                                      int daysUntilNextTuesday =
                                          DateTime.tuesday - now.weekday;
                                      if (daysUntilNextTuesday < 0) {
                                        // If today is after Tuesday, add 7 days to get next Tuesday
                                        daysUntilNextTuesday += 7;
                                      }
                                      nextTuesday = now.add(
                                          Duration(days: daysUntilNextTuesday));
                                    }
                                    selectedButton = 'Next Tuesday';
                                    _onDateSelected(nextTuesday);
                                  },
                                  child: button('Next Tuesday'),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    DateTime now =
                                        _selectedFirst ?? DateTime.now();

                                    // Add 1 week to the current date and time
                                    DateTime nextWeek =
                                        now.add(const Duration(days: 7));

                                    selectedButton = 'After 1 week';
                                    _onDateSelected(nextWeek);
                                  },
                                  child: button('After 1 week'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      height: 41.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                DateTime now = _selectedFirst ?? DateTime.now();

                                // Find the next Monday
                                DateTime nextMonday;
                                if (now.weekday == DateTime.monday) {
                                  // If today is Monday, add 7 days to get next Monday
                                  nextMonday = now.add(const Duration(days: 7));
                                } else {
                                  // If today is not Monday, find the next Monday in the future
                                  int daysUntilNextMonday =
                                      DateTime.monday - now.weekday;
                                  if (daysUntilNextMonday < 0) {
                                    // If today is after Monday, add 7 days to get next Monday
                                    daysUntilNextMonday += 7;
                                  }
                                  nextMonday = now
                                      .add(Duration(days: daysUntilNextMonday));
                                }
                                _selectedFirst = nextMonday;
                                selectedButton = 'No date';
                                _onDateSelected(null);
                              },
                              child: button('No date'),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _onDateSelected(DateTime.now());
                                selectedButton = 'Today';
                              },
                              child: button('Today'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(
              height: 16.h,
            ),
            Column(
              children: [
                SizedBox(
                  height: 325.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 7.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: widget.initialDate != null
                                  ? (calenderDate.month ==
                                              widget.initialDate!.month) &&
                                          calenderDate.year ==
                                              widget.initialDate!.year
                                      ? null
                                      : _goToPreviousMonth
                                  : _goToPreviousMonth,
                              child: Icon(
                                Icons.arrow_left,
                                color: widget.initialDate != null
                                    ? (calenderDate.month ==
                                                widget.initialDate!.month) &&
                                            calenderDate.year ==
                                                widget.initialDate!.year
                                        ? Colors.grey.shade400
                                        : Colors.black
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              _getMonthYearString(calenderDate),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: _goToNextMonth,
                              child: const Icon(
                                Icons.arrow_right,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                        child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: [
                              ...weekDayByName
                                  .map((e) => Padding(
                                        padding: EdgeInsets.all(2.r),
                                        child: SizedBox(
                                          width: 39.w,
                                          height: 36.h,
                                          child: Center(
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()
                            ]),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(
                          child: _buildCalendar(
                              context, theme, 0xff1DA1F2, 0xff1DA1F2)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        _selectedFirst != null
                            ? DateFormat('MMM dd').format(_selectedFirst!)
                            : 'No date',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _onDateSelected(null);

                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 41.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 204, 239, 255),
                              border: Border.all(
                                color: const Color.fromARGB(255, 204, 239, 255),
                              ),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 41.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: Colors.blue,
                            ),
                            child: const Center(
                              child: Text(
                                'save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  button(String name) {
    return selectedButton == name
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ))
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: const Color(0xffEDF8FF),
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ));
  }

  Widget _buildCalendar(
      BuildContext context, ThemeData theme, int color1, int color2) {
    DateTime lastDate =
        DateTime(calenderDate.year, calenderDate.month, lastDay);
    List<Widget> calendarTiles = [];
    List<Widget> finalList = [];
    DateTime firstDayOfMonth = lastDate;
    List<Widget> temwidget = [];

    bool daysrmore30 = false;
    int b =
        DateUtils.getDaysInMonth(firstDayOfMonth.year, firstDayOfMonth.month);
    daysrmore30 = b > 30 ? true : false;

    for (int i = 1; i < 43; i++) {
      DateTime date = DateTime(firstDayOfMonth.year, firstDayOfMonth.month, i);
      DateTime lastDate =
          DateTime(firstDayOfMonth.year, firstDayOfMonth.month, 0);

      bool isSameDate(DateTime date1, DateTime date2) {
        return date1.year == date2.year &&
            date1.month == date2.month &&
            date1.day == date2.day;
      }

      bool isFirstSelected =
          _selectedFirst != null ? isSameDate(date, _selectedFirst!) : false;

      if (i == 37) {
        DateTime date0 = DateTime(
            firstDayOfMonth.year, firstDayOfMonth.month, firstDayOfMonth.day);
        for (int i = 0; i <= date0.weekday - 1; i++) {
          isFirstSelected = _selectedFirst != null
              ? lastDate
                  .subtract(Duration(days: i))
                  .isAtSameMomentAs(_selectedFirst!)
              : false;

          temwidget.add(Padding(
            padding: EdgeInsets.all(2.r),
            child: SizedBox(
              width: 39.w,
              height: 36.h,
            ),
          ));
        }
      }
      DateTime today12am =
          widget.initialDate ?? DateTime(today.month, today.day, 0, 0, 0, 0);
      calendarTiles.add(InkWell(
          onTap: date.isBefore(today12am)
              ? null
              : () {
                  selectedButton = '';
                  _onDateSelected(date);
                },
          child: date.isBefore(today12am)
              ? Padding(
                  padding: EdgeInsets.all(2.r),
                  child: SizedBox(
                    width: 39.w,
                    height: 36.h,
                    child: Center(
                      child: Text(
                        "${date.day}",
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              : isFirstSelected
                  ? Padding(
                      padding: EdgeInsets.all(2.r),
                      child: SizedBox(
                        width: 39.w,
                        height: 36.h,
                        child: Center(
                          child: Text(
                            "${date.day}",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(2.r),
                      child: SizedBox(
                        width: 39.w,
                        height: 36.h,
                        child: Center(
                          child: Text(
                            "${date.day}",
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )));
    }

    finalList = [...temwidget.reversed, ...calendarTiles];

    return Wrap(
        direction: Axis.horizontal,
        children: finalList.sublist(
            0,
            daysrmore30
                ? ((firstDayOfMonth.weekday) + 31)
                : ((firstDayOfMonth.weekday) + 30)));
  }

  String _getMonthYearString(DateTime date) {
    return "${_getMonthString(date.month)} ${date.year}";
  }

  String _getMonthString(int month) {
    List<String> months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month];
  }

  void _onDateSelected(DateTime? date) {
    _selectedFirst = date;
    widget.callback(_selectedFirst);
    setState(() {});
  }

  void _goToPreviousMonth() {
    setState(() {
      calenderDate =
          DateTime(calenderDate.year, calenderDate.month - 1, calenderDate.day);
    });
  }

  void _goToNextMonth() {
    setState(() {
      calenderDate =
          DateTime(calenderDate.year, calenderDate.month + 1, calenderDate.day);
    });
  }
}

showCalendar(BuildContext context, ThemeData theme, bool isToDateCalendar,
    DateTime? initialdate, Function(DateTime?) callbac) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                insetPadding: EdgeInsets.zero,
                child: Mcalendar(
                  isToDateCalendar: isToDateCalendar,
                  callback: callbac,
                  initialDate: initialdate,
                )),
          ));
}
