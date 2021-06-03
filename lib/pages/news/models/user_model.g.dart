// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelResponse _$UserModelResponseFromJson(Map<String, dynamic> json) {
  return UserModelResponse(
    (json['results'] as List)
        ?.map((e) =>
            e == null ? null : UserModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserModelResponseToJson(UserModelResponse instance) =>
    <String, dynamic>{
      'results': instance.items,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    json['email'] as String,
    json['name'] == null
        ? null
        : UserName.fromJson(json['name'] as Map<String, dynamic>),
    json['picture'] == null
        ? null
        : UserPicture.fromJson(json['picture'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'picture': instance.picture,
    };

UserName _$UserNameFromJson(Map<String, dynamic> json) {
  return UserName(
    json['first'] as String ?? '',
    json['last'] as String ?? '',
  );
}

Map<String, dynamic> _$UserNameToJson(UserName instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
    };

UserPicture _$UserPictureFromJson(Map<String, dynamic> json) {
  return UserPicture(
    json['thumbnail'] as String,
  );
}

Map<String, dynamic> _$UserPictureToJson(UserPicture instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnailUrl,
    };
