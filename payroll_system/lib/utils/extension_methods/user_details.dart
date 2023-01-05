class UserDetails {
  // user details save in local variables
  static bool isUserLoggedIn = false;
  static int userId = 0;
  static int roleId = 0;
  static int companyId = 0;

  static String userName = '';
  static String userEmail = '';
  static String userProfileImage = '';
  // static String userToken = '';

  // user permissions save in local variables
  static bool roleAdd = false;
  static bool roleEdit = false;
  static bool roleView = false;
  static bool roleDelete = false;

  static bool companyAdd = false;
  static bool companyEdit = false;
  static bool companyView = false;
  static bool companyDelete = false;

  static bool locationAdd = false;
  static bool locationEdit = false;
  static bool locationView = false;
  static bool locationDelete = false;

  static bool employeeAdd = false;
  static bool employeeEdit = false;
  static bool employeeView = false;
  static bool employeeDelete = false;

  static bool departmentAdd = false;
  static bool departmentEdit = false;
  static bool departmentView = false;
  static bool departmentDelete = false;
}
