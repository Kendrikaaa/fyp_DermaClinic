class Appointment {
  String? appointmentid;
  String? doctorid;
  String? patientid;
  String? date;
  String? time;
  String? description;
  String? status;

  Appointment(
      {this.appointmentid,
      this.doctorid,
      this.patientid,
      this.date,
      this.time,
      this.description,
      this.status});

  Appointment.fromJson(Map<String, dynamic> json) {
    appointmentid = json['appointmentid'];
    doctorid = json['doctorid'];
    patientid = json['patientid'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentid'] = appointmentid;
    data['doctorid'] = doctorid;
    data['patientid'] = patientid;
    data['date'] = date;
    data['time'] = time;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}
