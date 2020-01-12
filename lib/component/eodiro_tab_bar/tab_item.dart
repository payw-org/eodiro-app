import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EodiroTabItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;
  final Function onTap;

  EodiroTabItem({
    this.isSelected = false,
    this.label,
    @required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            bottom: 3.0,
          ),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? EodiroColors.eodiroBerry
                    : EodiroColors.baseGray,
              ),
              Container(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? EodiroColors.eodiroBerry
                        : EodiroColors.baseGray,
                    decoration: TextDecoration.none,
                  ),
                ),
                margin: const EdgeInsets.only(top: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
