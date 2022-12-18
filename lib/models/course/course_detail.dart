class CourseDetail {
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
  List<Topics>? topics;
  List<SuggestTeacher>? suggestTeachers;

  CourseDetail(
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
      this.suggestTeachers});

  CourseDetail.fromJson(Map<String, dynamic> json) {
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
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
    if (json['users'] != null) {
      suggestTeachers = <SuggestTeacher>[];
      json['users'].forEach((v) {
        suggestTeachers!.add(new SuggestTeacher.fromJson(v));
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
    if (this.suggestTeachers != null) {
      data['users'] = this.suggestTeachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
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

  Topics(
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

  Topics.fromJson(Map<String, dynamic> json) {
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

class SuggestTeacher {
  String? id;
  String? level;
  String? email;
  Null? google;
  Null? facebook;
  Null? apple;
  String? password;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  Null? isPhoneActivated;
  Null? requireNote;
  int? timezone;
  Null? phoneAuth;
  bool? isPhoneAuthActivated;
  Null? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  Null? caredByStaffId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? studentGroupId;
  TutorCourse? tutorCourse;

  SuggestTeacher(
      {this.id,
      this.level,
      this.email,
      this.google,
      this.facebook,
      this.apple,
      this.password,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.isPhoneActivated,
      this.requireNote,
      this.timezone,
      this.phoneAuth,
      this.isPhoneAuthActivated,
      this.studySchedule,
      this.canSendMessage,
      this.isPublicRecord,
      this.caredByStaffId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentGroupId,
      this.tutorCourse});

  SuggestTeacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    password = json['password'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    studentGroupId = json['studentGroupId'];
    tutorCourse = json['TutorCourse'] != null
        ? new TutorCourse.fromJson(json['TutorCourse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['email'] = this.email;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['apple'] = this.apple;
    data['password'] = this.password;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['requestPassword'] = this.requestPassword;
    data['isActivated'] = this.isActivated;
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['requireNote'] = this.requireNote;
    data['timezone'] = this.timezone;
    data['phoneAuth'] = this.phoneAuth;
    data['isPhoneAuthActivated'] = this.isPhoneAuthActivated;
    data['studySchedule'] = this.studySchedule;
    data['canSendMessage'] = this.canSendMessage;
    data['isPublicRecord'] = this.isPublicRecord;
    data['caredByStaffId'] = this.caredByStaffId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['studentGroupId'] = this.studentGroupId;
    if (this.tutorCourse != null) {
      data['TutorCourse'] = this.tutorCourse!.toJson();
    }
    return data;
  }
}

class TutorCourse {
  String? userId;
  String? courseId;
  String? createdAt;
  String? updatedAt;

  TutorCourse({this.userId, this.courseId, this.createdAt, this.updatedAt});

  TutorCourse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    courseId = json['CourseId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['CourseId'] = this.courseId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
