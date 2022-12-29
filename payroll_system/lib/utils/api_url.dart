class ApiUrl {
  static const apiMainPath = "https://payroll.omdemo.co.in/";
  static const apiImagePath =
      "https://payroll.omdemo.co.in/public/images/employee/";

  static const registerApi = "${apiMainPath}api/register";
  static const loginApi = "${apiMainPath}api/login";
  static const forgetPasswordApi = "${apiMainPath}api/forgetpassword";
  static const changePasswordApi = "${apiMainPath}api/change/password";

  static const getPermissionApi = "${apiMainPath}api/getpermission/";
  // static const allDepartmentApi = "${apiMainPath}api/department";

  // profile api urls
  static const profileGetApi = "${apiMainPath}api/profile";
  static const adminProfileUpdateApi = "${apiMainPath}api/profile/update";
  static const subAdminProfileUpdateApi = "${apiMainPath}api/profile/subupdate";
  static const companyProfileUpdateApi =
      "${apiMainPath}api/profile/companyupdate";
  static const employeeProfileGetApi =
      "${apiMainPath}api/profile/employeegetdata/";
  static const employeeProfileUpdateApi =
      "${apiMainPath}api/profile/employeeupdate";

  // Employee Api's
  static const allEmployeeApi = "${apiMainPath}api/employee";
  static const createEmployeeApi = "${apiMainPath}api/employee/store";
  static const deleteEmployeeApi = "${apiMainPath}api/employee/delete/";
  static const getEmployeeDetailsApi = "${apiMainPath}api/employee/edit/";
  static const updateEmployeeDetailsApi = "${apiMainPath}api/employee/update";
  static const getCompanyWiseEmployeeApi =
      "${apiMainPath}api/employee/companywiseeomployee/";

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
  static const updateDepartmentApi = "${apiMainPath}api/department/update";
  static const getDepartmentDetailsApi = "${apiMainPath}api/department/edit/";

  static const getCompanyDepartmentApi =
      "${apiMainPath}api/company/getdepartment";

//Location Api's
  static const allLocationApi = "${apiMainPath}api/location";
  static const deleteLocationApi = "${apiMainPath}api/location/delete/";
  static const getLocationApi = "${apiMainPath}api/location/edit/";
  static const createLocationApi = "${apiMainPath}api/location/store";
  static const updateLocationApi = "${apiMainPath}api/location/update";

}
