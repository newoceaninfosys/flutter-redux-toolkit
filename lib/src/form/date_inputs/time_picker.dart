import 'package:flutter/material.dart';

import 'input_dropdown.dart';
import 'time_config.dart';

class TimePicker extends StatelessWidget {
  TimePicker(
      {Key key, this.config, this.initialTime, this.onChange, this.label})
      : hasTouch = initialTime != null ? true : false,
        super(key: key);

  final TimeConfig config;
  final String label;
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onChange;

  bool hasTouch;

  TimeOfDay getInitialTime() {
    if (initialTime == null) return TimeOfDay.now();
    return initialTime;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: getInitialTime(),
        initialEntryMode: config.initialEntryMode,
        cancelText: config.cancelText,
        confirmText: config.confirmText,
        helpText: config.helpText);
    if (picked != null && (!hasTouch || picked != getInitialTime())) {
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
