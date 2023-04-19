// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_function_literals_in_foreach_calls, depend_on_referenced_packages

import 'dart:developer';

import 'package:dermaclinic_patients_fyp_20048674/components/menuOptions.dart';
import 'package:dermaclinic_patients_fyp_20048674/routes/book.dart';
import 'package:dermaclinic_patients_fyp_20048674/routes/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/appointmentCard.dart';
import '../models.dart/doctors.dart';
import '../utils/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = "";
  List<AppointmentCard> appointments = [];
  late bool isDoctor = false;
  @override
  void initState() {
    super.initState();
    initialFetch();
  }

  Future<void> initialFetch() async {
    await fetchFirstName();
    await fetchAcceptedAppointments();
  }

  Future<void> fetchFirstName() async {
    // final user = SharedPrefrence().getUserId();
    final user = await Services.getCurrentUser();
    log('Current User:${user.first.email}');
    var shared = await SharedPreferences.getInstance();

    shared.setString("id", user.first.id!);
    setState(() {
      firstName = user.first.firstName!;
      isDoctor = user.first.role == "doctor";
      log('is doctor:$isDoctor');
    });
  }

//as
  Future<void> fetchAcceptedAppointments() async {
    if (!isDoctor) {
      final acceptedAppointments =
          await Services.getAcceptedAppointmentsForPatient();
      List<AppointmentCard> appointmentList = [];
      List<Doctor> doctor = [];
      for (var appointment in acceptedAppointments) {
        List<String> dateArray = appointment.date!.split("-");
        DateTime date = DateTime(
          int.parse(dateArray[0]),
          int.parse(dateArray[1]),
          int.parse(dateArray[2]),
        );
        String dateFormatted = DateFormat('EEEE, d MMMM').format(date);
        doctor = await Services.getPatientById(appointment.doctorid!);
        appointmentList.add(AppointmentCard(
          doctorName: "Dr. ${doctor.first.firstName} ${doctor.first.lastName}",
          appoinmentDate: dateFormatted,
          appointmentTime: appointment.time!,
          description: appointment.description!,
          appointmentStatus: appointment.status!,
          isDoctor: false,
          appointmentId: appointment.appointmentid!,
        ));
      }
      setState(() {
        appointments = appointmentList;
      });
    } else {
      final acceptedAppointments = await Services.getAcceptedAppointments();
      List<AppointmentCard> appointmentList = [];
      List<Doctor> doctor = [];
      for (var appointment in acceptedAppointments) {
        List<String> dateArray = appointment.date!.split("-");
        DateTime date = DateTime(
          int.parse(dateArray[0]),
          int.parse(dateArray[1]),
          int.parse(dateArray[2]),
        );
        String dateFormatted = DateFormat('EEEE, d MMMM').format(date);
        doctor = await Services.getPatientById(appointment.patientid!);
        appointmentList.add(AppointmentCard(
          doctorName: " ${doctor.first.firstName} ${doctor.first.lastName}",
          appoinmentDate: dateFormatted,
          appointmentTime: appointment.time!,
          description: appointment.description!,
          appointmentStatus: appointment.status!,
          isDoctor: false,
          appointmentId: appointment.appointmentid!,
        ));
      }
      setState(() {
        appointments = appointmentList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: !isDoctor
          ? BottomNavigationBar(
              onTap: (value) async {
                if (value == 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return BookPage();
                    },
                  ));
                }
              },
              showUnselectedLabels: false,
              showSelectedLabels: false,
              elevation: 0,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      size: 35.0,
                      Icons.home_sharp,
                      color: Color(0xff8696BB),
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      size: 35.0,
                      Icons.add_box_rounded,
                      color: Color(0xff8696BB),
                    ),
                    label: "Book"),
                BottomNavigationBarItem(
                    icon: Icon(
                      size: 35.0,
                      Icons.shopping_cart_checkout_outlined,
                      color: Color(0xff8696BB),
                    ),
                    label: "Profile"),
              ],
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                //Hello, Hi James column
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          " $firstName",
                          style: Theme.of(context).textTheme.headline1,
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User signed out.')),
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ));
                      },
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Image(
                          image: AssetImage("images/logo.png"),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                !isDoctor
                    ? MenuOption(
                        menuTitle: "Accepted Appointments",
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                final acceptedAppointments =
                                    await Services.getAcceptedAppointments();
                                List<AppointmentCard> appointmentList = [];
                                List<Doctor> patient = [];

                                for (var appointment in acceptedAppointments) {
                                  List<String> dateArray =
                                      appointment.date!.split("-");
                                  DateTime date = DateTime(
                                    int.parse(dateArray[0]),
                                    int.parse(dateArray[1]),
                                    int.parse(dateArray[2]),
                                  );
                                  String dateFormatted =
                                      DateFormat('EEEE, d MMMM').format(date);
                                  patient = await Services.getPatientById(
                                      appointment.patientid!);
                                  appointmentList.add(AppointmentCard(
                                    doctorName:
                                        "${patient.first.firstName} ${patient.first.lastName}",
                                    appoinmentDate: dateFormatted,
                                    appointmentTime: appointment.time!,
                                    description: appointment.description!,
                                    appointmentStatus: appointment.status!,
                                    isDoctor: isDoctor,
                                    appointmentId: appointment.appointmentid!,
                                  ));
                                }
                                setState(() {
                                  appointments = appointmentList;
                                });
                              },
                              child: MenuOption(
                                menuTitle: "Accepted Appointments",
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                final pendingAppointments = await Services
                                    .getPendingAppointmentsForDoctor();
                                List<AppointmentCard> appointmentList = [];
                                List<Doctor> patient = [];

                                for (var appointment in pendingAppointments) {
                                  List<String> dateArray =
                                      appointment.date!.split("-");
                                  DateTime date = DateTime(
                                    int.parse(dateArray[0]),
                                    int.parse(dateArray[1]),
                                    int.parse(dateArray[2]),
                                  );
                                  String dateFormatted =
                                      DateFormat('EEEE, d MMMM').format(date);
                                  patient = (await Services.getPatientById(
                                      appointment.patientid!));
                                  appointmentList.add(AppointmentCard(
                                    doctorName:
                                        "${patient.first.firstName} ${patient.first.lastName}",
                                    appoinmentDate: dateFormatted,
                                    appointmentTime: appointment.time!,
                                    description: appointment.description!,
                                    appointmentStatus: appointment.status!,
                                    isDoctor: isDoctor,
                                    appointmentId: appointment.appointmentid!,
                                  ));
                                }
                                setState(() {
                                  appointments = appointmentList;
                                });
                              },
                              child: MenuOption(
                                menuTitle: "Pending Appointments",
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                final rejectedAppointments =
                                    await Services.getrejectedAppointments();
                                List<AppointmentCard> appointmentList = [];
                                List<Doctor> patient = [];

                                for (var appointment in rejectedAppointments) {
                                  List<String> dateArray =
                                      appointment.date!.split("-");
                                  DateTime date = DateTime(
                                    int.parse(dateArray[0]),
                                    int.parse(dateArray[1]),
                                    int.parse(dateArray[2]),
                                  );
                                  String dateFormatted =
                                      DateFormat('EEEE, d MMMM').format(date);
                                  patient = await Services.getPatientById(
                                      appointment.patientid!);
                                  appointmentList.add(AppointmentCard(
                                    doctorName:
                                        "${patient.first.firstName} ${patient.first.lastName}",
                                    appoinmentDate: dateFormatted,
                                    appointmentTime: appointment.time!,
                                    description: appointment.description!,
                                    appointmentStatus: appointment.status!,
                                    isDoctor: isDoctor,
                                    appointmentId: appointment.appointmentid!,
                                  ));
                                }
                                setState(() {
                                  appointments = appointmentList;
                                });
                              },
                              child: MenuOption(
                                menuTitle: "Rejected Appointments",
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 24,
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: appointments,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
