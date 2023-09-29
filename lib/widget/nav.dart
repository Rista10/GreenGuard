import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:Colors.grey.withOpacity(0.3),
                blurRadius:10,
                offset: const Offset(0, -5)
              ),
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.home)),
                IconButton(
                  onPressed: (){
                    
                  }, 
                  icon: const Icon(Icons.qr_code_scanner)),
                   IconButton(
                onPressed: (){
                  
                }, 
                icon: const Icon(Icons.border_all)),
                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(Icons.person))
            ],
          ),
        ),
      ),
    );
  }
}