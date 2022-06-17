import 'package:don/services/basic_services.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  bool isDropped = false;

  void triggerReset() async
  {
    await Future.delayed(const Duration(seconds: 1));
    isDropped = false;
    setState(() {});
    _controller.forward(from: 0.0);
  }

  void startAuthentication() async
  {
    String? token = await BasicServices.getAuthToken("b-0110");
    if(token != null)
    {
        await BasicServices.createAuthRequest("b-0110", token);
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward(from: 0.0);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("DON Chain Authenticator"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                // Color(0xff4ecde9),
                // Color(0xff53cfea),
                Color(0xff5fd4ee),
                Color(0xff70dbf2),
                Color(0xff85e3f6),
                Color(0xff9beaf9),
                // Color(0xffaeeffb),
                // Color(0xffbdf3fd),
                // Color(0xffc2f4fd)
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10,),
                  const Expanded(child: SizedBox(height: 10)),
                  DragTarget<String>(
                      onAccept: (value){
                        print("Authenticating");
                        setState(() {
                          isDropped = true;
                        });
                        startAuthentication();
                        triggerReset();
                      },
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                    return Container(
                      height: 100,
                      width: 100,
                      child: isDropped ?
                           Image.asset("assets/images/shield.png",)
                          :Image.asset("assets/images/shield.png",
                             color: Colors.blue,),
                    );
                  }),

                  const Expanded(child: SizedBox(height: 10)),
                  Draggable<String>(
                    // Data is the value this Draggable stores.
                    data: 'test',
                    axis: Axis.vertical,
                    feedback: Container(
                      height: 100.0,
                      width: 100.0,
                      child: Center(
                        child: Image.asset('assets/images/shield.png'),
                      ),
                    ),
                    //New
                    childWhenDragging: const SizedBox(
                      height: 100.0,
                      width: 100,
                    ),
                    child: Container(
                      height: 100.0,
                      width: 100,
                      child: Center(
                        child:  isDropped ? SizedBox(height: 10,) :
                        FadeTransition(
                            opacity: _animation,
                            child: Image.asset(
                              'assets/images/shield.png',
                              width: 100,
                            )
                        )
                      ),
                    ),
                  ),

                  const SizedBox(height: 16,)

                ],
              ),

        ),
    ),
    );
  }
}
