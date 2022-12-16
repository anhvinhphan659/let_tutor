import 'package:let_tutor/utils/util_function.dart';

class BookingSchedule {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;
  Null? cancelReasonId;
  Null? lessonPlanId;
  Null? cancelNote;
  Null? calendarId;
  bool? isDeleted;
  ScheduleDetailInfo? scheduleDetailInfo;
  ClassReview? classReview;
  bool? showRecordUrl;
  List<dynamic>? studentMaterials;
  List<Feedbacks>? feedbacks;

  BookingSchedule(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.userId,
      this.scheduleDetailId,
      this.tutorMeetingLink,
      this.studentMeetingLink,
      this.studentRequest,
      this.tutorReview,
      this.scoreByTutor,
      this.createdAt,
      this.updatedAt,
      this.recordUrl,
      this.cancelReasonId,
      this.lessonPlanId,
      this.cancelNote,
      this.calendarId,
      this.isDeleted,
      this.scheduleDetailInfo,
      this.classReview,
      this.showRecordUrl,
      this.studentMaterials,
      this.feedbacks});

  BookingSchedule.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    studentRequest = json['studentRequest'];
    tutorReview = json['tutorReview'];
    scoreByTutor = json['scoreByTutor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    recordUrl = json['recordUrl'];
    cancelReasonId = json['cancelReasonId'];
    lessonPlanId = json['lessonPlanId'];
    cancelNote = json['cancelNote'];
    calendarId = json['calendarId'];
    isDeleted = json['isDeleted'];
    scheduleDetailInfo = json['scheduleDetailInfo'] != null
        ? new ScheduleDetailInfo.fromJson(json['scheduleDetailInfo'])
        : null;
    classReview = json['classReview'] != null
        ? ClassReview.fromJson(json['classReview'])
        : null;
    showRecordUrl = json['showRecordUrl'];
    if (json['studentMaterials'] != null) {
      studentMaterials = <Null>[];
      json['studentMaterials'].forEach((v) {
        studentMaterials!.add(v);
      });
    }
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAtTimeStamp'] = this.createdAtTimeStamp;
    data['updatedAtTimeStamp'] = this.updatedAtTimeStamp;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['scheduleDetailId'] = this.scheduleDetailId;
    data['tutorMeetingLink'] = this.tutorMeetingLink;
    data['studentMeetingLink'] = this.studentMeetingLink;
    data['studentRequest'] = this.studentRequest;
    data['tutorReview'] = this.tutorReview;
    data['scoreByTutor'] = this.scoreByTutor;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['recordUrl'] = this.recordUrl;
    data['cancelReasonId'] = this.cancelReasonId;
    data['lessonPlanId'] = this.lessonPlanId;
    data['cancelNote'] = this.cancelNote;
    data['calendarId'] = this.calendarId;
    data['isDeleted'] = this.isDeleted;
    if (this.scheduleDetailInfo != null) {
      data['scheduleDetailInfo'] = this.scheduleDetailInfo!.toJson();
    }
    data['classReview'] = this.classReview;
    data['showRecordUrl'] = this.showRecordUrl;
    if (this.studentMaterials != null) {
      data['studentMaterials'] =
          this.studentMaterials!.map((v) => v.toJson()).toList();
    }
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduleDetailInfo {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  ScheduleInfo? scheduleInfo;

  ScheduleDetailInfo(
      {this.startPeriodTimestamp,
      this.endPeriodTimestamp,
      this.id,
      this.scheduleId,
      this.startPeriod,
      this.endPeriod,
      this.createdAt,
      this.updatedAt,
      this.scheduleInfo});

  ScheduleDetailInfo.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    scheduleInfo = json['scheduleInfo'] != null
        ? new ScheduleInfo.fromJson(json['scheduleInfo'])
        : null;
  }
  String getSessionInfo() {
    return "Session 1: ${convertTimeStampToHour(startPeriodTimestamp ?? 0)}${convertTimeStampToHour(endPeriodTimestamp ?? 0)}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPeriodTimestamp'] = this.startPeriodTimestamp;
    data['endPeriodTimestamp'] = this.endPeriodTimestamp;
    data['id'] = this.id;
    data['scheduleId'] = this.scheduleId;
    data['startPeriod'] = this.startPeriod;
    data['endPeriod'] = this.endPeriod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.scheduleInfo != null) {
      data['scheduleInfo'] = this.scheduleInfo!.toJson();
    }
    return data;
  }
}

class ScheduleInfo {
  String? date;
  int? startTimestamp;
  int? endTimestamp;
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  TutorInfo? tutorInfo;

  ScheduleInfo(
      {this.date,
      this.startTimestamp,
      this.endTimestamp,
      this.id,
      this.tutorId,
      this.startTime,
      this.endTime,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.tutorInfo});

  ScheduleInfo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tutorInfo = json['tutorInfo'] != null
        ? new TutorInfo.fromJson(json['tutorInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['startTimestamp'] = this.startTimestamp;
    data['endTimestamp'] = this.endTimestamp;
    data['id'] = this.id;
    data['tutorId'] = this.tutorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tutorInfo != null) {
      data['tutorInfo'] = this.tutorInfo!.toJson();
    }
    return data;
  }
}

