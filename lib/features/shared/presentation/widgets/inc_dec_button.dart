import 'package:craft_bay/app/app_colors.dart';
import 'package:craft_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({
    super.key,
    this.width = 100,
    required this.onChange,
    this.maxCount = 20});

  final double width;
  final Function(int) onChange;
  final int maxCount;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {

  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          _buildButton(Icons.remove, (){
            if(_count > 1){
              _count--;
              setState(() {});
              widget.onChange(_count);
            }
          }),
          Text('$_count', style: context.textTheme.titleLarge,),
          _buildButton(Icons.add,(){
            if (_count < widget.maxCount) {
              _count++;
              widget.onChange(_count);
              setState(() {});
            }
          }),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onTap){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: .all(8),
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size:  18, color: Colors.white,),
      ),
    );
  }

}
