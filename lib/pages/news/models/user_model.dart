import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModelResponse {
  @JsonKey(name: 'results')
  final List<UserModel> items;

  UserModelResponse(this.items);

  factory UserModelResponse.fromJson(Map<String, dynamic> json) =>
  _$UserModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelResponseToJson(this);
}

@JsonSerializable()
class UserModel {
  final String email;
  final UserName name;
  final UserPicture picture;

  UserModel(this.email, this.name, this.picture);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
  _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserName {
  @JsonKey(defaultValue: "")
  final String first;
  @JsonKey(defaultValue: "")
  final String last;

  String get name => [first, last].where((s) => s.isNotEmpty).join(' ');

  UserName(this.first, this.last);

  factory UserName.fromJson(Map<String, dynamic> json) =>
  _$UserNameFromJson(json);
  Map<String, dynamic> toJson() => _$UserNameToJson(this);
}

@JsonSerializable()
class UserPicture {
  @JsonKey(name: 'thumbnail')
  final String thumbnailUrl;

  UserPicture(this.thumbnailUrl);

  factory UserPicture.fromJson(Map<String, dynamic> json) =>
  _$UserPictureFromJson(json);
  Map<String, dynamic> toJson() => _$UserPictureToJson(this);
}
