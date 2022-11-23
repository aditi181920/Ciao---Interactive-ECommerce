import 'package:flutter/material.dart';
//Ticker as a special periodic timer that we can use to be notified when the Flutter engine is about to draw a new frame.
class LikeAnimation extends StatefulWidget {
  final Widget child;          //to make like animation parent widget
  final bool isAnimating;
  final Duration duration;        //how long the animation should continue
  final VoidCallback? onEnd;      //to end the like animation
  final bool smallLike;           //so that we can animate while clicking the smaller like button
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration=const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike=false,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin{ //single ticker means you can define only 1 animation controller in this widget..for multiple use full TickerProviderStateMixin
  //create a single ticker that only ticks when the current tree is enabled
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState(){
    super.initState();
    controller=AnimationController(vsync: this,duration: Duration(milliseconds:widget.duration.inMilliseconds ~/2));
    scale=Tween<double>(begin: 1,end: 1.2).animate(controller); //to contol the scale of the child
  }
  @override
  void didUpdateWidget( LikeAnimation oldWidget){
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating!=oldWidget.isAnimating){
      startAnimation();
    }
  }
  startAnimation() async{
    if(widget.isAnimating ||widget.smallLike){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(Duration(milliseconds: 200));
      if(widget.onEnd!=null){
        widget.onEnd!();
      }
    }
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scale,
        child: widget.child,
    );
  }
}
