// import 'package:flutter/material.dart';


// class CustomNetworkImage extends StatelessWidget {
//   const CustomNetworkImage({super.key, required this.imageUrl});

//   final String imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: CachedNetworkImage(
//           imageUrl: imageUrl,
//           placeholder:
//               (context, url) =>
//                   const Center(child: CircularProgressIndicator()),
//           errorWidget:
//               (context, url, error) => Center(
//                 child: Icon(Icons.broken_image, color: Colors.red, size: 50),
//               ),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
