import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'user_details.dart';

class UserPreference {
  // UserDetails userDetails = UserDetails();

  String roleIdKey = 'categoryIdKey';
  String isUserLoggedInKey = "isUserLoggedInKey";
  String userTokenKey = "userTokenKey";
  String selfIdKey = "selfIdKey";
  String userIdKey = "userIdKey";
  String userNameKey = "userNameKey";
  String userEmailKey = "userEmailKey";
  String roleId1Key = "roleIdKey";
  String userProfileImageKey = "userProfileImageKey";
  String shopNameKey = "shopNameKey";
  String shopProfileImageKey = "shopProfileImageKey";
  String userLatitudeKey = "userLatitudeKey";
  String userLongitudeKey = "userLongitudeKey";
  String userFullNameKey = 'userFullNameKey';
  String userAddressKey = 'userAddressKey';
  String userPhoneNoKey = 'userPhoneNoKey';
  String userActivateKey = 'userActivateLoginKey';
  String userCreatedAtKey = 'userCreatedAtLoginKey';
  String userUpdatedAtKey = 'userUpdatedAtLoginKey';

  // for login
  // String roleIdLoginKey = 'roleIdLoginKey';
  // String userNameLoginKey = 'userNameLoginKey';
  // String userEmailLoginKey = 'userEmailLoginKey';
  // String userPhoneNumberLoginKey = 'userPhoneNumberLoginKey';
  // String userRoleIdLoginKey = 'userRoleIdLoginKey';
  // String userActivateLoginKey = 'userActivateLoginKey';
  // String userVerifiedLoginKey = 'userVerifiedLoginKey';
  // String userCreatedbyLoginKey = 'userCreatedbyLoginKey';
  // String userEmailVerifiedAtLoginKey = 'userEmailVerifiedAtLoginKey';
  // String userCreatedAtLoginKey = 'userCreatedAtLoginKey';
  // String userUpdatedAtLoginKey = 'userUpdatedAtLoginKey';

