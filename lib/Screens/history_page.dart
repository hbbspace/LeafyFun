import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:leafyfun/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  

  const HistoryPage({super.key,});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> scanHistory = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadUserInfo();
    final userId = userProvider.userId;
    final response = await http.get(
      Uri.parse('${dotenv.env['ENDPOINT_URL']}/history/$userId'),
      headers: {
        'ngrok-skip-browser-warning': 'true', // Menghindari halaman warning
      },
    );
  
    try {
      if (response.statusCode == 200) {
        final List<dynamic> history = json.decode(response.body); // Langsung decode ke list
        setState(() {
          scanHistory = history.map((item) {
            return {
              'date': item['scan_date'],
              'plantName': item['plant_name'],
              'accuracy': item['accuracy'],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load history: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
        child: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/images/ArrowLeftBlack.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'History',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Center(
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
              else if (scanHistory.isEmpty)
                Center(
                  child: Text(
                    'No history available.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Date',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Plant Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Accuracy',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 1.5,
                    ),
                    ListView.separated(
                      shrinkWrap: true,  // Add shrinkWrap to prevent unbounded height
                      itemCount: scanHistory.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final history = scanHistory[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  history['date'] ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  history['plantName'] ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  history['accuracy'] ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
