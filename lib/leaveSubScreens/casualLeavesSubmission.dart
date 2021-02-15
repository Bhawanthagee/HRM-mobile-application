
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/custom%20items/customButton.dart';
import 'package:login_ui/leave_events/casual_leave_event.dart';
import 'package:login_ui/screans/casualLeaveListPage.dart';
import 'package:table_calendar/table_calendar.dart';

class CasualLeavesSubmission extends StatefulWidget {
  @override
  _CasualLeavesSubmissionState createState() => _CasualLeavesSubmissionState();
}


class _CasualLeavesSubmissionState extends State<CasualLeavesSubmission> {
  CalendarController _calendarController = CalendarController();
 // final _fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Container(
                        child:Text("Select Date",
                        style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600, color: Colors.black),) ,
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(8.0),
                        child: TableCalendar(
                          calendarController: _calendarController,
                          headerStyle: HeaderStyle(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent
                            ),
                            headerMargin: const EdgeInsets.only(bottom: 8.0),
                            titleTextStyle: TextStyle(color: Colors.white),
                            formatButtonDecoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            formatButtonTextStyle: TextStyle(color: Colors.white),
                            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
                              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,)
                          ),
                          calendarStyle: CalendarStyle(),
                          builders: CalendarBuilders(),
                        ),
                    ),
                    SizedBox(height: 50,),
                    CustomButton(
                      text: "View Leave Details",
                      outlineBtn: true,
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder:(context)=>CasualLeaveListPage()));

                      },
                    ),
                  ],
                ),
                
                
              ),


            ],
          ),

        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>CasualLeaveEvent(selectedDate:_calendarController.selectedDay ,)));
          },
        icon:  Icon(Icons.send),
        label: Text('Apply Leave'),

      ),


    );
  }
}
