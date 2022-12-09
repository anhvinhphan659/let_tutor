class User {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  TutorInfo? tutorInfo;
  WalletInfo? walletInfo;
  Null? requireNote;
  String? level;
  List<LearnTopics>? learnTopics;
  List<TestPreparations>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  ReferralInfo? referralInfo;
  String? studySchedule;
  bool? canSendMessage;
  Null? studentGroup;
  Null? studentInfo;
  double? avgRating;

  User(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.roles,
      this.language,
      this.birthday,
      this.isActivated,
      this.tutorInfo,
      this.walletInfo,
      this.requireNote,
      this.level,
      this.learnTopics,
      this.testPreparations,
      this.isPhoneActivated,
      this.timezone,
      this.referralInfo,
      this.studySchedule,
      this.canSendMessage,
      this.studentGroup,
      this.studentInfo,
      this.avgRating});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    tutorInfo = json['tutorInfo'] != null
        ? new TutorInfo.fromJson(json['tutorInfo'])
        : null;
    walletInfo = json['walletInfo'] != null
        ? new WalletInfo.fromJson(json['walletInfo'])
        : null;
    requireNote = json['requireNote'];
    level = json['level'];
    if (json['learnTopics'] != null) {
      learnTopics = <LearnTopics>[];
      json['learnTopics'].forEach((v) {
        learnTopics!.add(new LearnTopics.fromJson(v));
      });
    }
    if (json['testPreparations'] != null) {
      testPreparations = <TestPreparations>[];
      json['testPreparations'].forEach((v) {
        testPreparations!.add(new TestPreparations.fromJson(v));
      });
    }
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    referralInfo = json['referralInfo'] != null
        ? new ReferralInfo.fromJson(json['referralInfo'])
        : null;
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    studentGroup = json['studentGroup'];
    studentInfo = json['studentInfo'];
    avgRating = json['avgRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['isActivated'] = this.isActivated;
    if (this.tutorInfo != null) {
      data['tutorInfo'] = this.tutorInfo!.toJson();
    }
    if (this.walletInfo != null) {
      data['walletInfo'] = this.walletInfo!.toJson();
    }
    data['requireNote'] = this.requireNote;
    data['level'] = this.level;
    if (this.learnTopics != null) {
      data['learnTopics'] = this.learnTopics!.map((v) => v.toJson()).toList();
    }
    if (this.testPreparations != null) {
      data['testPreparations'] =
          this.testPreparations!.map((v) => v.toJson()).toList();
    }
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['timezone'] = this.timezone;
    if (this.referralInfo != null) {
      data['referralInfo'] = this.referralInfo!.toJson();
    }
    data['studySchedule'] = this.studySchedule;
    data['canSendMessage'] = this.canSendMessage;
    data['studentGroup'] = this.studentGroup;
    data['studentInfo'] = this.studentInfo;
    data['avgRating'] = this.avgRating;
    return data;
  }
}

class TutorInfo {
  String? id;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  Null? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  Null? resume;
  Null? rating;
  bool? isActivated;
  bool? isNative;

  TutorInfo(
      {this.id,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.resume,
      this.rating,
      this.isActivated,
      this.isNative});

  TutorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    resume = json['resume'];
    rating = json['rating'];
    isActivated = json['isActivated'];
    isNative = json['isNative'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['resume'] = this.resume;
    data['rating'] = this.rating;
    data['isActivated'] = this.isActivated;
    data['isNative'] = this.isNative;
    return data;
  }
}

class WalletInfo {
  String? amount;
  bool? isBlocked;
  int? bonus;

  WalletInfo({this.amount, this.isBlocked, this.bonus});

  WalletInfo.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    isBlocked = json['isBlocked'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['isBlocked'] = this.isBlocked;
    data['bonus'] = this.bonus;
    return data;
  }
}

class LearnTopics {
  int? id;
  String? key;
  String? name;

  LearnTopics({this.id, this.key, this.name});

  LearnTopics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}

class ReferralInfo {
  String? referralCode;
  ReferralPackInfo? referralPackInfo;

  ReferralInfo({this.referralCode, this.referralPackInfo});

  ReferralInfo.fromJson(Map<String, dynamic> json) {
    referralCode = json['referralCode'];
    referralPackInfo = json['referralPackInfo'] != null
        ? new ReferralPackInfo.fromJson(json['referralPackInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referralCode'] = this.referralCode;
    if (this.referralPackInfo != null) {
      data['referralPackInfo'] = this.referralPackInfo!.toJson();
    }
    return data;
  }
}

class ReferralPackInfo {
  int? earnPercent;

  ReferralPackInfo({this.earnPercent});

  ReferralPackInfo.fromJson(Map<String, dynamic> json) {
    earnPercent = json['earnPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earnPercent'] = this.earnPercent;
    return data;
  }
}

class TestPreparations extends LearnTopics {
  @override
  int? id;
  @override
  String? key;
  @override
  String? name;

  TestPreparations({this.id, this.key, this.name})
      : super(id: id, key: key, name: name);

  TestPreparations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    return data;
  }
}
