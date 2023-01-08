class TeacherSchedule {
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  List<ScheduleDetail>? scheduleDetails;

  TeacherSchedule(
      {this.id,
      this.tutorId,
      this.startTime,
      this.endTime,
      this.startTimestamp,
      this.endTimestamp,
      this.createdAt,
      this.isBooked,
      this.scheduleDetails});

  TeacherSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    createdAt = json['createdAt'];
    isBooked = json['isBooked'];
    scheduleDetails = <ScheduleDetail>[];
    if (json['scheduleDetails'] != null) {
      json['scheduleDetails'].forEach((v) {
        scheduleDetails!.add(new ScheduleDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tutorId'] = this.tutorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['startTimestamp'] = this.startTimestamp;
    data['endTimestamp'] = this.endTimestamp;
    data['createdAt'] = this.createdAt;
    data['isBooked'] = this.isBooked;
    if (this.scheduleDetails != null) {
      data['scheduleDetails'] =
          this.scheduleDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<String> getListUserID() {
    List<String> res = [];
    scheduleDetails = scheduleDetails ?? [];
    if (scheduleDetails!.length > 0) {
      ScheduleDetail scheduleDetail = scheduleDetails![0];
      for (var detail in scheduleDetail.bookingInfo ?? <BookingInfo>[]) {
        res.add(detail.userId!);
      }
    }

    return res;
  }

  bool isReversedClass() {
    if (scheduleDetails != null && scheduleDetails!.isNotEmpty) {
      var scheduleDetail = scheduleDetails![0];
      for (var booking in scheduleDetail.bookingInfo ?? <BookingInfo>[]) {
        if ((booking.isDeleted ?? true) == false) {
          return true;
        }
      }
    }
    return false;
  }

  List<String> getListScheduleId() {
    List<String> res = [];
    scheduleDetails = scheduleDetails ?? [];
    for (var detail in scheduleDetails!) {
      res.add(detail.id ?? "");
    }

    return res;
  }
}

class ScheduleDetail {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  List<BookingInfo>? bookingInfo;
  bool? isBooked;

  ScheduleDetail(
      {this.startPeriodTimestamp,
      this.endPeriodTimestamp,
      this.id,
      this.scheduleId,
      this.startPeriod,
      this.endPeriod,
      this.createdAt,
      this.updatedAt,
      this.bookingInfo,
      this.isBooked});

  ScheduleDetail.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['bookingInfo'] != null) {
      bookingInfo = <BookingInfo>[];
      json['bookingInfo'].forEach((v) {
        bookingInfo!.add(new BookingInfo.fromJson(v));
      });
    }
    isBooked = json['isBooked'];
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
    if (this.bookingInfo != null) {
      data['bookingInfo'] = this.bookingInfo!.map((v) => v.toJson()).toList();
    }
    data['isBooked'] = this.isBooked;
    return data;
  }
}

class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  bool? isDeleted;
  String? createdAt;
  String? scheduleDetailId;
  String? updatedAt;
  int? cancelReasonId;
  String? userId;

  BookingInfo(
      {this.createdAtTimeStamp,
      this.updatedAtTimeStamp,
      this.id,
      this.isDeleted,
      this.createdAt,
      this.scheduleDetailId,
      this.updatedAt,
      this.cancelReasonId,
      this.userId});

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    scheduleDetailId = json['scheduleDetailId'];
    updatedAt = json['updatedAt'];
    cancelReasonId = json['cancelReasonId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAtTimeStamp'] = this.createdAtTimeStamp;
    data['updatedAtTimeStamp'] = this.updatedAtTimeStamp;
    data['id'] = this.id;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['scheduleDetailId'] = this.scheduleDetailId;
    data['updatedAt'] = this.updatedAt;
    data['cancelReasonId'] = this.cancelReasonId;
    data['userId'] = this.userId;
    return data;
  }
}
