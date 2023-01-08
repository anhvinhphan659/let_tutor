class ContentCategory {
  String? id;
  String? title;
  Null? description;
  String? key;
  Null? displayOrder;
  String? createdAt;
  String? updatedAt;

  ContentCategory(
      {this.id,
      this.title,
      this.description,
      this.key,
      this.displayOrder,
      this.createdAt,
      this.updatedAt});

  ContentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    displayOrder = json['displayOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['key'] = this.key;
    data['displayOrder'] = this.displayOrder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
