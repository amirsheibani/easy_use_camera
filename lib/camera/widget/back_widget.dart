
import 'package:flutter/material.dart';

class BackWidget extends StatelessWidget {
  const BackWidget({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onTap ?? (){
      Navigator.pop(context);
    }, icon: const Icon(Icons.close,color: Colors.white,size: 32,));
  }
}
