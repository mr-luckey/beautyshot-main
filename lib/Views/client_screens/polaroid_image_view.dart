import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PolaroidImageView extends StatefulWidget {
  final List polaroidImageLink;
  const PolaroidImageView(this.polaroidImageLink, {Key? key}) : super(key: key);
  @override
  State<PolaroidImageView> createState() => _PolaroidImageViewState();
}

class _PolaroidImageViewState extends State<PolaroidImageView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> images= [];


  @override
  void initState() {
    super.initState();
    images.clear();
    widget.polaroidImageLink.forEach((element) {
      images = widget.polaroidImageLink.cast();

      debugPrint(images.toString());
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Polaroid Images'),),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
         child:  CarouselSlider(
           options: CarouselOptions(
             enlargeCenterPage: false,
             viewportFraction: 1.0,
             height: MediaQuery.of(context).size.height,
             enableInfiniteScroll: false,
             onPageChanged: (index,reason){
               setState(() {
                 _current = index;
               });
             },
           ),
           carouselController: _controller,
           items: images.map((i) {
             return Builder(
               builder: (BuildContext context) {
                 return Stack(
                   alignment: Alignment.bottomCenter,
                   children: [
                     Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       margin: const EdgeInsets.symmetric(horizontal: 5.0),
                       decoration: const BoxDecoration(
                         // color: Colors.amber
                       ),
                       child: CachedNetworkImage(
                         // fit:BoxFit.contain ,
                         width: MediaQuery.of(context).size.width,
                         imageUrl: i,
                         placeholder: (context, url) => const SizedBox(height: 32, width: 32, child: Center(child: CircularProgressIndicator())),
                         errorWidget: (context, url, error) =>  const Icon(Icons.error),
                       ),
                     ),
                   ],
                 );
               },
             );
           }).toList(),
         ),
        ),
      ),
    );
  }
}
