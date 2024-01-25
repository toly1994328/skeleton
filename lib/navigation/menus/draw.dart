import 'package:flutter/material.dart';
// import 'package:iroute/app/res/fx_icon.dart';

Map<String, dynamic> drawMenus = {
  'path': '/draw',
  // 'icon': FxIcon.icon_paint,
  'label': '绘制案例测试',
  'children': [
    {
      'path': '/coo',
      'label': '平面直角坐标系',
    },
    {
      'path': '/aeroplane',
      'label': '飞行棋盘',
    },
    {
      'path': '/digital',
      'label': '电子数字管',
    },
    {
      'path': '/game_box',
      'label': '小霸王游戏机',
    },
    {
      'path': '/structure',
      'label': '数据结构',
      // 'children': [
      //     {
      //       'path': '/array',
      //       'label': '数组',
      //     },
      // ],
    },
    {
      'path': '/arrow',
      'label': '箭头绘制',
    },
  ]
};
