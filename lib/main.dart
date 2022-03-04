import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;


/*
Future<String> _downloadCsv() async {
  //const url = "https://projects.fivethirtyeight.com/soccer-api/international/spi_global_rankings_intl.csv";
  const url = "http://203.250.77.238:50001/manage/Status/RawData.csv";
  try {
    String csvRead = await http.read(Uri.parse(url));
    return csvRead;
  }
  catch(e) {
    //print('download error:$e');
    return '';
  }
}
*/

/*
void main() => runApp(MaterialApp(
  title: 'Navigator',
  home: testApp(),
)
);
 */

void main() {
  print("main");
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("statelesswidget build");
    return MaterialApp(
      title: 'Woolha.com Flutter Tutorial',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('test'),
          backgroundColor: Colors.teal,
        ),
        body: InheritedWidgetExample(),
      ),
    );
  }
}


class InheritedWidgetExample extends StatefulWidget {

  @override
  _InheritedWidgetExampleState createState() => _InheritedWidgetExampleState();
}

class _InheritedWidgetExampleState extends State<InheritedWidgetExample> {
  List<double> dbarr = <double>[0.1, 0.2, 0.3, 0.4, 0.5];


  void aaa() {
    setState(() {
      for (int i = 0; i < 5; i++) {
        dbarr[i] = Random().nextDouble();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    print("statefulwidgetbuild");
    aaa();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Info(
            response: dbarr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CurrentScore()
              ],
            ),
          ),
        ],
      ),
    );
  }

}



class Info extends InheritedWidget {

  const Info({
    Key? key,
    required this.response,
    required Widget child,
  }) : assert(response != null),
        assert(child != null),
        super(key: key, child: child);

  final List<double> response;

  static Info? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Info>();
  }

  @override
  bool updateShouldNotify(covariant Info oldWidget) {
    return oldWidget.response != response;
  }
}

class CurrentScore extends StatelessWidget {

  const CurrentScore();


  @override
  Widget build(BuildContext context) {
    print('CurrentScore rebuilt');
    final Info? info = Info.of(context);

    return Container(
      child: CustomPaint(
          size: Size(400, 200),
          foregroundPainter: LineChart(
              points: info!.response,
              pointSize: 1.0,
              // 점의 크기를 정합니다.
              lineWidth: 1.0,
              // 선의 굵기를 정합니다.
              lineColor: Colors.purpleAccent,
              // 선의 색을 정합니다.
              pointColor: Colors.purpleAccent)), // 점의 색을 정합니다.
    );
  }
}
//WidgetsFlutterBinding.ensureInitialized();


/*
  final database = openDatabase(
    // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
    // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
    await getDatabasesPath() + 'RawData.db',
    // 데이터베이스가 처음 생성될 때, dog를 저장하기 위한 테이블을 생성합니다.

    // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
    // 수행하기 위한 경로를 제공합니다.
    version: 1,
  );
*/
/*
  var _model = SqliteTestModel();

  var list = await _model.Raws();
  String _result = '';
  for(var item in list){
    _result += '${item.No} , ${item.Ch1}\n';
  }
  print("zz");
  print(_result);
*/


class testApp extends StatefulWidget {
  const testApp({Key? key}) : super(key: key);

  @override
  _testAppState createState() => _testAppState();
}






class _testAppState extends State<testApp>{
  Future<Map<String,dynamic>>? myfuture;
  List<double> dbarr = <double>[0.1,0.2,0.6,0.1,0.2];


  Future<Map<String,dynamic>> _downloadCsv() async {
    //const url = "https://projects.fivethirtyeight.com/soccer-api/international/spi_global_rankings_intl.csv";
    const url = "http://203.250.77.240:50001/manage/Status/test";

    final response = await http.get(Uri.parse(url));

    Map<String,dynamic> rdt = jsonDecode(response.body);

    return rdt;
  }

