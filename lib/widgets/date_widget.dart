import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class HCDatePicker extends StatefulWidget {
  Function onChanged;
  String hintText;

  HCDatePicker({super.key, required this.onChanged, required this.hintText});

  @override
  State<StatefulWidget> createState() {
    return _HCDatePickerState();
  }
}

class _HCDatePickerState extends State<HCDatePicker> {
  // 配置
  final config = CalendarDatePicker2WithActionButtonsConfig(
    dayTextStyle:
        const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
    calendarType: CalendarDatePicker2Type.single,
    selectedDayHighlightColor: Colors.black45,
    closeDialogOnCancelTapped: true,
    firstDayOfWeek: 1,
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    centerAlignModePicker: true,
    customModePickerIcon: const SizedBox(),
    selectedDayTextStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    dayTextStylePredicate: ({required date}) {
      TextStyle? textStyle;
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        textStyle =
            TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
      }
      if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
        textStyle = TextStyle(
          color: Colors.red[400],
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
        );
      }
      return textStyle;
    },
    yearBuilder: ({
      required year,
      decoration,
      isCurrentYear,
      isDisabled,
      isSelected,
      textStyle,
    }) {
      return Center(
        child: Container(
          decoration: decoration,
          height: 36,
          width: 72,
          child: Center(
            child: Semantics(
              selected: isSelected,
              button: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    year.toString(),
                    style: textStyle,
                  ),
                  if (isCurrentYear == true)
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2021, 8, 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      padding: EdgeInsets.zero,
      child: TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(100, 50)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: Colors.black38,
              width: 0.5,
            ),
          ),
        ),
        onPressed: () async {
          final values = await showCalendarDatePicker2Dialog(
            context: context,
            config: config,
            dialogSize: const Size(325, 400),
            borderRadius: BorderRadius.circular(15),
            value: _dialogCalendarPickerValue,
            dialogBackgroundColor: Colors.white,
          );
          if (values != null) {
            setState(() {
              _dialogCalendarPickerValue = values;
            });
            widget.onChanged.call(values);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _dialogCalendarPickerValue.isEmpty
                  ? widget.hintText
                  : _dialogCalendarPickerValue.first
                      .toString()
                      .replaceAll(' 00:00:00.000', ''),
              style: TextStyle(
                fontSize: 14,
                color: _dialogCalendarPickerValue.isNotEmpty
                    ? Colors.black
                    : Colors.black26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
