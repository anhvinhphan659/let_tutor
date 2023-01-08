class TeacherDetail {
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  bool? isNative;
  TeacherDetailUser? user;
  bool? isFavorite;
  double? avgRating;
  int? totalFeedback;

  TeacherDetail(
      {this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.isNative,
      this.user,
      this.isFavorite,
      this.avgRating,
      this.totalFeedback});

  TeacherDetail.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    isNative = json['isNative'];
    user = json['User'] != null
        ? new TeacherDetailUser.fromJson(json['User'])
        : null;
    isFavorite = json['isFavorite'];
    avgRating = double.parse(json['avgRating'].toString());
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['accent'] = this.accent;
    data['targetStudent'] = this.targetStudent;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    data['specialties'] = this.specialties;
    data['rating'] = this.rating;
    data['isNative'] = this.isNative;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    data['isFavorite'] = this.isFavorite;
    data['avgRating'] = this.avgRating;
    data['totalFeedback'] = this.totalFeedback;
    return data;
  }
}

class TeacherDetailUser {
  String? id;
  String? level;
  String? avatar;
  String? name;
  String? country;
  String? language;
  bool? isPublicRecord;
  Null? caredByStaffId;
  Null? studentGroupId;
  List<TeacherDetailCourse>? courses;

  TeacherDetailUser(
      {this.id,
      this.level,
      this.avatar,
      this.name,
      this.country,
      this.language,
      this.isPublicRecord,
      this.caredByStaffId,
      this.studentGroupId,
      this.courses});

  TeacherDetailUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    language = json['language'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    studentGroupId = json['studentGroupId'];
    if (json['courses'] != null) {
      courses = <TeacherDetailCourse>[];
      json['courses'].forEach((v) {
        courses!.add(new TeacherDetailCourse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['language'] = this.language;
    data['isPublicRecord'] = this.isPublicRecord;
    data['caredByStaffId'] = this.caredByStaffId;
    data['studentGroupId'] = this.studentGroupId;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeacherDetailCourse {
  String? id;
  String? name;
  TutorCourse? tutorCourse;

  TeacherDetailCourse({this.id, this.name, this.tutorCourse});

  TeacherDetailCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tutorCourse = json['TutorCourse'] != null
        ? new TutorCourse.fromJson(json['TutorCourse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
