enum ShapeTab{
  circle('shaders/base_01_circle_step1.frag'),
  smooth('shaders/base_02_smooth_step1.frag'),
  line('shaders/base_03_line_step1.frag'),
  rect('shaders/rect/r01_rect_step_1.frag'),
  ;
  final String id;
  const ShapeTab(this.id);
}

List<Map<String, dynamic>> get data => [
  {
    'file': ShapeTab.circle.id,
    'title': '圆形',
    'step': [
      'shaders/base_01_circle_step1.frag',
      'shaders/base_01_circle_step2.frag',
      'shaders/base_01_circle_step3.frag',
      'shaders/base_01_circle_step4.frag',
      'shaders/base_01_circle_step5.frag',
      'shaders/base_01_circle_step6.frag',
      'shaders/base_01_circle_step7.frag',
    ]
  },
  {
    'file': ShapeTab.smooth.id,
    'title': '平滑过渡',
    'step': [
      'shaders/base_02_smooth_step1.frag',
      'shaders/base_02_smooth_step2.frag',
      'shaders/base_02_smooth_step3.frag',
    ]
  },
  {
    'file': ShapeTab.line.id,
    'title': '线',
    'step': [
      'shaders/base_03_line_step1.frag',
      'shaders/base_03_line_step2.frag',
      'shaders/base_03_line_step3.frag',
      'shaders/base_03_line_step4.frag',
    ]
  },
  {
    'file': ShapeTab.rect.id,
    'title': '矩形',
    'step': [
      'shaders/rect/r01_rect_step_1.frag',
      'shaders/rect/r01_rect_step_2.frag',
      'shaders/rect/r01_rect_step_3.frag',
      'shaders/rect/r01_rect_step_4.frag',
      'shaders/rect/r01_rect_step_5.frag',
    ]
  },

  // {
  //   'file': 'shaders/fancy_05.frag',
  //   'title': '波浪线',
  // },
];