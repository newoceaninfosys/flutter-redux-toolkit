import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_config.dart';
import 'input_dropdown.dart';

class DatePicker extends StatelessWidget {
  DatePicker(
      {Key key, this.config, this.initialDate, this.onChange, this.label})
      : hasTouch = initialDate != null ? true : false,
        super(key: key);

  final DateConfig config;
  final String label;
  final DateTime initialDate;
  final ValueChanged<DateTime> onChange;

  bool hasTouch;

  DateTime getInitialDate() {
    if (initialDate == null) return DateTime.now();
    return initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: getInitialDate(),
        firstDate: config.firstDate,
        lastDate: config.lastDate,
        selectableDayPredicate: (DateTime date) {
          bool greater = true;
          bool less = true;
          if (config.minDate != null) {
            greater = date.compareTo(config.minDate) ==
                1; // date greater than minDate
          }
          if (config.maxDate != null) {
            less =
                date.compareTo(config.maxDate) == -1; // date less than maxDate
          }
          return greater && less;
        });
    if (picked != null && (!hasTouch || picked != getInitialDate())) {
      hasTouch = true;
      onChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.body1;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Expanded(
          child: new InputDropdown(
            labelText: label,
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
      ],
    );
  }
}
