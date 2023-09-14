import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Stars extends StatelessWidget {
  final int selected;
  final int maxStars;
  final void Function(int value)? onTap;

  const Stars({
    super.key,
    this.selected = 0,
    this.maxStars = 3,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...List<Widget>.generate(
          maxStars,
          (index) => _Star(
            starValue: index + 1,
            selected: index < selected,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  final int starValue;
  final bool selected;
  final void Function(int value)? onTap;

  const _Star({required this.starValue, required this.selected, this.onTap});

  @override
  Widget build(BuildContext context) {
    var color = selected
        ? ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          )
        : const ColorFilter.mode(
            Color(0xFFEDEDED),
            BlendMode.srcIn,
          );
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: InkWell(
          onTap: onTap == null ? null : () => onTap?.call(starValue),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              'assets/icons/star.svg',
              colorFilter: color,
              width: 32,
              height: 32,
            ),
          ),
        ),
      ),
    );
  }
}