class TutorInfo {
  String? id;
  String? level;
  String? email;
  Null? google;
  Null? facebook;
  Null? apple;
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

  TutorInfo(
      {this.id,
      this.level,
      this.email,
      this.google,
      this.facebook,
      this.apple,
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
      this.studentGroupId});

  TutorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['email'] = this.email;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['apple'] = this.apple;
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
    return data;
  }
}

class Feedbacks {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;

  Feedbacks(
      {this.id,
      this.bookingId,
      this.firstId,
      this.secondId,
      this.rating,
      this.content,
      this.createdAt,
      this.updatedAt});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    rating = json['rating'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookingId'] = this.bookingId;
    data['firstId'] = this.firstId;
    data['secondId'] = this.secondId;
    data['rating'] = this.rating;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class ClassReview {
  String? bookingId;
  int? lessonStatusId;
  String? book;
  String? unit;
  String? lesson;
  Null? page;
  String? lessonProgress;
  int? behaviorRating;
  String? behaviorComment;
  int? listeningRating;
  String? listeningComment;
  int? speakingRating;
  String? speakingComment;
  int? vocabularyRating;
  String? vocabularyComment;
  String? homeworkComment;
  String? overallComment;
  LessonStatus? lessonStatus;

  ClassReview(
      {this.bookingId,
      this.lessonStatusId,
      this.book,
      this.unit,
      this.lesson,
      this.page,
      this.lessonProgress,
      this.behaviorRating,
      this.behaviorComment,
      this.listeningRating,
      this.listeningComment,
      this.speakingRating,
      this.speakingComment,
      this.vocabularyRating,
      this.vocabularyComment,
      this.homeworkComment,
      this.overallComment,
      this.lessonStatus});

  ClassReview.fromJson(Map<String, dynamic> json) {
    bookingId = json['bookingId'];
    lessonStatusId = json['lessonStatusId'];
    book = json['book'];
    unit = json['unit'];
    lesson = json['lesson'];
    page = json['page'];
    lessonProgress = json['lessonProgress'];
    behaviorRating = json['behaviorRating'];
    behaviorComment = json['behaviorComment'];
    listeningRating = json['listeningRating'];
    listeningComment = json['listeningComment'];
    speakingRating = json['speakingRating'];
    speakingComment = json['speakingComment'];
    vocabularyRating = json['vocabularyRating'];
    vocabularyComment = json['vocabularyComment'];
    homeworkComment = json['homeworkComment'];
    overallComment = json['overallComment'];
    lessonStatus = json['lessonStatus'] != null
        ? new LessonStatus.fromJson(json['lessonStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingId'] = this.bookingId;
    data['lessonStatusId'] = this.lessonStatusId;
    data['book'] = this.book;
    data['unit'] = this.unit;
    data['lesson'] = this.lesson;
    data['page'] = this.page;
    data['lessonProgress'] = this.lessonProgress;
    data['behaviorRating'] = this.behaviorRating;
    data['behaviorComment'] = this.behaviorComment;
    data['listeningRating'] = this.listeningRating;
    data['listeningComment'] = this.listeningComment;
    data['speakingRating'] = this.speakingRating;
    data['speakingComment'] = this.speakingComment;
    data['vocabularyRating'] = this.vocabularyRating;
    data['vocabularyComment'] = this.vocabularyComment;
    data['homeworkComment'] = this.homeworkComment;
    data['overallComment'] = this.overallComment;
    if (this.lessonStatus != null) {
      data['lessonStatus'] = this.lessonStatus!.toJson();
    }
    return data;
  }

  String getLessonStatus() {
    String ret = "";
    ret += "Lesson status: ${lessonStatus!.status ?? ""}\n";
    ret += "Book: ${book ?? ""}Unit: ${unit ?? ""} - Lesson${lesson ?? ""}\n";
    ret += "Behavior";
    for (int i = 0; i < (behaviorRating ?? 0); i++) {
      ret += "⭐";
    }
    ret += "${behaviorComment ?? ""}\n";

    ret += "Listening";
    for (int i = 0; i < (listeningRating ?? 0); i++) {
      ret += "⭐";
    }
    ret += "${listeningComment ?? ""}\n";

    ret += "Speaking";
    for (int i = 0; i < (speakingRating ?? 0); i++) {
      ret += "⭐";
    }
    ret += "${speakingComment ?? ""}\n";

    ret += "Vocabulary";
    for (int i = 0; i < (vocabularyRating ?? 0); i++) {
      ret += "⭐";
    }
    ret += "${vocabularyComment ?? ""}\n";
    ret += "Homework: ${homeworkComment ?? ""}\n";
    ret += "Overall: ${overallComment ?? ""}\n";
    return ret;
  }
}

class LessonStatus {
  int? id;
  String? status;
  String? createdAt;
  String? updatedAt;

  LessonStatus({this.id, this.status, this.createdAt, this.updatedAt});

  LessonStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
