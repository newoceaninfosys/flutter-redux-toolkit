import 'package:flutter/material.dart';

// Define a custom Form widget.
class InputDropdown extends StatefulWidget {
  const InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed,
      this.icon})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;
  final Widget icon;

  @override
  _InputDropdown createState() => _InputDropdown();
}

class _InputDropdown extends State<InputDropdown> {
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        widget.onPressed();
        focusNode.requestFocus();
      },
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: widget.labelText,
        ),
        baseStyle: widget.valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(widget.valueText, style: widget.valueStyle),
            widget.icon
          ],
        ),
      ),
    );
  }
}

// Container(
// width: 0.1,
// height: 0.1,
// child: new TextField(
// controller: controller,
// focusNode: focusNode,
// readOnly: true,
// style: TextStyle(fontSize: 0, height: 0),
// ),
// ),
