import 'package:app1/model/story.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/brand.dart';

class storyScreen extends StatefulWidget {
  final Brand b;
  final List<Story> st;
  const storyScreen({
    Key? key,
    required this.b,
    required this.st,
  }) : super(key: key);

  @override
  State<storyScreen> createState() => _storyScreenState();
}

class _storyScreenState extends State<storyScreen>
with SingleTickerProviderStateMixin{
  late AnimationController _animController;
  PageController _pageController=PageController();
  int currentIndex=0;
  VideoPlayerController? _videoController;
  @override
  void initState(){
    super.initState();
    _pageController=PageController();
    // _videoController=VideoPlayerController.asset(widget.st[widget.st.length-1].url)
    //  ..addListener(()=> setState(() {}))
    //  ..setLooping(true)
    //  ..initialize();
   // _videoController!.play();
     _animController=AnimationController(vsync: this);
     final Story fireStory =widget.st.first;
     loadStory(story: fireStory,animateToPage: false);
    _animController.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        _animController.stop();
        _animController.reset();
        setState(() {
          if(currentIndex+1<widget.st.length){
            currentIndex+=1;
            loadStory(story:widget.st[currentIndex]);
          }else{
            currentIndex=0;
            loadStory(story:widget.st[currentIndex]);
          }
        });
      }
    });
    print('current video url is:');
    print(widget.st[widget.st.length-1].url);
  }

  @override
  void dispose(){
    _videoController?.dispose();
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent.shade700.withOpacity(0.15),
      body:GestureDetector(
        onTapDown: (details)=>onTapDown(details,widget.st[currentIndex]),
        child:
          Stack(
            children: [
              PageView.builder(    //this takes up the entire screen
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(), //disable scrolling
                  itemCount: widget.st.length,
                  itemBuilder:(context,i){
                    final Story story=widget.st[i];
                    switch(story.media){
                      case 'MediaType.image':
                        return Container(
                          padding: EdgeInsets.all(30),
                            child: Image.asset(story.url,fit: BoxFit.cover,),
                        );
                      case 'MediaType.video':
                        if(_videoController!=null && _videoController!.value.isInitialized){
                          _videoController!.play();
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0,30,0,30),
                            child: FittedBox(
                              fit: BoxFit.contain,
                               child: SizedBox(
                                 width: _videoController!.value.size.width,
                                 height: _videoController!.value.size.height-40,
                                 child: VideoPlayer(_videoController!),
                               ),
                            ),
                          );
                        }
                    }
                    return SizedBox.shrink(child: Text('hello video not detected',style: TextStyle(
                      color: Colors.white,
                    ),),);
                  },
              ),
              Positioned(
                  top: 10.0,
                  left: 10.0,
                  right: 10.0,
                  child: Column(
                    children: [
                      Row(
                         children: widget.st.asMap().map((i, e){ //conversion to map for accessing position of the current story in left of stories
                           return MapEntry(i, AnimatedBar(
                             animController:_animController,
                             position: i,
                             currentIndex:currentIndex,
                           ));
                         }).values.toList(),
                      ),
                      Padding(padding: EdgeInsets.symmetric(
                        horizontal: 1.5,
                        vertical: 10.0,

                      ),
                        child: BrandInfo(br:widget.b),
                      ),
                    ],
                  ),
              ),
            ],
          ),
      ),
    );
  }
  void onTapDown(TapDownDetails details,Story story){
    //separate screen.. for taping in different parts of the screen
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx=details.globalPosition.dx;
    //divide screen in 3 parts for a current story
    if(dx<screenWidth/3){
      setState(() {
        if(currentIndex-1 >=0){
          currentIndex-=1;
          loadStory(story: widget.st[currentIndex]);
        }
      });
    }else if(dx>2*screenWidth/3){
      setState(() {
        if(currentIndex+1<widget.st.length){
          currentIndex+=1;
          loadStory(story: widget.st[currentIndex]);
        }else{
          currentIndex=0;  //start from starting of story since outof bounds
          loadStory(story: widget.st[currentIndex]);
        }
      });
    }else{
      if(story.media=='MediaType.video'){
        if(_videoController!.value.isPlaying){
          _videoController!.pause();
          _animController.stop();
        }else{
          _videoController!.play();
          _animController.forward();
        }
      }
    }

  }
  void loadStory({required Story story,bool animateToPage=true}){
    _animController.stop();
    _animController.reset();  //to stop and reset the bar animation
    switch(story.media){
      case 'MediaType.image':
        _animController.duration=story.duration as Duration?;
        _animController.forward();   //start animation
        break;
      case 'MediaType.video':
        _videoController=null;
        _videoController?.dispose();
        _videoController=VideoPlayerController.asset(story.url)
            ..initialize().then((value){
              setState(() {

              });
              if(_videoController!.value.isInitialized){
                _animController.duration=_videoController!.value.duration;
                _videoController!.play();
                _animController.forward();
              }
            });
        break;
    }
    if(animateToPage){ //for moving to prev or next page
      _pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 1),  //greater than 0 duration req
          curve: Curves.easeInOut,
      );
    }
  }
}


class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;
  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: LayoutBuilder( //the final size will depend on child's size.
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer( //completely filled for constructing all the bars
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(  //for including animation ... constructing current bar
                  animation: animController,
                  builder: (context, child) {
                    return _buildContainer(
                      constraints.maxWidth * animController.value,
                      Colors.white,
                    );
                  },
                )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) { //returns rounded container
    return Container(
      height: 10.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}


class BrandInfo extends StatelessWidget {  //to display brand icon and name above
  final Brand br;

  const BrandInfo({
    Key? key,
    required this.br,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(
              br.profileImageUrl,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              br.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 30.0,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}