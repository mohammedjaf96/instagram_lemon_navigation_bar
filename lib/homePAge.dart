import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(
      begin: 0,
      end: 0.8,
    ).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    pageIndex = 2;
    animationController.forward(from: 0);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            item(Icons.home,0,),
            item(Icons.search,1,),
            item(Icons.home,2,),
            item(Icons.settings,3,),
            item(Icons.access_alarms,4,),
          ],
        ),
        shape: CircularNotchedRectangle(),
        height: 45,
        color: Colors.white,
      ),
      floatingActionButton: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(animation),
        child: FloatingActionButton(
          onPressed: _handleTap,
          child: SvgPicture.asset('assets/lemon.svg',height: 200,),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Expanded item(icon,index){
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            pageIndex = index;
          });
          // If the index is not equal to 2, reverse the animation
          if (index != 2) {
            animationController.reverse();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Icon(icon,color: index == 2 ? Colors.transparent : (pageIndex == index ? Colors.amber : Colors.grey),size: 30,),
              const SizedBox(height: 2,),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 30,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pageIndex == index ? Colors.black : Colors.transparent
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
