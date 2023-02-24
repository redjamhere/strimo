// опписания дизайна чекбоксов
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';

class GradientCheckBox extends StatelessWidget {
  final ValueChanged onChanged;
  bool value;
  final String label;

  GradientCheckBox({Key? key, required this.onChanged, required this.value, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 19,
              width: 19,
              decoration: BoxDecoration(
                  gradient: (value) ? JoyveeGradients.kDarkBlueGradient : null,
                  borderRadius: BorderRadius.circular(5),
              ),
              child: Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            ),
            const SizedBox(width: 17),
            Text(label, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),)
          ],
        ),
      ),
    );
  }
}

class StreamSettingCheckbox extends StatelessWidget {
  final Function(bool) onChanged;
  bool value;
  final Widget label;

  StreamSettingCheckbox({required this.onChanged, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          label,
          Transform.scale(
            scale: 1.2,
            child: Switch(
                value: value,
                onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