  @override
  Widget build(BuildContext context) {
    List<double> test = [0.1,0.2,0.3,0.4,0.5];
    //var _model = SqliteTestModel();
    print("build");

    return MaterialApp(

      title: 'FF',
      home: Scaffold(
          appBar: AppBar(
            title: Text('FDE'),
          ),
          body: Column(
            children: <Widget>[
              /*
            FutureBuilder<Map<String, dynamic>>(
              future: _downloadCsv(),
              builder: (context, snapshot) {
                if (snapshot.hasData == true) {
                  CircularProgressIndicator();
                }
                else {
                  if (dbarr.length == 5) {
                    dbarr.add(double.parse(snapshot.data!['AVG']));
                    dbarr.removeAt(0);
                  }
                  else {
                    dbarr.add(double.parse(snapshot.data!['AVG']));
                  }
                }
                print(dbarr);
                return CustomPaint(
                    size: Size(400, 200),
                    foregroundPainter: LineChart(
                        points: dbarr,
                        pointSize: 1.0,
                        // 점의 크기를 정합니다.
                        lineWidth: 1.0,
                        // 선의 굵기를 정합니다.
                        lineColor: Colors.purpleAccent,
                        // 선의 색을 정합니다.
                        pointColor: Colors.purpleAccent)); // 점의 색을 정합니다.

              },
          ),
               */





              OutlinedButton(
                  onPressed: () async {
                    int p=0;

                    while(p<10) {
                      sleep(const Duration(seconds: 1));
                      const url = "http://203.250.77.240:50001/manage/Status/test";

                      final response = await http.get(Uri.parse(url));

                      Map<String, dynamic> rdt = jsonDecode(response.body);
                      if (dbarr.length == 5) {
                        dbarr.add(double.parse(rdt['AVG']));
                        dbarr.removeAt(0);
                      }
                      else {
                        dbarr.add(double.parse(rdt['AVG']));
                      }
                      print(dbarr);
                      p++;
                    }
                  },
                  child: Text("zz")
              ),



              /*
      FutureBuilder<Map<String,dynamic>>(
          future: myfuture,
          builder: (context, snapshot){
            print(snapshot.data);

            if(snapshot.hasData == false){
              CircularProgressIndicator();
            }
            else if(snapshot.hasData){
              if(dbarr.length == 5) {
                dbarr.add(double.parse(snapshot.data!['AVG']));
                dbarr.removeAt(0);
              }
              else {
                dbarr.add(double.parse(snapshot.data!['AVG']));
              }
            }
            print(dbarr);
            return Text("zz");
          }
      );

       */
            ],

            /*
                list = _model.Raws();
                String _result = '';
                for(var item in list){
                  _result += '${item.No} , ${item.Ch1}\n';
                }
  */
            //print(_result);

          ),




      ),
    );
  }
}





