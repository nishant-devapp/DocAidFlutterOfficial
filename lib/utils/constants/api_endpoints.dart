class ApiEndpoints {

  static const String homeGetEndPoint = "/home/get";
  static const String updateProfileEndPoint = "/home/updateDoctor";
  static const String addDoctorImageEndPoint = "/image";
  static const String updateDoctorImageEndPoint = "/image/update";
  static const String fetchDoctorImageEndPoint = "/image/getImage";

  // Dashboard
  static const String addScheduleEndpoint = '/inter/add';
  static const String updateScheduleEndpoint = '/inter/update';
  static const String deleteScheduleEndpoint = '/inter/delete';

  // Clinics
  static const String addNewClinicEndPoint = '/clinic/add';
  static const String updateClinicEndPoint = '/clinic/update';
  static const String deleteClinicEndPoint = '/clinic/delete';
  static const String additionalClinicPaymentEndPoint = '/subscriptionAmount/additionalClinic';
  static const String uploadClinicPrescriptionImageEndPoint = '/clinicImage/upload';
  static const String fetchClinicPrescriptionImageEndPoint = '/clinicImage/getImage';

  // Appointments
  static const String fetchAllAppointmentsEndPoint = "/clinic/ClincsToAppointment";
  static const String fetchClinicAppointmentEndPoint = '/clinic/betweenDate';
  static const String updateAppointmentVisitStatusEndPoint = '/appointment/setAppointmentVisitStatus';
  static const String bookAppointmentEndPoint = '/appointment/book1';
  static const String updateAppointmentEndPoint = '/appointment/update';
  static const String deleteAppointmentEndPoint = '/clinic/deleteAppointment';
  static const String getAppointmentPaymentEndPoint = '/payment/getAppointmentPayment';
  static const String createAppointmentPaymentEndPoint = '/payment/createAppointmentPayment';
  static const String appointmentPaidEndPoint = '/payment/appointmentPaid';
  static const String appointmentUnpaidEndPoint = '/payment/appointmentUnpaid';
  static const String updateAppointmentPaymentEndPoint = '/payment/updateAppointmentPayment';
  static const String unpayAppointmentEndPoint = '/payment/deleteAppointmentPayment';

  static const String fetchPrescriptionEndPoint = '/prescriptionUpload/getImage';
  static const String uploadPrescriptionEndPoint = '/prescriptionUpload';

  static const String patientInfoByAbhaEndPoint = '/appointment/getByAbhaNumber';
  static const String patientInfoByContactEndPoint = '/appointment/getByContactNumber';

  static const String calendarAppointmentCountEndPoint = '/clinic/appointmentsCountByDate';
  static const String clinicWiseAppointmentCountEndPoint = '/clinic/totalAppointOfEachClinicOfDoctor';

  // New APIs v-2.0
  static const String fetchPatientListByAbhaEndPoint = '/patient/getByAbhaNumber';
  static const String fetchPatientsListByContactEndPoint = '/patient/getByContact';
  static const String createPatientEndPoint = '/patient/create';
  static const String addNewPatientEndPoint = '/patient/update';


  // Accounts
  static const String totalVisitEndPoint = '/clinic/totalAppointOfDoctor';
  static const String totalEarningEndPoint = '/home/doctorTotalIncome';
  static const String endDateEndPoint = '/currentSubscription/currentSubscriptionEndDate';
  static const String getTotalAmountEndPoint = '/subscriptionAmount/renew';
  static const String getSubscriptionOrderIdEndPoint = '/subscription/createOrder';
  static const String getPaymentVerificationEndPoint = '/subscription/fetchDetailsByPaymentId';
  static const String updatingNewEndDateEndPoint = '/currentSubscription/updateCurrentSubscriptionDetails';
  static const String createPaymentHistoryEndPoint = '/subscriptionPaymentHistory/create';
  static const String fetchSubscriptionHistoryEndPoint = '/subscriptionPaymentHistory/allSubscriptionPaymentHistory';
  static const String fetchWeeklyGraphByClinicIdEndPoint = '/payment/weeklyGraphByClinicId';
  static const String fetchYearlyGraphByClinicIdEndPoint = '/payment/yearlyGraphByClinicId';
  static const String fetchCustomGraphByClinicIdEndPoint = '/payment/customGraphByClinicId';

  // Help
  static const String sendHelpMsgEndPoint = '/feedback';

}