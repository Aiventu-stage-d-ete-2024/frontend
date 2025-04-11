import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/drawer_widget.dart';
import '../baseUrl.dart';
import 'mr_details.dart'; 

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<dynamic> _maintenanceRequests = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchMaintenanceRequests(_selectedDay!);
  }

  Future<void> _fetchMaintenanceRequests(DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final url = Uri.parse('${baseUrl}maintenancerequests/date/$formattedDate');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _maintenanceRequests = data['maintenanceRequests'];
        });
      } else {
        print('Failed to load maintenance requests');
      }
    } catch (e) {
      print('Error fetching maintenance requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        _fetchMaintenanceRequests(selectedDay);
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: const Color(0xFF3665DB), width: 2.0),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xFF3665DB),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                      todayTextStyle: const TextStyle(color: Color(0xFF3665DB)),
                      weekendTextStyle: const TextStyle(color: Color(0xFF3665DB)),
                      outsideTextStyle: const TextStyle(color: Colors.grey),
                      outsideDaysVisible: false,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Maintenance Requests on ${DateFormat('MMMM dd, yyyy').format(_selectedDay!)}',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  _maintenanceRequests.isEmpty
                      ? const Text('No maintenance requests for this day.')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _maintenanceRequests.length,
                          itemBuilder: (context, index) {
                            final request = _maintenanceRequests[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MRDetailsPage(
                                      RequestID: request['RequestID'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text('Request ID: ${request['RequestID']}'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Request Type: ${request['RequestType']}'),
                                      Text('Asset: ${request['Asset']}'),
                                      Text('Functional Location: ${request['FunctionalLocation']}'),
                                      Text('Current Lifecycle State: ${request['CurrentLifecycleState']}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
