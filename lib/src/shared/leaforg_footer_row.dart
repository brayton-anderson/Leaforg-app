import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaforgFooterRow extends StatefulWidget {
  const LeaforgFooterRow({
    Key key,
  }) : super(key: key);

  @override
  _LeaforgFooterRowState createState() => _LeaforgFooterRowState();
}

class _LeaforgFooterRowState extends State<LeaforgFooterRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 250,
          height: 220,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Leaforg Contacts',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '13th Floor,  ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Am Bank House,',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Nairobi, Kenya.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Call: 0000,000,000',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          width: 215,
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
          width: 15,
        ),
        Container(
          width: 200,
          height: 220,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Useful links',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'About us',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'FAQ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Community',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Contact us',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          width: 210,
          height: 220,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Follow us',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Facebook',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Twitter',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Instagram',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Linked-in',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          width: 210,
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
                    alignment: Alignment.topRight,
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
                    alignment: Alignment.topRight,
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
    );
  }
}
