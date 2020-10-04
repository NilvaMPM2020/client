
import 'package:asoude/constants/assets.dart';

enum RoleType {
  USER, COMPANY
}

extension RoleTypeExtension on RoleType {
    String get name {
      switch(this){
        case RoleType.USER:
          return "شخصی";
        case RoleType.COMPANY:
          return "کسب و کار";
        default:
          return null;
      }
    }

    String get asset {
      switch(this){
        case RoleType.USER:
          return Assets.userLoginIcon;
        case RoleType.COMPANY:
          return Assets.companyLoginIcon;
        default:
          return null;
      }
    }

}