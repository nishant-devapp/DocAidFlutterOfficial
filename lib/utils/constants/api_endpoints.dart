class ApiEndpoints {

  static const String homeGetEndPoint = "/home/get";

  // Dashboard

  // Clinics
  static const String addNewClinicEndPoint = '/clinic/add';
  static const String updateClinicEndPoint = '/clinic/update';

  // Appointments
  static const String fetchAllAppointmentsEndPoint = "/clinic/ClincsToAppointment";
  static const String fetchClinicAppointmentEndPoint = '/clinic/betweenDate';
  static const String updateAppointmentVisitStatusEndPoint = '/appointment/setAppointmentVisitStatus';
  static const String bookAppointmentEndPoint = '/appointment/book1';
  static const String updateAppointmentEndPoint = '/appointment/update';
  static const String getAppointmentPaymentEndPoint = '/payment/getAppointmentPayment';
  static const String createAppointmentPaymentEndPoint = '/payment/createAppointmentPayment';
  static const String updateAppointmentPaymentEndPoint = '/payment/updateAppointmentPayment';
  static const String unpayAppointmentEndPoint = '/payment/appointmentUnpaid/';

  static const String fetchPrescriptionEndPoint = '/prescriptionUpload/getImage';
  static const String uploadPrescriptionEndPoint = '/prescriptionUpload';

  static const String patientInfoByAbhaEndPoint = '/appointment/getByAbhaNumber';
  static const String patientInfoByContactEndPoint = '/appointment/getByContactNumber';


  // Accounts
  static const String totalVisitEndPoint = '/clinic/countTotal';
  static const String totalEarningEndPoint = '/home/doctorTotalIncome';

  // Help
  static const String sendHelpMsgEndPoint = '/feedback';



}
