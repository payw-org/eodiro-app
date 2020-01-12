import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EodiroTabBarItem extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;

  EodiroTabBarItem({
    @required this.index,
    @required this.label,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final EodiroTabBarBloc tabBloc = Provider.of<EodiroTabBarBloc>(context);
    final isSelected = index == tabBloc.tabIndex;
    const double iconSize = 24;
    const double labelSize = 11;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          tabBloc.tabIndex = index;
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
            // bottom: 3.0,
          ),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Icon(
                icon,
                size: iconSize,
                color: isSelected
                    ? EodiroColors.eodiroBerry
                    : EodiroColors.baseGray,
              ),
              Container(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: labelSize,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? EodiroColors.eodiroBerry
                        : EodiroColors.baseGray,
                    decoration: TextDecoration.none,
                  ),
                ),
                margin: const EdgeInsets.only(top: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
