class AuthToken {
  String? token;
  DateTime? expires;

  AuthToken({this.token, this.expires});

  AuthToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = DateTime.parse(json['expires'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}
