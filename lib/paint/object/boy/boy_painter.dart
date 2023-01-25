import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
//<svg
//  xmlns="http://www.w3.org/2000/svg"
//  xmlns:xlink="http://www.w3.org/1999/xlink"
//  width="66.5px" height="100.5px">
// <path fill-rule="evenodd"  stroke="rgb(0, 0, 0)" stroke-width="1px" stroke-linecap="butt" stroke-linejoin="miter" fill="none"
//  d="M1.500,98.499 C12.749,93.739 12.615,79.541 20.500,41.499 C26.22,14.852 64.499,8.499 64.499,8.499 C64.499,8.499 50.398,10.981 44.499,1.499 "/>
// </svg>
class BoyPainter extends CustomPainter {
  final Paint _bgPainter = Paint()..color = Colors.grey.withOpacity(0.1);

  final Paint _mainPainter = Paint()
    ..color = const Color(0xff1E1E1E)
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, _bgPainter);
    final Path path0 = parseSvgPathData('''M9,114c11.249-4.76,11.1-18.962,19-57,5.528-26.614,45.08-32.5,45-33,0,0-35.863-9.146-23-7,16.046,2.677,19.662,4.6,26,3,5.511-1.392,36.687-9.16,59,4,2.271,0.533-2-14-2-14h1s6.712,18.611,10,19c4.8,0.568,10.8-.354,15,2,2.259,1.265,19.5,17.117,21,24,1.1,5.045,15.161,43.426,24,50-0.465.258-7.035,3.64-18-6,5.15,17.95-13.138,37.477-16,40-2.893,2.551,5.654-36.757-11-53,0.431,7.116-12.888,24.167-14,23-4.189-4.4,2.181-19.187-9-32-2.591,18.441-21.813,28.584-23,29s7.369-15.5,5-24c-18.983,13.444-29.071,20.1-32,26-1.6-2.082,3.834-17.332,4-17-7.31,2.493-19.294,34.14-22,35-2.208-1.8-2.444-18.81,0-30-0.3-.869-6.593,9.646-9,15s-11,10-11,10c-4.1,1.117-8.07-5.984-7-10-0.694-2.606-4.81,5.623-7.542,13.99-1.478,4.528-2.551,9.1-2.458,12.01,0.267,8.3-7.811-5.935-2-25C26.52,110.069-3.132,119.134,9,114Z''');

    final Path path1 = parseSvgPathData('''M169,126s-1.3,21.312-5,34c-7.405,17.911-27.845,19.089-35,21s-29.25-4.75-38-8-31.1-11.661-34-35c-1.4-9.339-2.1-12.161,0-24''');

    final Path path2 = parseSvgPathData('''M91,100s14.794-4.9,27,2''');

    final Path path3 = parseSvgPathData('''M149,110s10.838-4.239,16,5''');

    final Path path4 = parseSvgPathData('''M82,127s4.218-7.446,12.3-10.341c6.09-2.182,14.374-1.779,24.7,6.341''');

    final Path path5 = parseSvgPathData('''M146,131''');

    final Path path6 = parseSvgPathData('''M90,120s-5.913,20.8,6,23c8.307,1.531,10.706.512,14-1,3.79-1.74,2.844-13.325,2-22''');

    final Path path7 = parseSvgPathData('''M150,129s-5.111,14.318,2,19a6.539,6.539,0,0,0,9-1c2.381-2.552,2.869-7.4,3-15''');

    final Path path8 = parseSvgPathData('''M112,167s3.517,3.851,7,4,14.448,1.169,17,0,4-2,4-2''');

    final Path path9 = parseSvgPathData('''M147,130s14.418-15.181,18,5''');



    canvas.drawPath(path0, _mainPainter);
    canvas.drawPath(path1, _mainPainter);
    canvas.drawPath(path2, _mainPainter);
    canvas.drawPath(path3, _mainPainter);
    canvas.drawPath(path4, _mainPainter);
    canvas.drawPath(path5, _mainPainter);
    canvas.drawPath(path6, _mainPainter);
    canvas.drawPath(path7, _mainPainter);
    canvas.drawPath(path8, _mainPainter);
    canvas.drawPath(path9, _mainPainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}