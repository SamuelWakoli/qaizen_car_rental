import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  String id, image, name, price;
  bool isLiked;
  Widget? likeIcon;
  dynamic onClickFav, onClickHire, onClickDetails;

  HomeCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.isLiked,
    this.likeIcon,
    required this.onClickFav,
    required this.onClickHire,
    required this.onClickDetails,
  }) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    //default icon
    Widget iconToLoad = const Icon(Icons.favorite_outline_outlined);

    // //checked by database and setState
    // if (widget.likeIcon == null) {
    //   if (widget.isLiked == true) {
    //     iconToLoad = const Icon(Icons.favorite_rounded);
    //   } else {
    //     iconToLoad = const Icon(Icons.favorite_outline_outlined);
    //   }
    // }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Image.asset(widget.image),
            const SizedBox(height: 8),
            Text(
              widget.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('Price: '),
                  const Text(
                    'Ksh. ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(' /day'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onClickFav;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        iconToLoad,
                        const SizedBox(width: 8),
                        const Text('Like', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onClickDetails,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.info_outline_rounded),
                        SizedBox(width: 8),
                        Text('Details', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onClickHire,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Icon(Icons.assignment_outlined),
                        SizedBox(width: 8),
                        Text('Hire', style: TextStyle(fontSize: 18))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// Widget homeCard({
//   required String id,
//   required String image,
//   required String name,
//   required String price,
//   required bool isLiked,
//   Widget? likeIcon,
//   required onClickFav,
//   required onClickHire,
//   required onClickDetails,
// }) {
//   //default icon
//   Widget iconToLoad = const Icon(Icons.favorite_outline_outlined);

//   //checked by database and setState
//   if (likeIcon == null) {
//     if (isLiked == true) {
//       iconToLoad = const Icon(Icons.favorite_rounded);
//     } else {
//       iconToLoad = const Icon(Icons.favorite_outline_outlined);
//     }
//   }

//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Card(
//       child: Column(
//         children: [
//           Image.asset(image),
//           const SizedBox(height: 8),
//           Text(
//             name,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 const Text('Price: '),
//                 const Text(
//                   'Ksh. ',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   price,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(' /day'),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               GestureDetector(
//                 onTap: onClickFav,
//                 child: Row(
//                   children: [
//                     iconToLoad,
//                     const SizedBox(width: 8),
//                     const Text('Like')
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onClickDetails,
//                 child: Row(
//                   children: const [
//                     Icon(Icons.info_outline_rounded),
//                     SizedBox(width: 8),
//                     Text('Details')
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onClickHire,
//                 child: Row(
//                   children: const [
//                     Icon(Icons.assignment_outlined),
//                     SizedBox(width: 8),
//                     Text('Hire')
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//         ],
//       ),
//     ),
//   );
// }

Widget favCard({
  required String id,
  required String image,
  required String name,
  required String price,
  required bool availabity,
  required onClickHire,
  required onClickDetails,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Column(
        children: [
          Image.asset(image),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Price: '),
                const Text(
                  'Ksh. ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(' /day'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Row(
              children: [
                const Text('Status: '),
                Text(availabity
                    ? "Available"
                    : "Not avalable, expected at 12:42pm")
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: onClickDetails,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline_rounded),
                      SizedBox(width: 8),
                      Text('Details', style: TextStyle(fontSize: 18))
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClickHire,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.assignment_outlined),
                      SizedBox(width: 8),
                      Text('Hire', style: TextStyle(fontSize: 18))
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
