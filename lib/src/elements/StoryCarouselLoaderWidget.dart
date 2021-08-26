import 'package:flutter/material.dart';

class StoriesCarouselLoaderWidget extends StatelessWidget {
  const StoriesCarouselLoaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 110.0,
            margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5)),
              ],
            ),
            child: Image.asset(
              'assets/img/loading_card.gif',
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );

    // Container(
    //   height: 288,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: 3,
    //     itemBuilder: (context, index) {
    //       return Card(
    //         margin: EdgeInsets.symmetric(
    //           vertical: 5.0,
    //           horizontal: Responsive.isDesktop == true ? 5.0 : 0.0,
    //         ),
    //         elevation: Responsive.isDesktop == true ? 1.0 : 0.0,
    //         shape: Responsive.isDesktop == true
    //             ? RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10.0))
    //             : null,
    //         child: Container(
    //           padding: const EdgeInsets.symmetric(vertical: 8.0),
    //           color: Colors.white,
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.stretch,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         SizedBox(
    //                           height: 50,
    //                           width: 50,
    //                           child: ClipOval(
    //                             child: Image.asset(
    //                               'assets/img/loading_card.gif',
    //                               fit: BoxFit.cover,
    //                             ),
    //                           ),
    //                         ),
    //                         const SizedBox(width: 8.0),
    //                         Expanded(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Container(
    //                                 height: 15,
    //                                 width: 100,
    //                                 color: Colors.transparent,
    //                                 child: Image.asset(
    //                                   'assets/img/loading_card.gif',
    //                                   fit: BoxFit.cover,
    //                                 ),
    //                               ),
    //                               Row(
    //                                 children: [
    //                                   Container(
    //                                     height: 15,
    //                                     width: 60,
    //                                     color: Colors.transparent,
    //                                     child: Image.asset(
    //                                       'assets/img/loading_card.gif',
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                   ),
    //                                   Icon(
    //                                     Icons.public,
    //                                     color: Colors.grey[600],
    //                                     size: 12.0,
    //                                   )
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                         IconButton(
    //                           icon: const Icon(Icons.more_horiz),
    //                           onPressed: () => print('More'),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 4.0),
    //                     Container(
    //                       height: 30,
    //                       width: 200,
    //                       color: Colors.transparent,
    //                       child: Image.asset(
    //                         'assets/img/loading_card.gif',
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                     Container(
    //                       height: 30,
    //                       width: 130,
    //                       color: Colors.transparent,
    //                       child: Image.asset(
    //                         'assets/img/loading_card.gif',
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                     const SizedBox.shrink()
    //                   ],
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 8.0),
    //                 child: Image.asset(
    //                   'assets/img/loading_card.gif',
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.all(4.0),
    //                           decoration: BoxDecoration(
    //                             color: Palette.facebookBlue,
    //                             shape: BoxShape.circle,
    //                           ),
    //                           child: const Icon(
    //                             Icons.thumb_up,
    //                             size: 10.0,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                         const SizedBox(width: 4.0),
    //                         Expanded(
    //                           child: Container(
    //                             height: 15,
    //                             width: 50,
    //                             color: Colors.transparent,
    //                             child: Image.asset(
    //                               'assets/img/loading_card.gif',
    //                               fit: BoxFit.cover,
    //                             ),
    //                           ),
    //                         ),
    //                         Container(
    //                           height: 15,
    //                           width: 50,
    //                           color: Colors.transparent,
    //                           child: Image.asset(
    //                             'assets/img/loading_card.gif',
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                         const SizedBox(width: 8.0),
    //                         Container(
    //                           height: 30,
    //                           width: 50,
    //                           color: Colors.transparent,
    //                           child: Image.asset(
    //                             'assets/img/loading_card.gif',
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const Divider(),
    //                     Row(
    //                       children: [
    //                         Container(
    //                           height: 30,
    //                           width: 50,
    //                           color: Colors.transparent,
    //                           child: Image.asset(
    //                             'assets/img/loading_card.gif',
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                         Container(
    //                           height: 30,
    //                           width: 50,
    //                           color: Colors.transparent,
    //                           child: Image.asset(
    //                             'assets/img/loading_card.gif',
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                         Container(
    //                           height: 30,
    //                           width: 50,
    //                           color: Colors.transparent,
    //                           child: Image.asset(
    //                             'assets/img/loading_card.gif',
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}