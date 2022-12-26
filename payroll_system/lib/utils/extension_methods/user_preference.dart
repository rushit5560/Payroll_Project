import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'user_details.dart';

class UserPreference {
  // user details keys
  static String isUserLoggedInKey = "isUserLoggedInKey";
  static String userIdKey = "userIdKey";
  static String roleIdKey = "roleIdKey";
  static String userNameKey = "userNameKey";
  static String userEmailKey = "userEmailKey";
  static String userProfileImageKey = "userProfileImageKey";

  // user permissions keys
  static String roleAddKey = 'roleAddKey';
  static String roleEditKey = 'roleEditKey';
  static String roleViewKey = 'roleViewKey';
  static String roleDeleteKey = 'roleDeleteKey';

  static String companyAddKey = 'companyAddKey';
  static String companyEditKey = 'companyEditKey';
  static String companyViewKey = 'companyviewKey';
  static String companyDeleteKey = 'companyDeleteKey';

  static String locationAddKey = 'locationAddKey';
  static String locationEditKey = 'locationEditKey';
  static String locationViewKey = 'locationViewKey';
  static String locationDeleteKey = 'locationDeleteKey';

  static String employeeAddKey = 'employeeAddKey';
  static String employeeEditKey = 'employeeEditKey';
  static String employeeViewKey = 'employeeViewKey';
  static String employeeDeleteKey = 'employeeDeleteKey';

  static String departmentAddKey = 'departmentAddKey';
  static String departmentEditKey = 'departmentEditKey';
  static String departmentViewKey = 'departmentViewKey';
  static String departmentDeleteKey = 'departmentDeleteKey';

