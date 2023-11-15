import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gsthongbai1app/src/utils/constant.dart';

class readbeforesaving extends StatelessWidget {
  readbeforesaving({
    Key key,
    this.radius = 8,
    @required this.mdFileName,
  })  : assert(mdFileName.contains('.md'),
            'The file must contain the .md extension'),
        super(key: key);

  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 0)).then((value){
              return rootBundle.loadString('assets/images/$mdFileName');
            }),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Markdown(
                  data: snapshot.data
                  );
              }
              return Center(
                child: CircularProgressIndicator()
              );
            },
          ),
          ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
            )),
          ),
          onPressed: () =>  Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              color: Constant.PRIMARY_COLOR,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius)
                )
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                "ยอมรับ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
            ),
          ),  
        
      ]),
    );
  }
}
