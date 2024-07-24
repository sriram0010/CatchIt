import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:CatchIT/hp1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class MovingScreen extends StatefulWidget {
 // final List<ImageProvider?> images;
final ImageProvider im1,im2;
  const MovingScreen( {Key? key, required this.im1,required this.im2}) : super(key: key);

  @override
  State<MovingScreen> createState() => _MovingScreenState();
}

class _MovingScreenState extends State<MovingScreen> {
  final List<Color> _colors = [Colors.green, Colors.red];
  final Random _random = Random();
  final List img=["images/x1.png","images/x2.png",];

  final List<ContainerData> _containers = [];
  double y1=0;
  int xx=0; int x1=1;
  double x=1.0;
  bool _gameOver = false; bool n= false;
 late List im;
  @override
  void initState() {
    super.initState();
     im=[widget.im1,widget.im2];
    _startGame();
  }

  void _startGame() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_gameOver) {
        timer.cancel();
        return;
      }
      _addContainer();
      if(x>3.5 && x1<4 ){
        up();
      }
    });
  }
  void ok(){
    setState(() {
      x+=0.05;
    });
  }

  ImageProvider<Object> g2() {
      return  im[_random.nextInt(im.length)]!;
  }

  void _addContainer() {
    final size = MediaQuery.of(context).size;
    const containerSize = 50.0;
    final containerX = _random.nextDouble() * (size.width - containerSize);
    final containerData = ContainerData(
      x: containerX,
      y: size.height,
      color: _colors[_random.nextInt(_colors.length)],
      isClickable: true,
      image:g2()
    );
    setState(() {
      _containers.add(containerData);
      ok();

    });

    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_gameOver) {
        timer.cancel();
        return;
      }
      setState(() {
        containerData.y -= x;
        for (final data in _containers) {
          if (data.y <= 0) {
            if (data.color == Colors.green && data.image==widget.im1 ) {
              _endGame();
            }
          }
        }
      });
    });
    Timer.periodic(const Duration(milliseconds: 700), (timer) {
      xx+=1;
    });
  }

  void up(){
    final size = MediaQuery.of(context).size;
    final xy = ContainerData(
        x: 1,
        y: _random.nextDouble()*(size.height-100),
        color: Colors.transparent,
        isClickable: true,
        image:const AssetImage("images/x3.png")
    );
    setState(() {
      n=true;
      x1++;
      _containers.add(xy);
      ok();
    });
    Timer.periodic(const Duration(milliseconds: 1), (timer){
      xy.x+=1;
    });
  }

  void _removeContainer(ContainerData containerData) {
    setState(() {
      _containers.remove(containerData);
    });
  }

  void _endGame() {
    setState(() {
      _gameOver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
       child: GestureDetector(
        onTapDown: (details) {
          final tapPosition = details.localPosition;
          final containerData = _containers.firstWhere(
                (container) => container.isClickable && container.isTapped(tapPosition),
          );
          if (containerData != null) {
            if(containerData.color== Colors.green && containerData.image==widget.im2 ){
              setState(() {
                _gameOver=true;
              });
            }
            if(containerData.color ==Colors.red){
              setState(() {
                _gameOver= true;
              });
            }
            if(containerData.color == Colors.transparent){
              setState(() {
                x1=1;
                x-=2;
                for (final data in _containers)
                  if(data.color == Colors.transparent){
                    _removeContainer(data);
                  }
              });
            }
            _removeContainer(containerData);
          }
        },
        child: Stack(
          children: [
            for (final containerData in _containers)
              Positioned(
                left: containerData.x,
                top: containerData.y,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: containerData.color,
                      image: DecorationImage(
                        image: containerData.image ,
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.only(top: 700),
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Score: $xx',
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
            ),
            if(_gameOver)
              Container(
                  margin: const EdgeInsets.only(left: 80,right: 30,top: 300),
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius:3,
                            offset: Offset(10,0),
                            color: Colors.white.withOpacity(0.1)
                        ),

                      ]),
                  child: Column(
                            children:[
                              SizedBox(height: 20),
                              Row(
                                  children: [
                                    SizedBox(width: 80,),
                                    Text("CI",
                                      style:GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20),),
                                  ]
                              ),
                              SizedBox(height:10),
                              Row(
                                  children: [
                                    SizedBox(width: 30,),
                                    Text("Your Score: $xx",
                                      style:GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.w700),),
                                  ]
                              ),
                              SizedBox(height:20),
                              Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text("Super bro super bro",
                                      style:GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.w700),),
                                  ]
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  SizedBox(width: 30,),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder : (context) => HomePage(),) );
                                      },
                                      child: Text("Play Again",style:GoogleFonts.robotoMono(fontWeight: FontWeight.w700,color: Colors.yellowAccent,fontSize: 20),))
                                ],
                              )
                            ]
                      ))
          ],
        ),
      ),
    );
  }
}

class ContainerData {
  double x;
  double y;
  Color color;
  bool isClickable;
  var image;
  ContainerData({
    required this.x,
    required this.y,
    required this.color,
    this.isClickable = false, required this.image,
  });

  bool isTapped(Offset tapPosition) {
    final containerRect = Rect.fromLTWH(x, y, 50, 50);
    return containerRect.contains(tapPosition);
  }
}