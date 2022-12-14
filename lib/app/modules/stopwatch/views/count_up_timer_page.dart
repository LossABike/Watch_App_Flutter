import 'package:alarm_clock_flutter/app/data/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CountUpTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CountUpTimerPage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<CountUpTimerPage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: CustomColors.pageBackgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snap) {
                      final value = snap.data;
                      final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              value.toString(),
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height: 150,
                  color: CustomColors.pageBackgroundColor,
                  margin: const EdgeInsets.all(8),
                  child: StreamBuilder<List<StopWatchRecord>>(
                    stream: _stopWatchTimer.records,
                    initialData: _stopWatchTimer.records.value,
                    builder: (context, snap) {
                      final value = snap.data;
                      if (value.isEmpty) {
                        return Container();
                      }
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut);
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final data = value[index];
                          return Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Colors.lightBlue,
                                      ),
                                      Text(
                                        '${index + 1}: ',
                                        style: const TextStyle(
                                            color: Colors.lightBlueAccent,
                                            fontSize: 16,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${data.displayTime}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                              ),
                              const Divider(
                                height: 1,
                              )
                            ],
                          );
                        },
                        itemCount: value.length,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  // ignore: deprecated_member_use
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      backgroundColor: Colors.lightBlue,
                                      shape: const StadiumBorder(),
                                    ),

                                
                                    onPressed: () async {
                                      _stopWatchTimer.onExecute
                                          .add(StopWatchExecute.start);
                                    },
                                    child: const Text(
                                      "Star",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ),
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  // ignore: deprecated_member_use
                                  child: ElevatedButton(
                                     style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(4),

                                        backgroundColor: Colors.green,
                                        shape: const StadiumBorder(),
                                     ),
                                    
                                    onPressed: () async {
                                      _stopWatchTimer.onExecute
                                          .add(StopWatchExecute.stop);
                                    },
                                    child: const Text(
                                      'Stop',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child:  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      backgroundColor: Colors.red,
                                      shape: const StadiumBorder(),
                                  ),

                            
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.reset);
                                  },
                                  child: const Text(
                                    'Reset',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                          ),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                // ignore: deprecated_member_use
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      backgroundColor: Colors.deepPurpleAccent,
                                      shape: const StadiumBorder(),
                                  ),
                                  
                                  onPressed: () async {
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.lap);
                                  },
                                  child: const Text(
                                    'Lap',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 1),
                                  // ignore: deprecated_member_use
                                  child:ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      backgroundColor: CustomColors.pageBackgroundColor,
                                      shape: const StadiumBorder(),
                                  ),
                                    
                                    onPressed: () async {
                                      _stopWatchTimer.setPresetHoursTime(1);
                                    },
                                    child: const Text(
                                      'H+1',
                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                            ),
                            Expanded(
                                child:  Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 1),
                                  child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      backgroundColor: CustomColors.pageBackgroundColor,
                                      shape: const StadiumBorder(),
                                  ),
                                    
                                    onPressed: () async {
                                      _stopWatchTimer.setPresetMinuteTime(1);
                                    },
                                    child: const Text(
                                      'M+1',
                                      style: TextStyle(color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 1),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      backgroundColor: CustomColors.pageBackgroundColor,
                                      shape: const StadiumBorder(),
                                  ),
                                 
                                  onPressed: () async {
                                    _stopWatchTimer.setPresetSecondTime(10);
                                  },
                                  child: const Text(
                                    'S+10',
                                    style: TextStyle(color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
    );
  }
}