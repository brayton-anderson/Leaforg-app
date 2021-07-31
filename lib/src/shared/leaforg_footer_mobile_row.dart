import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaforgFooterMobileRow extends StatefulWidget {
  const LeaforgFooterMobileRow({
    Key key,
  }) : super(key: key);

  @override
  _LeaforgFooterMobileRowState createState() => _LeaforgFooterMobileRowState();
}

class _LeaforgFooterMobileRowState extends State<LeaforgFooterMobileRow> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 180,
                height: 220,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s save earth',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Careers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Partnership',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Dispose Waste',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Couriers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 140,
                height: 220,
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage("assets/images/app_store.png"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage("assets/images/google_play.png"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'TERMS & CONDITION',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'PRIVACY POLICY',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'COOKIES POLICY',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Container(
          //         width: 120,
          //         height: 40,
          //         decoration: BoxDecoration(
          //           color: Colors.transparent,
          //           image: DecorationImage(
          //             image: AssetImage("assets/images/app_store.png"),
          //             fit: BoxFit.fitWidth,
          //             alignment: Alignment.center,
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 15,
          //       ),
          //       Container(
          //         width: 120,
          //         height: 40,
          //         decoration: BoxDecoration(
          //           color: Colors.transparent,
          //           image: DecorationImage(
          //             image: AssetImage("assets/images/google_play.png"),
          //             fit: BoxFit.fitWidth,
          //             alignment: Alignment.center,
          //           ),
          //         ),
          //       ),
          //     ]),
        ]);
  }
}
