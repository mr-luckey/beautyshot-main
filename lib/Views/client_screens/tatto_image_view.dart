import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TattooImageView extends StatefulWidget {
  final String tattooImage;

  const TattooImageView(this.tattooImage, {Key? key}) : super(key: key);



  @override
  State<TattooImageView> createState() => _TattooImageViewState();
}

class _TattooImageViewState extends State<TattooImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tattoo Image'),),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius:
            BorderRadius.circular(14),
            child: CachedNetworkImage(

              imageUrl: widget.tattooImage,
            ),
          ),
        ),
      ),
    );
  }
}
