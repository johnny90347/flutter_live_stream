import 'package:json_annotation/json_annotation.dart';

part 'giftDetailPart.g.dart';

@JsonSerializable()
class GiftDetailPart {
    GiftDetailPart();

    num Id;
    String Name;
    String Icon;
    String Mov;
    num Value;
    num Priority;
    
    factory GiftDetailPart.fromJson(Map<String,dynamic> json) => _$GiftDetailPartFromJson(json);
    Map<String, dynamic> toJson() => _$GiftDetailPartToJson(this);
}
