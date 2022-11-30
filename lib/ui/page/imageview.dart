import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class ImageViewPage extends StatefulWidget {
  final String id;
  const ImageViewPage({Key? key,required this.id}) : super(key: key);

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  late Future<ListResult> files;
  List<String> urls = [];
  int current = 0;
  @override
  void initState() {
    files = FirebaseStorage.instance.ref("alls/${widget.id}").list();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: FutureBuilder<ListResult>(
        future: files,
        builder: (context, snapshot) {
         if(snapshot.hasData){
           var images = snapshot.data!.items;
           images.map((e) async {
             return e.getDownloadURL().then((value){
               setState(() {
                 urls.add(value);
               });
             });
           }).toList();
           return Stack(
             children: [
               PageView.builder(
                 onPageChanged: (v){
                   setState(() {
                     current = v;
                   });
                 },
                 itemCount: urls.length,
                 itemBuilder: (context, index)  {
                   return Container(
                     child: CachedNetworkImage(
                       imageUrl: urls[index],
                       errorWidget: (context,_,__){
                         return const Center(child:  CircularProgressIndicator());
                       },
                     ),
                   );
                 }
               ),
               Positioned(
                   bottom: 4,
                   left: 4,
                   child: Container(
                     padding: const EdgeInsets.only(left: 10,right: 10),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(5),
                       color: Colors.white,
                     ),
                     child: Text("${current + 1}/${images.length}",style: const TextStyle(
                       color: Colors.black87,
                       fontWeight: FontWeight.w700,
                       fontSize: 22,
                     ),),
               ))
             ],
           );
         }
         else if(snapshot.hasError) {
           return const Center(child: Text("SomeThing Going Wrong"));
         } else{
           return const Center(child: CircularProgressIndicator());
         }
      }),
    );
  }
}
