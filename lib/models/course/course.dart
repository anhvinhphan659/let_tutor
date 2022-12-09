import '../category.dart';

class Course {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  Null? courseType;
  Null? sectionType;
  bool? visible;
  Null? displayOrder;
  String? createdAt;
  String? updatedAt;
  List<Topic>? topics;
  List<Category>? categories;

  Course(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.level,
      this.reason,
      this.purpose,
      this.otherDetails,
      this.defaultPrice,
      this.coursePrice,
      this.courseType,
      this.sectionType,
      this.visible,
      this.displayOrder,
      this.createdAt,
      this.updatedAt,
      this.topics,
      this.categories});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    reason = json['reason'];
    purpose = json['purpose'];
    otherDetails = json['other_details'];
    defaultPrice = json['default_price'];
    coursePrice = json['course_price'];
    courseType = json['courseType'];
    sectionType = json['sectionType'];
    visible = json['visible'];
    displayOrder = json['displayOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['topics'] != null) {
      topics = <Topic>[];
      json['topics'].forEach((v) {
        topics!.add(new Topic.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['level'] = this.level;
    data['reason'] = this.reason;
    data['purpose'] = this.purpose;
    data['other_details'] = this.otherDetails;
    data['default_price'] = this.defaultPrice;
    data['course_price'] = this.coursePrice;
    data['courseType'] = this.courseType;
    data['sectionType'] = this.sectionType;
    data['visible'] = this.visible;
    data['displayOrder'] = this.displayOrder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
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
  int? numberOfPages;
  String? description;
  String? videoUrl;
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
