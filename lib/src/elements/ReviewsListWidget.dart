import 'package:flutter/material.dart';
import '../helpers/responsive.dart';

import '../elements/CircularLoadingWidget.dart';
import '../elements/ReviewItemWidget.dart';
import '../models/review.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatelessWidget {
  List<Review> reviewsList;

  ReviewsListWidget({Key key, this.reviewsList}) : super(key: key);

  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return reviewsList.isEmpty
        ? CircularLoadingWidget(height: 200)
        : Container(
            height: 292,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: reviewsList.length,
              itemBuilder: (context, index) {
                return ReviewItemWidget(review: reviewsList.elementAt(index));
              },
            ),
          );
  }
}