class ChartPage extends StatelessWidget{
  List<double> a12 = <double>[0.0,0.1,0.5,0.2,0.8];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Chart Page"),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: CustomPaint(
                        size: Size(400, 200),
                        foregroundPainter: LineChart(
                            points: a12,
                            pointSize: 1.0,
                            // 점의 크기를 정합니다.
                            lineWidth: 1.0,
                            // 선의 굵기를 정합니다.
                            lineColor: Colors.purpleAccent,
                            // 선의 색을 정합니다.
                            pointColor: Colors.purpleAccent)), // 점의 색을 정합니다.
                  ),

                  RaisedButton(
                    child: Text('Go First Screen'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class RawData {
  final int No;
  final double Ch1;

  RawData({required this.No, required this.Ch1});

  Map<String, dynamic> toMap() {
    return {
      'No': No,
      'Ch1': Ch1,
    };
  }

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'RawData{No: $No, Ch1: $Ch1}';
  }


}

class LineChart extends CustomPainter {
  List<double> points;
  double lineWidth;
  double pointSize;
  Color lineColor;
  Color pointColor;
  int maxValueIndex=0;
  int minValueIndex=0;
  double fontSize = 18.0;

  LineChart({required this.points, required this.pointSize, required this.lineWidth, required this.lineColor, required this.pointColor});

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> offsets = getCoordinates(points, size); // 점들이 그려질 좌표를 구합니다.

    drawText(canvas, offsets); // 텍스트를 그립니다. 최저값과 최고값 위아래에 적은 텍스트입니다.

    drawLines(canvas, size,  offsets); // 구한 좌표를 바탕으로 선을 그립니다.
    drawPoints(canvas, size, offsets); // 좌표에 따라 점을 그립니다.
  }

  void drawLines(Canvas canvas, Size size, List<Offset> offsets) {
    Paint paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();

    double dx = offsets[0].dx;
    double dy = offsets[0].dy;

    path.moveTo(dx, dy);
    offsets.map((offset) => path.lineTo(offset.dx , offset.dy)).toList();

    canvas.drawPath(path, paint);
  }

  void drawPoints(Canvas canvas, Size size, List<Offset> offsets) {
    Paint paint = Paint()
      ..color = pointColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = pointSize;

    canvas.drawPoints(PointMode.points, offsets, paint);
  }

  List<Offset> getCoordinates(List<double> points, Size size) {
    List<Offset> coordinates = [];

    double spacing = size.width / (points.length - 1); // 좌표를 일정 간격으로 벌리지 위한 값을 구합니다.
    double maxY = points.reduce(max); // 데이터 중 최소값을 구합니다.
    double minY = points.reduce(min); // 데이터 중 최대값을 구합니다.

    double bottomPadding = fontSize * 2; // 텍스트가 들어갈 패딩(아랫쪽)을 구합니다.
    double topPadding = bottomPadding * 2; // 텍스트가 들어갈 패딩(위쪽)을 구합니다.
    double h = size.height - topPadding; // 패딩을 제외한 화면의 높이를 구합니다.

    for (int index = 0; index < points.length; index++) {
      double x = spacing * index; // x축 좌표를 구합니다.
      double normalizedY = points[index] / maxY; // 정규화한다. 정규화란 [0 ~ 1] 사이가 나오게 값을 변경하는 것.
      double y = getYPos(h, bottomPadding, normalizedY); // Y축 좌표를 구합니다. 높이에 비례한 값입니다.

      Offset coord = Offset(x, y);
      coordinates.add(coord);

      findMaxIndex(points, index, maxY, minY); // 텍스트(최대값)를 적기 위해, 최대값의 인덱스를 구해놓습니다.
      findMinIndex(points, index, maxY, minY); // 텍스트(최소값)를 적기 위해, 최대값의 인덱스를 구해놓습니다.
    }

    return coordinates;
  }

  double getYPos(double h, double bottomPadding, double normalizedY) => (h + bottomPadding) - (normalizedY * h);


  void findMaxIndex(List<double> points, int index, double maxY, double minY) {
    if (maxY == points[index]) {
      maxValueIndex = index;
    }
  }

  void findMinIndex(List<double> points, int index, double maxY,double minY) {
    if (minY == points[index]) {
      minValueIndex = index;
    }
  }

  void drawText(Canvas canvas, List<Offset> offsets) {
    String maxValue = points.reduce(max).toString();
    String minValue = points.reduce(min).toString();

    drawTextValue(canvas, minValue, offsets[minValueIndex], false);
    drawTextValue(canvas, maxValue, offsets[maxValueIndex], true);
  }

  void drawTextValue(Canvas canvas, String text, Offset pos, bool textUpward) {
    TextSpan maxSpan = TextSpan(style: TextStyle(fontSize: fontSize, color: Colors.black, fontWeight: FontWeight.bold), text: text);
    TextPainter tp = TextPainter(text: maxSpan, textDirection: TextDirection.ltr);
    tp.layout();

    double y = textUpward ? -tp.height * 1.5  : tp.height * 0.5; // 텍스트의 방향을 고려해 y축 값을 보정해줍니다.
    double dx = pos.dx - tp.width / 2; // 텍스트의 위치를 고려해 x축 값을 보정해줍니다.
    double dy = pos.dy + y;

    Offset offset = Offset(dx, dy);

    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(LineChart oldDelegate) {
    return oldDelegate.points != points;
  }
}



/////////////////////////
