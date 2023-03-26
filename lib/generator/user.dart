class TaskResult {
  final int cost;
  final String taskName;
  final int count;
  final String? taskInfo;
  final String taskCode;

  TaskResult({
    required this.cost,
    this.taskName = 'unknown',
    required this.count,
    this.taskInfo,
    required this.taskCode,
  });

  TaskResult copyWith({
    int? cost,
    String? taskName,
    int? count,
    String? taskInfo,
    String? taskCode,
  }) {
    return TaskResult(
      cost: cost ?? this.cost,
      taskName: taskName ?? this.taskName,
      count: count ?? this.count,
      taskInfo: taskInfo ?? this.taskInfo,
      taskCode: taskCode ?? this.taskCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cost': cost,
      'taskName': taskName,
      'count': count,
      'taskInfo': taskInfo,
      'taskCode': taskCode,
    };
  }

  static TaskResult fromJson(Map<String, dynamic> json) {
    return TaskResult(
      cost: json['cost'] as int,
      taskName: json['taskName'] as String,
      count: json['count'] as int,
      taskInfo: json['taskInfo'] as String,
      taskCode: json['taskCode'] as String,
    );
  }
}
