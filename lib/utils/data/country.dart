class Country {
  String? name;
  String? code;
  String? capital;
  String? region;
  Currency? currency;
  Language? language;
  String? flag;

  Country(
      {this.name,
      this.code,
      this.capital,
      this.region,
      this.currency,
      this.language,
      this.flag});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    capital = json['capital'];
    region = json['region'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['capital'] = this.capital;
    data['region'] = this.region;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['flag'] = this.flag;
    return data;
  }
}

class Currency {
  String? code;
  String? name;
  String? symbol;

  Currency({this.code, this.name, this.symbol});

  Currency.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}

class Language {
  String? code;
  String? name;

  Language({this.code, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
