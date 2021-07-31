import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ComingSoonWidget extends StatefulWidget {
  ComingSoonWidget({Key key}) : super(key: key);

  @override
  _ComingSoonWidgetState createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends StateMVC<ComingSoonWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: mediaQuery.height,
      width: mediaQuery.width,
      padding: EdgeInsets.all(40),
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              width: 533,
              child: Image(
                image: AssetImage('assets/img/leaforg_logo.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text('Recyclers is coming soon',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).hintColor,
                  overflow: TextOverflow.ellipsis,
                )),
            SizedBox(
              height: 15,
            ),
            Text(
                'We\'re currently building this solution, a notification wi be sent once done. ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).secondaryHeaderColor,
                  overflow: TextOverflow.ellipsis,
                )),
            SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () => Navigator.of(Get.context)
                  .pushReplacementNamed('/Pages', arguments: 2),
              child: Row(children: [
                Text('Going Back Home?  ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).splashColor,
                      fontStyle: FontStyle.italic,
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(
                  width: 20,
                ),
                Text('Click Here..  ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).hintColor,
                      fontStyle: FontStyle.normal,
                      overflow: TextOverflow.ellipsis,
                    )),
              ]),
            ),
          ],
        ),
      ),
    ));
  }
}
