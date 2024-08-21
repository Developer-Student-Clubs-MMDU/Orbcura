import 'package:flutter/material.dart';

class ImageToggleWidget extends StatefulWidget {
  final String image1;
  final String image2;
  final double height;
  final Function onTap;

  const ImageToggleWidget({
    Key? key,
    required this.image1,
    required this.image2,
    required this.height,
    required this.onTap,
  }) : super(key: key);

  @override
  _ImageToggleWidgetState createState() => _ImageToggleWidgetState();
}

class _ImageToggleWidgetState extends State<ImageToggleWidget> {
  bool _isImage1 = true;

  void _toggleImage() {
    setState(() {
      _isImage1 = !_isImage1;
    });
    widget.onTap(); // Call the onTap function if provided
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleImage,
      child: Image.asset(
        _isImage1 ? widget.image1 : widget.image2,
        height: widget.height,
      ),
    );
  }
}
