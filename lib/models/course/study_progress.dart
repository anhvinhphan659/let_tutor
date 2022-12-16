class StudyProgress {
  List<LatestLearningDate>? latestLearningDate;
  List<LearningProgress>? learningProgress;

  StudyProgress({this.latestLearningDate, this.learningProgress});

  StudyProgress.fromJson(Map<String, dynamic> json) {
    if (json['latestLearningDate'] != null) {
      latestLearningDate = <LatestLearningDate>[];
      json['latestLearningDate'].forEach((v) {
        latestLearningDate!.add(new LatestLearningDate.fromJson(v));
      });
    }
    if (json['learningProgress'] != null) {
      learningProgress = <LearningProgress>[];
      json['learningProgress'].forEach((v) {
        learningProgress!.add(new LearningProgress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.latestLearningDate != null) {
      data['latestLearningDate'] =
          this.latestLearningDate!.map((v) => v.toJson()).toList();
    }
    if (this.learningProgress != null) {
      data['learningProgress'] =
          this.learningProgress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestLearningDate {
  int? id;
  String? studentId;
  String? eBookId;
  Null? topicId;
  String? bookingId;
  int? currentPage;
  String? latestDate;
  String? createdAt;
  String? updatedAt;
  EBookLearning? eBook;
  Null? topic;

  LatestLearningDate(
      {this.id,
      this.studentId,
      this.eBookId,
      this.topicId,
      this.bookingId,
      this.currentPage,
      this.latestDate,
      this.createdAt,
      this.updatedAt,
      this.eBook,
      this.topic});

  LatestLearningDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    eBookId = json['eBookId'];
    topicId = json['topicId'];
    bookingId = json['bookingId'];
    currentPage = json['currentPage'];
    latestDate = json['latestDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    eBook = json['eBook'] != null
        ? new EBookLearning.fromJson(json['eBook'])
        : null;
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentId'] = this.studentId;
    data['eBookId'] = this.eBookId;
    data['topicId'] = this.topicId;
    data['bookingId'] = this.bookingId;
    data['currentPage'] = this.currentPage;
    data['latestDate'] = this.latestDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.eBook != null) {
      data['eBook'] = this.eBook!.toJson();
    }
    data['topic'] = this.topic;
    return data;
  }
}

class EBookLearning {
  String? id;
  String? name;
  Null? description;
  Null? imageUrl;
  Null? level;
  Null? visible;
  String? fileUrl;
  String? createdAt;
  String? updatedAt;
  bool? isPrivate;
  String? createdBy;

  EBookLearning(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.level,
      this.visible,
      this.fileUrl,
      this.createdAt,
      this.updatedAt,
      this.isPrivate,
      this.createdBy});

  EBookLearning.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    visible = json['visible'];
    fileUrl = json['fileUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isPrivate = json['isPrivate'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['level'] = this.level;
    data['visible'] = this.visible;
    data['fileUrl'] = this.fileUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['isPrivate'] = this.isPrivate;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class LearningProgress {
  int? id;
  String? studentId;
  String? eBookId;
  String? topicId;
  String? bookingId;
  int? currentPage;
  String? latestDate;
  String? createdAt;
  String? updatedAt;
  Topic? topic;
  String? type;
  EBookLearning? eBook;

  LearningProgress(
      {this.id,
      this.studentId,
      this.eBookId,
      this.topicId,
      this.bookingId,
      this.currentPage,
      this.latestDate,
      this.createdAt,
      this.updatedAt,
      this.topic,
      this.type,
      this.eBook});

  LearningProgress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['studentId'];
    eBookId = json['eBookId'];
    topicId = json['topicId'];
    bookingId = json['bookingId'];
    currentPage = json['currentPage'];
    latestDate = json['latestDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    topic = json['topic'] != null ? new Topic.fromJson(json['topic']) : null;
    type = json['type'];
    eBook = json['eBook'] != null
        ? new EBookLearning.fromJson(json['eBook'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['studentId'] = this.studentId;
    data['eBookId'] = this.eBookId;
    data['topicId'] = this.topicId;
    data['bookingId'] = this.bookingId;
    data['currentPage'] = this.currentPage;
    data['latestDate'] = this.latestDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.topic != null) {
      data['topic'] = this.topic!.toJson();
    }
    data['type'] = this.type;
    if (this.eBook != null) {
      data['eBook'] = this.eBook!.toJson();
    }
    return data;
  }
}

class Topic {
  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  Null? numberOfPages;
  String? description;
  Null? videoUrl;
  Null? type;
  String? createdAt;
  String? updatedAt;

  Topic(
      {this.id,
      this.courseId,
      this.orderCourse,
      this.name,
      this.nameFile,
      this.numberOfPages,
      this.description,
      this.videoUrl,
      this.type,
      this.createdAt,
      this.updatedAt});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    orderCourse = json['orderCourse'];
    name = json['name'];
    nameFile = json['nameFile'];
    numberOfPages = json['numberOfPages'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courseId'] = this.courseId;
    data['orderCourse'] = this.orderCourse;
    data['name'] = this.name;
    data['nameFile'] = this.nameFile;
    data['numberOfPages'] = this.numberOfPages;
    data['description'] = this.description;
    data['videoUrl'] = this.videoUrl;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
