class UserData extends BaseChatsData {
  String? userId;
  String? email;
  String? photoUrl;
  String? phoneNumber;
  String? langCode;
  String? language;
  List<String>? chatsList;
  List<String>? groups;

  UserData({
    super.id,
    super.name,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.langCode,
    this.language,
    this.chatsList,
    this.groups,
  });

  UserData.fromJson(Map<String, dynamic> json, String? usersId) {
    id = json['id'] ?? "";
    userId = usersId ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    photoUrl = json['photoUrl'] ?? "";
    phoneNumber = json['phoneNumber'] ?? "";
    langCode = json['langCode'] ?? "";
    language = json['language'] ?? "";
    chatsList = json['chatsList'] == null ? [] : List<String>.from(json['chatsList']);
    groups = json['groups'] == null ? [] : List<String>.from(json['groups']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['phoneNumber'] = phoneNumber;
    data['langCode'] = langCode;
    data['language'] = language;
    data['chatsList'] = chatsList;
    data['groups'] = groups;
    return data;
  }
}

class BaseChatsData {
  String? id;
  String? name;

  BaseChatsData({this.id, this.name});
}
