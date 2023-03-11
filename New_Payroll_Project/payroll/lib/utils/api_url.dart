class ApiUrl {
  // static const apiMainPath = "https://appieve.com/";
  // static const apiImagePath = "https://appieve.com/public/images/employee/";
  // static const downloadFilePath = "https://appieve.com/public/images/employee/file/";

  // static const apiMainPath = "https://kpatelcpa.us/";
  // static const apiImagePath = "https://kpatelcpa.us/public/images/employee/";
  // static const downloadFilePath = "https://kpatelcpa.us/public/images/employee/file/";

  static const apiMainPath = "https://payroll.omdemo.co.in/";
  static const apiImagePath =
      "https://payroll.omdemo.co.in/public/images/employee/";
  static const downloadFilePath =
      "https://payroll.omdemo.co.in/public/images/employee/file/";

  static const registerApi = "${apiMainPath}api/register";
  static const loginApi = "${apiMainPath}api/login";
  // static const forgetPasswordApi = "${apiMainPath}api/forgetpassword";
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

  // Employee Api
  static const allEmployeeApi = "${apiMainPath}api/admin/employee/";
  static const payCheckWiseEmployeeApi =
      "${apiMainPath}api/admin/paycheckwiseemployee";
  static const createEmployeeApi = "${apiMainPath}api/admin/employee/store";
  static const deleteEmployeeApi = "${apiMainPath}api/admin/employee/delete/";
  static const getEmployeeDetailsApi = "${apiMainPath}api/admin/employee/edit/";
  static const updateEmployeeDetailsApi =
      "${apiMainPath}api/admin/employee/update";
  static const getCompanyWiseEmployeeApi = "${apiMainPath}api/admin/employee/";
  static const getEmployeeDocumentApi =
      "${apiMainPath}api/admin/employee/docget/";
  static const uploadEmployeeDocumentApi =
      "${apiMainPath}api/admin/employee/docuploadstore";
  static const deleteEmployeeDocumentApi =
      "${apiMainPath}api/admin/employee/docdel/";
  static const payCheckesDowanloadDocumentApi =
      "${apiMainPath}api/admin/employeewisepayroll/";

  // Company Api
  static const allCompanyApi = "${apiMainPath}api/admin/company";
  static const createCompanyApi = "${apiMainPath}api/admin/company/store";
  static const deleteCompanyApi = "${apiMainPath}api/admin/company/delete/";
  static const getCompanyDetailsApi = "${apiMainPath}api/admin/company/edit/";
  static const updateCompanyDetailsApi =
      "${apiMainPath}api/admin/company/update";
  static const getSubAdminWiseCompanyApi =
      "${apiMainPath}api/subadmin/company/";
  // static const activeCompanyApi = "${apiMainPath}api/company/active/";

  // Department Api
  static const allDepartmentApi = "${apiMainPath}api/admin/department";
  static const createDepartmentApi = "${apiMainPath}api/admin/department/store";
  static const deleteDepartmentApi =
      "${apiMainPath}api/admin/department/delete/";
  static const updateDepartmentApi =
      "${apiMainPath}api/admin/department/update";
  static const getDepartmentDetailsApi =
      "${apiMainPath}api/admin/department/edit/";
  static const getCompanyDepartmentApi = "${apiMainPath}api/admin/department/";

//Location Api
  static const allLocationApi = "${apiMainPath}api/admin/location";
  static const companyWiseLocationApi = "${apiMainPath}api/admin/location/";
  static const deleteLocationApi = "${apiMainPath}api/admin/location/delete/";
  static const getLocationApi = "${apiMainPath}api/admin/location/edit/";
  static const createLocationApi = "${apiMainPath}api/admin/location/store";
  static const updateLocationApi = "${apiMainPath}api/admin/location/update";

//Payroll Api
  static const getPayCheckesListApi = "${apiMainPath}api/admin/payroll/list";
  static const getSalaryPayChecksListApi = "${apiMainPath}api/admin/paychecks/";
  static const createPayCheckesApi = "${apiMainPath}api/admin/payroll/store";
  static const createSalaryPayChecksApi =
      "${apiMainPath}api/admin/paycheck/store";

  //approve paychecks Api
  static const getApprovePayCheckesListApi =
      "${apiMainPath}api/admin/payrollapprove/";
  static const getApprovePayChecksListApi = "${apiMainPath}api/admin/payroll/";
  static const deleteApprovePayCheckesListApi =
      "${apiMainPath}api/admin/approvedelete/";

  static const payrollapproveApi = "${apiMainPath}api/admin/payrollapprove/";
  static const downloadPayrollApi = "${apiMainPath}api/admin/payrolldownload/";

//subadmin
  static const allSubAdminApi = "${apiMainPath}api/admin/subadmin";
  static const getSubAdminApi = "${apiMainPath}api/admin/subadmin/edit/";
  static const updateSubAdminApi = "${apiMainPath}api/admin/subadmin/update";

//permission api
  static const savePermissionApi = "${apiMainPath}api/admin/permissionadd";

  //GeneralSettings Api
  static const getDateFormatApi = "${apiMainPath}api/admin/dateformate";
  static const updateDateFormatApi =
      "${apiMainPath}api/admin/dateformateupdate";
}