  /// Set Role Id Key
  Future<void> setRoleId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(roleIdKey, value).toString();
    UserDetails.roleId = prefs.getInt(roleIdKey) ?? 0;
    log('role: ${UserDetails.roleId}');
    log("RoleIdKey : ${prefs.getInt(roleIdKey).toString()}");
  }

  /// Set User Login Or Register Details
  Future<void> setUserDetails({
    // required int selfId,
    required int userId,
    required String userName,
    required String userFullName,
    required String userEmail,
    String? userProfileImage,
    required String userActivate,
    String? userCreatedAt,
    String? userUpdatedAt,
    String? userAddress,
    String? userPhoneNo,

    // required String token,
    required int roleId,
    // required String shopName,
    // String? shopProfile
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt(selfIdKey, selfId);
    prefs.setInt(userIdKey, userId).toString();
    prefs.setString(userNameKey, userName);

    prefs.setString(userFullNameKey, userFullName);
    prefs.setString(userAddressKey, userAddress!);
    prefs.setString(userPhoneNoKey, userPhoneNo!);
    prefs.setString(userActivateKey, userActivate);
    prefs.setString(userCreatedAtKey, userCreatedAt!);
    prefs.setString(userActivateKey, userUpdatedAt!);

    prefs.setString(userEmailKey, userEmail);
    prefs.setString(userProfileImageKey, userProfileImage!);
    // prefs.setString(userTokenKey, token);
    prefs.setInt(roleId1Key, roleId).toString();
    prefs.setBool(isUserLoggedInKey, true);
    // prefs.setString(shopNameKey, shopName);
    // prefs.setString(shopProfileImageKey, shopProfile!);

    // UserDetails.id = prefs.getInt(selfIdKey) ?? 0;
    UserDetails.userId = prefs.getInt(userIdKey) ?? 0;
    UserDetails.userName = prefs.getString(userNameKey) ?? "";
    UserDetails.userFullName = prefs.getString(userFullNameKey) ?? "";
    UserDetails.userAddress = prefs.getString(userAddressKey) ?? "";
    UserDetails.userPhoneNo = prefs.getString(userPhoneNoKey) ?? "";
    UserDetails.userActivate = prefs.getString(userActivateKey) ?? "";
    UserDetails.userCreatedAt = prefs.getString(userCreatedAtKey) ?? "";
    UserDetails.userUpdatedAt = prefs.getString(userUpdatedAtKey) ?? "";

    UserDetails.userEmail = prefs.getString(userEmailKey) ?? "";
    UserDetails.userProfileImage = prefs.getString(userProfileImageKey) ?? "";
    UserDetails.userToken = prefs.getString(userTokenKey) ?? "";
    UserDetails.categoryId = prefs.getInt(roleId1Key) ?? 0;
    UserDetails.isUserLoggedIn = prefs.getBool(isUserLoggedInKey) ?? false;
    UserDetails.shopName = prefs.getString(shopNameKey) ?? "";
    UserDetails.shopProfile = prefs.getString(shopProfileImageKey) ?? "";

    // log("selfId : ${UserDetails.id}");
    log("userId : ${UserDetails.userId}");
    log("userName : ${UserDetails.userName}");
    // log("userFullName : ${UserDetails.userFullName}");
    log("userEmail : ${UserDetails.userEmail}");
    // log("userProfileImage : ${UserDetails.userProfileImage}");
    // log("userToken : ${UserDetails.userToken}");
    log("roleId : ${UserDetails.categoryId}");
    log("isUserLoggedIn : ${UserDetails.isUserLoggedIn}");
    // log("shopName : ${UserDetails.shopName}");
  }

  /// Set User Login Or Register Details
  // Future<void> setUserProfileDetails({
  //   required String userName,
  //   required String userProfileImage,
  // }) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt(selfIdKey, selfId);
  //   prefs.setInt(userIdKey, userId);
  //   prefs.setString(userNameKey, userName);
  //   prefs.setString(userEmailKey, userEmail);
  //   prefs.setString(userProfileImageKey, userProfileImage);
  //   prefs.setString(userTokenKey, token);
  //   prefs.setInt(roleId1Key, roleId);
  //   prefs.setBool(isUserLoggedInKey, true);
  //
  //   UserDetails.selfId = prefs.getInt(selfIdKey) ?? 0;
  //   UserDetails.userId = prefs.getInt(userIdKey) ?? 0;
  //   UserDetails.userName = prefs.getString(userNameKey) ?? "";
  //   UserDetails.userEmail = prefs.getString(userEmailKey) ?? "";
  //   UserDetails.userProfileImage = prefs.getString(userProfileImageKey) ?? "";
  //   UserDetails.userToken = prefs.getString(userTokenKey) ?? "";
  //   UserDetails.categoryId = prefs.getInt(roleId1Key) ?? 0;
  //   UserDetails.isUserLoggedIn = prefs.getBool(isUserLoggedInKey) ?? false;
  //
  //   log("selfId : ${UserDetails.selfId}");
  //   log("userId : ${UserDetails.userId}");
  //   log("userName : ${UserDetails.userName}");
  //   log("userEmail : ${UserDetails.userEmail}");
  //   log("userProfileImage : ${UserDetails.userProfileImage}");
  //   log("userToken : ${UserDetails.userToken}");
  //   log("roleId : ${UserDetails.categoryId}");
  //   log("isUserLoggedIn : ${UserDetails.isUserLoggedIn}");
  // }

  Future<void> setUserLocation(
      {required String latitude, required String longitude}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userLatitudeKey, latitude);
    prefs.setString(userLongitudeKey, longitude);

    // prefs.setString(userLatitudeKey, "21.2185");
    // prefs.setString(userLongitudeKey, "72.8368");

    UserDetails.liveLatitude = prefs.getString(userLatitudeKey) ?? "";
    UserDetails.liveLongitude = prefs.getString(userLongitudeKey) ?? "";

    log("User Latitude1212 : ${UserDetails.liveLatitude}");
    log("User Longitude1212 : ${UserDetails.liveLongitude}");
  }

  Future<void> removeUserLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Set Default Value
    prefs.setString(userLatitudeKey, "");
    prefs.setString(userLongitudeKey, "");
    // Remove Value
    prefs.remove(userLatitudeKey);
    prefs.remove(userLongitudeKey);

    // Remove Location from local variable
    UserDetails.liveLatitude = "";
    UserDetails.liveLongitude = "";
  }

  /// Logout
  Future<void> removeUserDetails() async {
    // Set Default Value in Prefs
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isUserLoggedInKey, false);
    prefs.setString(userTokenKey, "");
    prefs.setString(selfIdKey, "");
    prefs.setString(userIdKey, "");
    prefs.setString(userNameKey, "");
    prefs.setString(userEmailKey, "");
    prefs.setString(userProfileImageKey, "");
    prefs.setString(roleId1Key, "");
    prefs.setString(shopNameKey, "");
    prefs.setString(shopProfileImageKey, "");

    // Get Default Value From Prefs
    UserDetails.id = prefs.getInt(selfIdKey) ?? 0;
    UserDetails.userId = prefs.getInt(userIdKey) ?? 0;
    UserDetails.userName = prefs.getString(userNameKey) ?? "";
    UserDetails.userEmail = prefs.getString(userEmailKey) ?? "";
    UserDetails.userProfileImage = prefs.getString(userProfileImageKey) ?? "";
    UserDetails.userToken = prefs.getString(userTokenKey) ?? "";
    UserDetails.categoryId = prefs.getInt(roleId1Key) ?? 0;
    UserDetails.isUserLoggedIn = prefs.getBool(isUserLoggedInKey) ?? false;
    UserDetails.shopName = prefs.getString(shopNameKey) ?? "";
    UserDetails.shopProfile = prefs.getString(shopProfileImageKey) ?? "";
  }
}
