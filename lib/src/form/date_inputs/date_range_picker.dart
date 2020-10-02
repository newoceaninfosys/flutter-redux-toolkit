import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_range_config.dart';
import 'input_dropdown.dart';

class DateRangePicker extends StatelessWidget {
  DateRangePicker(
      {Key key, this.config, this.initialDateRange, this.onChange, this.label})
      : hasTouch = initialDateRange != null ? true : false,
        super(key: key);

  final DateRangeConfig config;
  final String label;
  final DateTimeRange initialDateRange;
  final ValueChanged<DateTimeRange> onChange;

  bool hasTouch;

  DateTimeRange getInitialDateRange() {
    if (initialDateRange == null)
      return new DateTimeRange(start: DateTime.now(), end: DateTime.now());
    return initialDateRange;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange picked = await showDateRangePicker(
        context: context,
        initialDateRange: getInitialDateRange(),
        firstDate: config.firstDate,
        lastDate: config.lastDate);
    if (picked != null && (!hasTouch || picked != getInitialDateRange())) {
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
            valueText: hasTouch
                ? DateFormat.yMd().format(getInitialDateRange().start) +
                    '  ➞ ' +
                    DateFormat.yMd().format(getInitialDateRange().end)
                : '',
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
            icon: new Icon(Icons.date_range,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ),
        ),
      ],
    );
  }
}
