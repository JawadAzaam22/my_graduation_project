
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/Live%20training/view_course_triannig_controller.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';








class CalWid extends GetWidget<ViewCourseTriannigController> {
  CalWid({super.key});
  List<DateTime> _getEventDates() {
    return controller.sessions.map((event) {
      if (event.date == null || event.date!.isEmpty) return DateTime.now();

      try {

        return DateFormat('yyyy-MM-dd').parse(event.date!);
      } catch (e) {
        print('خطأ في تحويل التاريخ: ${event.date}');
        return DateTime.now();
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final eventDates = _getEventDates();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TableCalendar(
          focusedDay: DateTime.now(),
          currentDay: DateTime.now(),
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 1, 1),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarBuilders: CalendarBuilders(

            defaultBuilder: (context, day, focusedDay) {
              final isEventDay = eventDates.any((eventDate) => isSameDay(day, eventDate));
              if (isEventDay) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 7.h,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 1.w),
                          ),
                        ),
                        Container(
                          width: 7.h,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1.w),
                          ),
                        ),
                        Container(
                          width: 7.h,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 1.w),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return null;
            },

            todayBuilder: (context, day, focusedDay) {
              final isEventToday = eventDates.any((eventDate) => isSameDay(day, eventDate));
              if (isEventToday) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 28.w,
                        height: 28.h,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 7.h,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 1.w),
                          ),
                        ),
                        Container(
                          width: 7.h,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 1.w),
                          ),
                        ),
                        Container(
                          width: 7.h,
                          height: 7.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 1.w),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return null;

            },
          ),
          onDaySelected: (selectedDay, focusedDay) {
            final eventsOnDay = controller.sessions.where((event) {
              final eventDate = DateFormat('yyyy-MM-dd').parse(event.date ?? "");
              return isSameDay(eventDate, selectedDay);
            }).toList();

            if (eventsOnDay.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title:  Text(AppLocalizations.of(context)!.lessons),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                    eventsOnDay.map((e) => Text(e.title ?? '')).toList(),
                  ),
                  actions: [
                    TextButton(
                      onPressed:
                          () => Navigator.pop(context),
                      child:
                      Icon(Icons.navigate_next_rounded),
                    ),
                  ],
                ),
              );
            }
          },
          calendarStyle:
          CalendarStyle(todayTextStyle:
          TextStyle(fontSize:
          16.sp).copyWith(fontWeight:
          FontWeight.normal,), todayDecoration:
          BoxDecoration(color:
          Colors.transparent,),),
        ),
      ),
    );
  }


}












