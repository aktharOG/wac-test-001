import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wac_test_001/view/widgets/custom_text.dart';

class CustomTextfield extends StatelessWidget {
  final bool showCountryCode;
  final String name;
  final TextEditingController controller;
  final Widget? leading;
  final bool readOnly;
  final Function()? onTap;
  final void Function(String)? onChanged;
  const CustomTextfield(
      {super.key,
      this.showCountryCode = false,
      required this.controller,
      required this.name,
      this.leading,
      this.readOnly = false,
      this.onTap,
      this.onChanged
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      height: 30.h,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset:const Offset(1, 1),
            blurRadius: 5
          )
        ],
          borderRadius: BorderRadius.circular(30), color: Colors.grey.shade200),
      child: Row(
        children: [
        
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextFormField(
              
              onChanged: onChanged,
             
              onTap: onTap,
              readOnly: readOnly,
              controller: controller,
              style: const TextStyle(fontSize: 18),
              decoration:
                  InputDecoration(
                    suffixIcon: const Icon(Icons.search,color: Colors.grey,),
                    hintText: name, border: InputBorder.none),
                  
            ),
            
          ))
        ],
      ),
    );
  }
}
