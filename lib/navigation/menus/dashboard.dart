
// import '../../../app/res/fx_icon.dart';

Map<String, dynamic> dashboard = {
  'path': '/dashboard',
  'label': '面板总览',
  // 'icon': FxIcon.dashboard,
  'children': [
    {
      'path': '/view',
      'label': '小册全集',
    },
    {
      'path': '/chat',
      'label': '读者交流',
      'children': [
        {
          'path': '/a',
          'label': '第一交流区',
        },
        {
          'path': '/b',
          'label': '第二交流区',
        },
        {
          'path': '/c',
          'label': '第三交流区',
        },
      ]
    },
  ],
};