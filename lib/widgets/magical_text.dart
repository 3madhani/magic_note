import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  final Duration duration;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
    this.colors = const [
      Color(0xFF667eea),
      Color(0xFF764ba2),
      Color(0xFFf093fb),
      Color(0xFF667eea),
    ],
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class MagicalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color> gradientColors;
  final TextAlign? textAlign;
  final bool animate;

  const MagicalText({
    super.key,
    required this.text,
    this.style,
    this.gradientColors = const [
      Color(0xFF667eea),
      Color(0xFF764ba2),
      Color(0xFFf093fb),
    ],
    this.textAlign,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget textWidget = ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style:
            style?.copyWith(color: Colors.white) ??
            Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        textAlign: textAlign,
      ),
    );

    if (animate) {
      return textWidget
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.3));
    }

    return textWidget;
  }
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: widget.colors,
              stops: [0.0, _animation.value * 0.5, _animation.value, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style:
                widget.style?.copyWith(color: Colors.white) ??
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat();
  }
}
