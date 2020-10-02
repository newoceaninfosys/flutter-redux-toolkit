import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_config.dart';
import 'input_dropdown.dart';
import 'time_config.dart';

class DateTimePicker extends StatelessWidget {
  DateTimePicker(
      {Key key,
      this.timeConfig,
      this.dateConfig,
      this.initialDateTime,
      this.onChange,
      this.label})
      : hasTouch = initialDateTime != null ? true : false,
        super(key: key);

  final TimeConfig timeConfig;
  final DateConfig dateConfig;
  final String label;
  final DateTime initialDateTime;
  final ValueChanged<DateTime> onChange;

  bool hasTouch;

  DateTime getInitialDate() {
    if (initialDateTime == null) return DateTime.now();
    return initialDateTime;
  }

  TimeOfDay getInitialTime() {
    if (initialDateTime == null) return TimeOfDay.now();
    return TimeOfDay.fromDateTime(initialDateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: getInitialDate(),
        firstDate: dateConfig.firstDate,
        lastDate: dateConfig.lastDate,
        selectableDayPredicate: (DateTime date) {
          bool greater = true;
          bool less = true;
          if (dateConfig.minDate != null) {
            greater = date.compareTo(dateConfig.minDate) ==
                1; // date greater than minDate
          }
          if (dateConfig.maxDate != null) {
            less = date.compareTo(dateConfig.maxDate) ==
                -1; // date less than maxDate
          }
          return greater && less;
        });
    if (picked != null && (!hasTouch || picked != getInitialDate())) {
      hasTouch = true;
      var date = picked;
      var time = getInitialTime();
      onChange(new DateTime(
          date.year, date.month, date.day, time.hour, time.minute));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: getInitialTime(),
        initialEntryMode: timeConfig.initialEntryMode,
        cancelText: timeConfig.cancelText,
        confirmText: timeConfig.confirmText,
        helpText: timeConfig.helpText);
    if (picked != null && (!hasTouch || picked != getInitialTime())) {
      hasTouch = true;
      var date = getInitialDate();
      var time = picked;
      onChange(new DateTime(
          date.year, date.month, date.day, time.hour, time.minute));
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          flex: 4,
          child: new InputDropdown(
            valueText:
                hasTouch ? DateFormat.yMd().format(getInitialDate()) : '',
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
            icon: new Icon(Icons.today,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new InputDropdown(
            valueText: hasTouch ? getInitialTime().format(context) : '',
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
            icon: new Icon(Icons.access_time,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ),
        ),
      ],
    );
  }
}
