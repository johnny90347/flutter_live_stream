import 'package:json_annotation/json_annotation.dart';

part 'loginInfoModel.g.dart';

@JsonSerializable()
class LoginInfoModel {
    LoginInfoModel();

    String AnchorId;
    num Code;
    String Currency;
    String Lang;
    num Level;
    String Pid;
    String Token;
    num UserFlag;
    String SrcPlatform;
    String Origin;
    
    factory LoginInfoModel.fromJson(Map<String,dynamic> json) => _$LoginInfoModelFromJson(json);
    Map<String, dynamic> toJson() => _$LoginInfoModelToJson(this);
}