  /// Set user permission commmon function
  Future<void> setUserPermissionsToPrefsAndLocal({
    // role perms
    bool? roleAdd,
    bool? roleEdit,
    bool? roleView,
    bool? roleDelete,
    // company perms
    bool? companyAdd,
    bool? companyEdit,
    bool? companyView,
    bool? companyDelete,
    // location perms
    bool? locationAdd,
    bool? locationEdit,
    bool? locationView,
    bool? locationDelete,
    // employee perms
    bool? employeeAdd,
    bool? employeeEdit,
    bool? employeeView,
    bool? employeeDelete,
    // department perms
    bool? departmentAdd,
    bool? departmentEdit,
    bool? departmentView,
    bool? departmentDelete,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    log('companyView Prefs: $companyView');

    // role perms set prefs
    prefs.setBool(roleAddKey, roleAdd ?? false);
    prefs.setBool(roleEditKey, roleEdit ?? false);
    prefs.setBool(roleViewKey, roleView ?? false);
    prefs.setBool(roleDeleteKey, roleDelete ?? false);
    // company perms set prefs
    prefs.setBool(companyAddKey, companyAdd ?? false);
    prefs.setBool(companyEditKey, companyEdit ?? false);
    prefs.setBool(companyViewKey, companyView ?? false);
    prefs.setBool(companyDeleteKey, companyDelete ?? false);
    // location perms set prefs
    prefs.setBool(locationAddKey, locationAdd ?? false);
    prefs.setBool(locationEditKey, locationEdit ?? false);
    prefs.setBool(locationViewKey, locationView ?? false);
    prefs.setBool(locationDeleteKey, locationDelete ?? false);
    // employee perms set prefs
    prefs.setBool(employeeAddKey, employeeAdd ?? false);
    prefs.setBool(employeeEditKey, employeeEdit ?? false);
    prefs.setBool(employeeViewKey, employeeView ?? false);
    prefs.setBool(employeeDeleteKey, employeeDelete ?? false);
    // department perms set prefs
    prefs.setBool(departmentAddKey, departmentAdd ?? false);
    prefs.setBool(departmentEditKey, departmentEdit ?? false);
    prefs.setBool(departmentViewKey, departmentView ?? false);
    prefs.setBool(departmentDeleteKey, departmentDelete ?? false);

    // role perms set locallly
    UserDetails.roleAdd = prefs.getBool(roleAddKey) ?? false;
    UserDetails.roleEdit = prefs.getBool(roleEditKey) ?? false;
    UserDetails.roleView = prefs.getBool(roleViewKey) ?? false;
    UserDetails.roleDelete = prefs.getBool(roleDeleteKey) ?? false;
    // company perms set locallly
    UserDetails.companyAdd = prefs.getBool(companyAddKey) ?? false;
    UserDetails.companyEdit = prefs.getBool(companyEditKey) ?? false;
    UserDetails.companyView = prefs.getBool(companyViewKey) ?? false;
    UserDetails.companyDelete = prefs.getBool(companyDeleteKey) ?? false;
    // location perms set locallly
    UserDetails.locationAdd = prefs.getBool(locationAddKey) ?? false;
    UserDetails.locationEdit = prefs.getBool(locationEditKey) ?? false;
    UserDetails.locationView = prefs.getBool(locationViewKey) ?? false;
    UserDetails.locationDelete = prefs.getBool(locationDeleteKey) ?? false;
    // employee perms set locallly
    UserDetails.employeeAdd = prefs.getBool(employeeAddKey) ?? false;
    UserDetails.employeeEdit = prefs.getBool(employeeEditKey) ?? false;
    UserDetails.employeeView = prefs.getBool(employeeViewKey) ?? false;
    UserDetails.employeeDelete = prefs.getBool(employeeDeleteKey) ?? false;
    // department perms set locallly
    UserDetails.departmentAdd = prefs.getBool(departmentAddKey) ?? false;
    UserDetails.departmentEdit = prefs.getBool(departmentEditKey) ?? false;
    UserDetails.departmentView = prefs.getBool(departmentViewKey) ?? false;
    UserDetails.departmentDelete = prefs.getBool(departmentDeleteKey) ?? false;

    log("UserDetails.roleAdd : ${UserDetails.roleAdd}");
    log("UserDetails.roleEdit : ${UserDetails.roleEdit}");
    log("UserDetails.roleView : ${UserDetails.roleView}");
    log("UserDetails.roleDelete : ${UserDetails.roleDelete}");

    log("UserDetails.companyAdd : ${UserDetails.companyAdd}");
    log("UserDetails.companyEdit : ${UserDetails.companyEdit}");
    log("UserDetails.companyView : ${UserDetails.companyView}");
    log("UserDetails.companyDelete : ${UserDetails.companyDelete}");

    log("UserDetails.locationAdd : ${UserDetails.locationAdd}");
    log("UserDetails.locationEdit : ${UserDetails.locationEdit}");
    log("UserDetails.locationView : ${UserDetails.locationView}");
    log("UserDetails.locationDelete : ${UserDetails.locationDelete}");

    log("UserDetails.employeeAdd : ${UserDetails.employeeAdd}");
    log("UserDetails.employeeEdit : ${UserDetails.employeeEdit}");
    log("UserDetails.employeeView : ${UserDetails.employeeView}");
    log("UserDetails.employeeDelete : ${UserDetails.employeeDelete}");

    log("UserDetails.departmentAdd : ${UserDetails.departmentAdd}");
    log("UserDetails.departmentEdit : ${UserDetails.departmentEdit}");
    log("UserDetails.departmentView : ${UserDetails.departmentView}");
    log("UserDetails.departmentDelete : ${UserDetails.departmentDelete}");
  }

  /// Set User Login Details
  Future<void> setUserLoginDetailsToPrefs({
    required bool isLoggedIn,
    required int userId,
    required int roleId,
    required String userName,
    required String userEmail,
    required String userProfileImage,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // user details save in th prefs
    prefs.setBool(isUserLoggedInKey, true);
    prefs.setInt(userIdKey, userId);
    prefs.setInt(roleIdKey, roleId);
    prefs.setString(userNameKey, userName);
    prefs.setString(userEmailKey, userEmail);
    prefs.setString(userProfileImageKey, userProfileImage);

    //  user details save in local vars
    UserDetails.isUserLoggedIn = prefs.getBool(isUserLoggedInKey) ?? false;
    UserDetails.userId = prefs.getInt(userIdKey) ?? 0;
    UserDetails.roleId = prefs.getInt(roleIdKey) ?? 0;
    UserDetails.userName = prefs.getString(userNameKey) ?? "";
    UserDetails.userEmail = prefs.getString(userEmailKey) ?? "";
    UserDetails.userProfileImage = prefs.getString(userProfileImageKey) ?? "";

    log("UserDetails.isUserLoggedIn : ${UserDetails.isUserLoggedIn}");
    log("UserDetails.userId : ${UserDetails.userId}");
    log("UserDetails.roleId : ${UserDetails.roleId}");
    log("UserDetails.userName : ${UserDetails.userName}");
    log("UserDetails.userEmail : ${UserDetails.userEmail}");
    log("UserDetails.userProfileImage : ${UserDetails.userProfileImage}");
  }

  /// Set User Login Details
  Future<void> getUserPrefsAndSaveToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //  user details save in local vars
    UserDetails.isUserLoggedIn = prefs.getBool(isUserLoggedInKey) ?? false;
    UserDetails.userId = prefs.getInt(userIdKey) ?? 0;
    UserDetails.roleId = prefs.getInt(roleIdKey) ?? 0;
    UserDetails.userName = prefs.getString(userNameKey) ?? "";
    UserDetails.userEmail = prefs.getString(userEmailKey) ?? "";
    UserDetails.userProfileImage = prefs.getString(userProfileImageKey) ?? "";

    log("UserDetails.isUserLoggedIn : ${UserDetails.isUserLoggedIn}");
    log("UserDetails.userId : ${UserDetails.userId}");
    log("UserDetails.roleId : ${UserDetails.roleId}");
    log("UserDetails.userName : ${UserDetails.userName}");
    log("UserDetails.userEmail : ${UserDetails.userEmail}");
    log("UserDetails.userProfileImage : ${UserDetails.userProfileImage}");

    // role perms set locallly
    UserDetails.roleAdd = prefs.getBool(roleAddKey) ?? false;
    UserDetails.roleEdit = prefs.getBool(roleEditKey) ?? false;
    UserDetails.roleView = prefs.getBool(roleViewKey) ?? false;
    UserDetails.roleDelete = prefs.getBool(roleDeleteKey) ?? false;
    // company perms set locallly
    UserDetails.companyAdd = prefs.getBool(companyAddKey) ?? false;
    UserDetails.companyEdit = prefs.getBool(companyEditKey) ?? false;
    UserDetails.companyView = prefs.getBool(companyViewKey) ?? false;
    UserDetails.companyDelete = prefs.getBool(companyDeleteKey) ?? false;
    // location perms set locallly
    UserDetails.locationAdd = prefs.getBool(locationAddKey) ?? false;
    UserDetails.locationEdit = prefs.getBool(locationEditKey) ?? false;
    UserDetails.locationView = prefs.getBool(locationViewKey) ?? false;
    UserDetails.locationDelete = prefs.getBool(locationDeleteKey) ?? false;
    // employee perms set locallly
    UserDetails.employeeAdd = prefs.getBool(employeeAddKey) ?? false;
    UserDetails.employeeEdit = prefs.getBool(employeeEditKey) ?? false;
    UserDetails.employeeView = prefs.getBool(employeeViewKey) ?? false;
    UserDetails.employeeDelete = prefs.getBool(employeeDeleteKey) ?? false;
    // department perms set locallly
    UserDetails.departmentAdd = prefs.getBool(departmentAddKey) ?? false;
    UserDetails.departmentEdit = prefs.getBool(departmentEditKey) ?? false;
    UserDetails.departmentView = prefs.getBool(departmentViewKey) ?? false;
    UserDetails.departmentDelete = prefs.getBool(departmentDeleteKey) ?? false;

    log("UserDetails.roleAdd : ${UserDetails.roleAdd}");
    log("UserDetails.roleEdit : ${UserDetails.roleEdit}");
    log("UserDetails.roleView : ${UserDetails.roleView}");
    log("UserDetails.roleDelete : ${UserDetails.roleDelete}");

    log("UserDetails.companyAdd : ${UserDetails.companyAdd}");
    log("UserDetails.companyEdit : ${UserDetails.companyEdit}");
    log("UserDetails.companyView : ${UserDetails.companyView}");
    log("UserDetails.companyDelete : ${UserDetails.companyDelete}");

    log("UserDetails.locationAdd : ${UserDetails.locationAdd}");
    log("UserDetails.locationEdit : ${UserDetails.locationEdit}");
    log("UserDetails.locationView : ${UserDetails.locationView}");
    log("UserDetails.locationDelete : ${UserDetails.locationDelete}");

    log("UserDetails.employeeAdd : ${UserDetails.employeeAdd}");
    log("UserDetails.employeeEdit : ${UserDetails.employeeEdit}");
    log("UserDetails.employeeView : ${UserDetails.employeeView}");
    log("UserDetails.employeeDelete : ${UserDetails.employeeDelete}");

    log("UserDetails.departmentAdd : ${UserDetails.departmentAdd}");
    log("UserDetails.departmentEdit : ${UserDetails.departmentEdit}");
    log("UserDetails.departmentView : ${UserDetails.departmentView}");
    log("UserDetails.departmentDelete : ${UserDetails.departmentDelete}");
  }

  /// Logout user from app
  Future<void> logoutRemoveUserDetailsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // user details delete in the prefs
    prefs.setBool(isUserLoggedInKey, false);
    prefs.setInt(userIdKey, 0);
    prefs.setInt(roleIdKey, 0);
    prefs.setString(userNameKey, "");
    prefs.setString(userEmailKey, "");
    prefs.setString(userProfileImageKey, "");

    // role perms set prefs
    prefs.setBool(roleAddKey, false);
    prefs.setBool(roleEditKey, false);
    prefs.setBool(roleViewKey, false);
    prefs.setBool(roleDeleteKey, false);
    // company perms set prefs
    prefs.setBool(companyAddKey, false);
    prefs.setBool(companyEditKey, false);
    prefs.setBool(companyViewKey, false);
    prefs.setBool(companyDeleteKey, false);
    // location perms set prefs
    prefs.setBool(locationAddKey, false);
    prefs.setBool(locationEditKey, false);
    prefs.setBool(locationViewKey, false);
    prefs.setBool(locationDeleteKey, false);
    // employee perms set prefs
    prefs.setBool(employeeAddKey, false);
    prefs.setBool(employeeEditKey, false);
    prefs.setBool(employeeViewKey, false);
    prefs.setBool(employeeDeleteKey, false);
    // department perms set prefs
    prefs.setBool(departmentAddKey, false);
    prefs.setBool(departmentEditKey, false);
    prefs.setBool(departmentViewKey, false);
    prefs.setBool(departmentDeleteKey, false);

    //removing from local
    UserDetails.isUserLoggedIn = false;
    UserDetails.userId = 0;
    UserDetails.roleId = 0;
    UserDetails.userName = "";
    UserDetails.userEmail = "";
    UserDetails.userProfileImage = "";

    // role perms set locallly
    UserDetails.roleAdd = false;
    UserDetails.roleEdit = false;
    UserDetails.roleView = false;
    UserDetails.roleDelete = false;
    // company perms set locallly
    UserDetails.companyAdd = false;
    UserDetails.companyEdit = false;
    UserDetails.companyView = false;
    UserDetails.companyDelete = false;
    // location perms set locallly
    UserDetails.locationAdd = false;
    UserDetails.locationEdit = false;
    UserDetails.locationView = false;
    UserDetails.locationDelete = false;
    // employee perms set locallly
    UserDetails.employeeAdd = false;
    UserDetails.employeeEdit = false;
    UserDetails.employeeView = false;
    UserDetails.employeeDelete = false;
    // department perms set locallly
    UserDetails.departmentAdd = false;
    UserDetails.departmentEdit = false;
    UserDetails.departmentView = false;
    UserDetails.departmentDelete = false;
    UserDetails.userProfileImage = "";

    log("UserDetails.isUserLoggedIn : ${UserDetails.isUserLoggedIn}");
    log("UserDetails.userId : ${UserDetails.userId}");
    log("UserDetails.roleId : ${UserDetails.roleId}");
    log("UserDetails.userName : ${UserDetails.userName}");
    log("UserDetails.userEmail : ${UserDetails.userEmail}");
    log("UserDetails.userProfileImage : ${UserDetails.userProfileImage}");

    log("UserDetails.roleAdd : ${UserDetails.roleAdd}");
    log("UserDetails.roleEdit : ${UserDetails.roleEdit}");
    log("UserDetails.roleView : ${UserDetails.roleView}");
    log("UserDetails.roleDelete : ${UserDetails.roleDelete}");

    log("UserDetails.companyAdd : ${UserDetails.companyAdd}");
    log("UserDetails.companyEdit : ${UserDetails.companyEdit}");
    log("UserDetails.companyView : ${UserDetails.companyView}");
    log("UserDetails.companyDelete : ${UserDetails.companyDelete}");

    log("UserDetails.locationAdd : ${UserDetails.locationAdd}");
    log("UserDetails.locationEdit : ${UserDetails.locationEdit}");
    log("UserDetails.locationView : ${UserDetails.locationView}");
    log("UserDetails.locationDelete : ${UserDetails.locationDelete}");

    log("UserDetails.employeeAdd : ${UserDetails.employeeAdd}");
    log("UserDetails.employeeEdit : ${UserDetails.employeeEdit}");
    log("UserDetails.employeeView : ${UserDetails.employeeView}");
    log("UserDetails.employeeDelete : ${UserDetails.employeeDelete}");

    log("UserDetails.departmentAdd : ${UserDetails.departmentAdd}");
    log("UserDetails.departmentEdit : ${UserDetails.departmentEdit}");
    log("UserDetails.departmentView : ${UserDetails.departmentView}");
    log("UserDetails.departmentDelete : ${UserDetails.departmentDelete}");
  }
}
