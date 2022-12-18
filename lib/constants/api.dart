
class Api {
  static const String schoolDomain = 'https://samuelinstitution.com'; ///Put here the domain
  static const  bool isDevelopmentModeOn = false;
  static const  bool isDemoModeOn = false;
  static const  bool askUrlFromUser = false;
  static const  String clientService = "vtechschool";
  static const  String authKey = "schoolAdmin@";
  static const  String appKey = "schoolAdmin@1234";
  static const  String contentType = "application/json";
  static const  String domain = "$schoolDomain/wp-json/";
 //*
  // a:3:{i:0;s:22:"manage_study_materials";i:1;s:15:
  // "manage_homework";i:2;s:19:
  // "manage_live_classes";}*//
 //student api
  static const  String fcm_subscribe = "pd/fcm/subscribe";
  static const  String fcm_unsubscribe = "pd/fcm/unsubscribe";
  static const  String loginUrl = "jwt-auth/v1/token";
  static const  String getSettingsUrl = "sm/global/settings";
  static const  String getStudentProfileUrl = "sm/student/profile";
  static const  String getHomeworkUrl = "sm/student/homework";
  static const  String getEventUrl = "sm/student/events";
  static const  String getStudyMaterialUrl = "sm/student/study-materials";
  static const  String getFeesUrl = "sm/student/fee-invoices";
  static const  String getClassScheduleUrl = "sm/student/class-time-table";
  static const  String getLiveClassesUrl = "sm/student/live-classes";
  static const  String getExamScheduleListUrl = "sm/student/exam-time-table";
  static const  String getExamResultListUrl = "sm/student/exam-results";
  static const  String getAdmitCardListUrl= "sm/student/admit-cards";
  static const  String getNotificationsUrl = "sm/student/noticeboard";
  static const  String getPaymentHistoryUrl="sm/student/payments";
  static const  String getAttendanceUrl = "sm/student/attendance";
  static const  String getQuizCategoryUrl = "sm/student/quiz-categories";
  static const  String getQuizUrl = "sm/student/quizes";
  static const  String getSubjectListUrl = "sm/student/subjects";
  static const  String getExamUrl = "$schoolDomain/take-exam/?id=";


  static const  String logoutUrl = "logout";
  static const  String getDashboardUrl = "sm/student/dashboard";
  static const  String getParentUrl = "sm/parent/students/";
  static const  String submitHomeworkUrl = "sm/student/submit-homework";
  static const  String submitLeaveRequestUrl = "sm/student/submit-leave-request";
  static const  String getLeaveRequestUrl = "sm/student/leave-requests";
  static const  String getLibraryBookIssuedListUrl = "sm/student/books-issued";
  static const  String parent_getStudentList = "sm/parent/students";
  static const  String privacyPolicyUrl = "privacy-policy.html";
  static const  String downloadDirectory = "VtechSchool";
  static const  String defaultSecondaryColour = "#daf6fc";
  static const  String defaultPrimaryColour = "#2e4b5f";
  //staff api
  static const  String getStaffProfileUrl = "sm/staff/profile";
  static const  String getStaffStudyMaterialUrl = "sm/staff/study-materials";
  static const  String uploadStaffStudyMaterialUrl = 'sm/staff/upload_study_material';
  static const  String getStaffHomework = 'sm/staff/homework-read';
  static const  String uploadStaffHomework = 'sm/staff/homework-add';
  static const  String StaffHomeworkAttachments = 'sm/staff/homework-attachments';
  static const  String staffAboutSchool = 'sm/staff/about-school';
  static const  String classes = 'sm/staff/classes';
  static const  String sections = 'sm/staff/sections';
  static const  String subjects = 'sm/staff/subjects';
  static const  String multiSectionHomeWorkUpload = 'sm/staff/upload_homework_multi_section';
  static const  String staffHomeWorkSubmission = 'sm/staff/homework-submissions';
  static const  String multiSectionStudyMaterialUpload = 'sm/staff/upload_study_material_multi_section';
  static const  String staffAttendanceRead = 'sm/staff/attendancestaffquery';
  static const  String staffGetStudents = 'sm/staff/students_staff_query';
  static const  String submitAttendance = 'sm/staff/submit_attendance';
  static const  String staffLiveClass = 'sm/staff/live_classes';
  static const  String staffLeaveRequests = 'sm/staff/leave_request';
  static const  String staffApproveLeave = 'sm/staff/approve_request';
  static const  String staffEvents = 'sm/staff/events';
  static const  String staffResults = 'sm/staff/results';
  static const  String staffAttendance = 'sm/staff/staff_attendance';
  static const  String staffUpdateAttendance = 'sm/staff/staff_update_attendance';

  //SHARED PREFERENCE KEYS
  static const  String primaryColour = "primaryColour";
  static const  String secondaryColour = "secondaryColour";
  static const  String appLogo = "appLogo";
  static const  String apiUrl = "apiUrl";
  static const  String imagesUrl = "imagesUrl";
  static const  String classSection = "classSection";
  static const  String currency = "currencySymbol";
  static const  String classId = "classId";
  static const  String sectionId = "sectionId";
  static const  String studentId = "studentId";
  static const  String userId = "userId";
  static const  String permissionStatus = "permissionStatus";
  static const  String userName = "userName";
  static const  String userImage = "userImage";
  static const  String loginType = "role";
  static const  String modulesArray = "modulesArray";
  static const  String isLoggegIn = "isLoggegIn";
  static const  String showPaymentBtn = "showPaymentBtn";
  static const  String langCode = "langCode";
  static const  String appDomain = "appDomain";
  static const  String isLocaleSet = "isLocaleSet";
  static const  String currentLocale = "currentLocale"; }