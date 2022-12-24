class ApiUrl {
  static const apiMainPath = "https://payroll.omdemo.co.in/";

  static const registerApi = "${apiMainPath}api/register";
  static const loginApi = "${apiMainPath}api/login";

  static const getPermissionApi = "${apiMainPath}api/getpermission/";
  // static const allDepartmentApi = "${apiMainPath}api/department";

  static const profileGetApi = "${apiMainPath}api/profile";
  static const profileUpdateApi = "${apiMainPath}api/profileupdate";

  // Employee Api's
  static const allEmployeeApi = "${apiMainPath}api/employee";
  static const createEmployeeApi = "${apiMainPath}api/employee/store";
  static const deleteEmployeeApi = "${apiMainPath}api/employee/delete/";
  static const getEmployeeDetailsApi = "${apiMainPath}api/employee/edit/";

  // Company Api's
  static const allCompanyApi = "${apiMainPath}api/company";
  static const createCompanyApi = "${apiMainPath}api/company/store";
  static const deleteCompanyApi = "${apiMainPath}api/company/delete/";
  static const getCompanyDetailsApi = "${apiMainPath}api/company/edit/";
  static const updateCompanyDetailsApi = "${apiMainPath}api/company/update";
  // static const activeCompanyApi = "${apiMainPath}api/company/active/";

  // Department Api's
  static const allDepartmentApi = "${apiMainPath}api/department";
  static const createDepartmentApi = "${apiMainPath}api/department/store";
  static const deleteDepartmentApi = "${apiMainPath}api/department/delete/";
  static const updateDepartmentApi = "${apiMainPath}api/department/update/";
  // static const getDepartmentDetailsApi = "${apiMainPath}api/department/edit/";



}
