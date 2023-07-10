import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScarImageView extends StatefulWidget {
  final String scarImage;
  const ScarImageView(this.scarImage, {Key? key}) : super(key: key);
  @override
  State<ScarImageView> createState() => _ScarImageViewState();
}

class _ScarImageViewState extends State<ScarImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scar Image'),),
        body: SafeArea(
          child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(14),
                        child: CachedNetworkImage(
                          imageUrl: widget.scarImage,
                        ),
                      ),
                    ),
        ),
                  );
  }
}
