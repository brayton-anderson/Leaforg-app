import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeaforgPartnersRow extends StatefulWidget {
  const LeaforgPartnersRow({
    Key key,
  }) : super(key: key);

  @override
  _LeaforgPartnersRowState createState() => _LeaforgPartnersRowState();
}

class _LeaforgPartnersRowState extends State<LeaforgPartnersRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 290,
          height: 440,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/despose_waste.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                  color: Colors.transparent,
                ),
              ),
              Text(
                'Dispose Waste',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The example also uses medium strength branded '
                'background and surface colors. '
                'A theme showcase widget shows the theme with several ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  width: 170,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Theme.of(context).hintColor,
                  ),
                  child: Center(
                    child: Text(
                      'Join us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 290,
          height: 440,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/paertnership_prts.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                  color: Colors.transparent,
                ),
              ),
              Text(
                'Let\'s Partner',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The example also uses medium strength branded '
                'background and surface colors. '
                'A theme showcase widget shows the theme with several ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  width: 170,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Theme.of(context).hintColor,
                  ),
                  child: Center(
                    child: Text(
                      'Join us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 290,
          height: 440,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 220,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/careers_leaforg.png"),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                  color: Colors.transparent,
                ),
              ),
              Text(
                'Careers',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'The example also uses medium strength branded '
                'background and surface colors. '
                'A theme showcase widget shows the theme with several ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 170,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Theme.of(context).hintColor,
                  ),
                  child: Center(
                    child: Text(
                      'Join us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
