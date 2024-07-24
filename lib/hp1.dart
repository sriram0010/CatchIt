import 'dart:io';
import 'package:CatchIT/particle_space.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'game.dart';
import 'package:path_provider/path_provider.dart';

const int delaySeconds = 10;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double leftDist = -300.0;
  double width = 0.0;
  bool what = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: delaySeconds), () {
      setState(() {
        leftDist = width + 300;
      });
    });
    oid(1);
    oid(3);
    super.initState();
  }

  ImageProvider ima0 = const AssetImage("images/x2.png") ;
  //late ImageProvider ima0;
  ImageProvider ima2 = const AssetImage("images/x1.png") ;
  //late ImageProvider ima2;
  List<ImageProvider?> images = [null];

  oid(a) async {
   if(a==1){
      try {
        ima0 = ope_img("img0.png");
      } on Exception catch (e) {
        // TODO
         ima0 = const AssetImage("images/x2.png") ;
       // print("==================$e");
      }
    }
    if(a==3){
      try {
        ima2 = ope_img("img2.png");
      } on Exception catch (e) {
        // TODO
        ima2 = const AssetImage("images/x1.png") ;
     //   print("==================$e");
      }
    }
    if(a==4){
      final path = await getApplicationDocumentsDirectory();
      final path_ = "${path.path}/img0.png";
      if(await File(path_).exists()) File(path_).delete();
      final path__ = "${path.path}/img2.png";
      if(await File(path__).exists()) File(path__).delete();
      setState(() {
        ima0 = const AssetImage("images/x2.png") ;
        ima2 = const AssetImage("images/x1.png") ;
      });
    }

    else{
      final path = await getApplicationDocumentsDirectory();
      final path_ = "${path.path}/img$a.png";
      if(await File(path_).exists()) File(path_).delete();

      File? image;

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

    //  print("======${pickedFile.path}");

      final fileName = pickedFile.name;
      image = File(pickedFile.path);


      final File localImage = await image.copy("$appDocPath/img$a.png");
      //ope_img("img5.png");
      if(a==0) {
        setState(() {
        ima0 = FileImage(image!);
      });
      } else if(a==2) {
        setState(() {
          ima2 = FileImage(image!);
        });
      }
    }
  }

  ope_img(String name) async {
    final path = await getApplicationDocumentsDirectory();
    final path_ = "${path.path}/$name";
    if(await File(path_).exists()) {
      final file = File(path_);
      if(name =="img0.png") {
        setState(() {
          ima0 = FileImage(file);
        });
       // print("============xxxxxxx==========");
        return FileImage(file);
      }
      if(name =="img2.png") {
        setState(() {
          ima2 = FileImage(file);
        });
      //  print("============xxxxxxx==========");
        return FileImage(file);
      }
    }
    else{
      if(name=="img0.png") {
       // print("============error==========");
        return const AssetImage("images/x2.png");
      }
      if(name=="img2.png") {
       // print("============error==========");
        return const AssetImage("images/x1.png");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                  ParticleSpace(spaceWidth: width,),
               Column(
                 children:[
                   const SizedBox(height: 100,),
                Row(
                  children: [
                    const SizedBox(width: 100,),
                    Text("CATCH IT", style:GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 30),)
                  ],
                ),]),
                if(what)
                  Container(
                    margin: const EdgeInsets.only(top:357),
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    color: Colors.white24,
                  ),
                if(what)
                  Container(
                    margin: const EdgeInsets.only(top:523),
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    color: Colors.white24,
                  ),
                if(what)
                Container(
              margin: const EdgeInsets.only(left: 80, right: 30, top: 230),
              height: 445,
              width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15),
                    ),
              child: Column(
                  children: [
                    Row(
                        children: [
                          const SizedBox(width: 80,),
                          Text("CI",
                            style:GoogleFonts.robotoMono(color: Colors.white,fontWeight: FontWeight.w700),),
                          const SizedBox(width: 50,),

                            IconButton(
                              onPressed:(){
                                oid(4);
                              },

                              icon:const Icon( Icons.close ,size: 15,color: Colors.white,),
                            )


                        ]
                    ),

                    Row(
                        children:[
                          const SizedBox(width: 65,),

                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green,
                              image: DecorationImage(
                                image: ima0,// Use FileImage
                                    //: AssetImage("images/x2.png"),       // Use AssetImage
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),


                          IconButton(
                            onPressed:(){
                              oid(0);
                            },

                            icon:const Icon( Icons.refresh ,size: 15,color: Colors.white,),
                          )
                        ]
                    ),
                    const SizedBox(height: 15,),
                    Row(
                        children:[
                          const SizedBox(width: 56,),
                          Text("CATCH IT",style:GoogleFonts.robotoMono(color: Colors.white),),

                        ]
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          height: 1,
                          width: 180,
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                        children:[
                          const SizedBox(width: 40,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green,
                                image:  DecorationImage(
                                  image: ima2,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                          const SizedBox(width: 10,),

                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                                image: DecorationImage(
                                  image:ima0 ,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                          ]
    ),
                    const SizedBox(height: 15,),
                          Row(
                            children:[
                              const SizedBox(width: 65,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red,
                                image:  DecorationImage(
                                  image: ima2,
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                              IconButton(
                                onPressed:(){
                                  oid(2);
                                },

                                icon:const Icon( Icons.refresh ,size: 15,color: Colors.white,),
                              )
                        ]
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const SizedBox(width: 15,),
                        Text("Do not Catch these",style:GoogleFonts.robotoMono(color: Colors.white),)
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 10,),
                        Container(
                          height: 1,
                          width: 180,
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                        children:[
                          const SizedBox(width: 65,),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                image: const DecorationImage(
                                  image: AssetImage("images/x3.png"),
                                  fit: BoxFit.cover,
                                )
                            ),
                          )
                        ]
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 60,),
                        Text("Power-Up",style:GoogleFonts.robotoMono(color: Colors.white),)
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 25,),
                        const Icon(Icons.keyboard_double_arrow_right,color: Colors.white,),
                        const SizedBox(width: 10,),
                        TextButton(onPressed: () {
                          setState(() {
                            what = false;
                          });

                        },
                            child: Text("Play",style:GoogleFonts.robotoMono(fontWeight: FontWeight.w700,color: Colors.yellowAccent,fontSize: 23),)),
                        const SizedBox(width: 10,),
                        const Icon(Icons.keyboard_double_arrow_left,color: Colors.white,),
                      ],
                    )

                  ]
              )
          ),
                if(what)
                  Container(
                    margin: const EdgeInsets.only(top:700),
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color: Colors.white24,
                    child:Center(
                    child: Text("Vaanga bro vilaiyadalam :)",style:GoogleFonts.robotoMono(color: Colors.amberAccent.shade400,fontSize: 15) ,)
                    )),
                if(!what)
                   MovingScreen(im1: ima0,im2: ima2,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ParticleSpace extends StatelessWidget {
  const ParticleSpace({
    Key? key,
    required this.spaceWidth,
  }) : super(key: key);
  final double spaceWidth;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 600,
      child: ParticlesMotion(
        isRunning: true,
        totalParticles: 600,
        speed: 2,
      ),
    );
  }
}

class ImageData {
  File? imageFile;

  ImageData(this.imageFile);
}
