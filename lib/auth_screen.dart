import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  var inputText = "";
  var checkText = "";
  var actives = [false, false, false, false];
  var clears = [false, false, false, false];
  var values = [-1, -1, -1, -1];
  var currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadPIN();
  }

  void loadPIN()async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      checkText = (prefs.getString('pinCode') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter PIN Screen"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 48.0),
                Text(
                    "Enter your PIN",
                    style: TextStyle(
                      fontSize: 24
                    )
                ),
                SizedBox(height: 12.0),
                Container(
                  height: 56.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < actives.length; i++)
                        AnimationBoxItem (
                          clear: clears[i],
                          active: actives[i],
                          value: values[i],
                        ),
                    ],
                  ),
                ),
              ],
            )
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal:48.0),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
              ),
                      itemBuilder: (context, index) => Container(
                        child: index == 9
                            ? SizedBox()
                            : Center(
                          child: MaterialButton(
                            onPressed: () {
                              if (index == 11) {
                                inputText = inputText.substring(0, inputText.length - 1);
                                clears = clears = clears.map((e) => false).toList();
                                currentIndex--;
                                if (currentIndex >= 0)
                                  setState(() {
                                    clears[currentIndex] = true;
                                    actives[currentIndex] = false;
                                  });
                                else {
                                  currentIndex = 0;
                                }
                                print(inputText);
                                return;
                              }
                              else {
                                inputText += numbers[index == 10 ? index - 1 : index].toString();
                                print(inputText);
                              }

                              if(inputText.length == 4) {
                                setState(() {
                                  clears = clears.map((e) => true).toList();
                                  actives = actives.map((e) => false).toList();
                                });
                                if (inputText == checkText) {
                                  setState(() {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Success'),
                                        content: const Text('Authentication success.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                }
                                else {
                                  setState(() {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text('Authentication failed. Try again.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                }
                                inputText = "";
                                currentIndex = 0;
                                return;
                              }
                              clears = clears.map((e) => false).toList();
                              setState(() {
                                actives[currentIndex] = true;
                                currentIndex++;
                              });
                            },
                            color: Colors.white54,
                            minWidth: 56,
                            height: 56,
                            child: index == 11
                                ? Icon(Icons.backspace, color: Colors.black87)
                                : Text(
                                    "${numbers[index == 10 ? index - 1 : index]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87
                                  ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(56.0),
                            ),
                          ),
                        ),
                      ),
              itemCount: 12,
          )
          ),
        ],
      ),
    );
  }
}

class AnimationBoxItem extends StatefulWidget {
  final clear;
  final active;
  final value;
  const AnimationBoxItem({Key? key, this.clear = false, this.active = false, this.value}) : super(key: key);
  @override
  _AnimationBoxItemState createState() => _AnimationBoxItemState();
}

class _AnimationBoxItemState extends State<AnimationBoxItem> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  }
  @override
  Widget build(BuildContext context) {
    if(widget.clear) {
      animationController.forward(from: 0);
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Container(
        margin: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(),
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              width: 16.0,
              height: 16.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                color: widget.active ? Colors.blue : Colors.white70,
              ),
            ),
            Align(
              alignment: Alignment(0, animationController.value / widget.value - 1),
              child: Opacity(
                opacity: 1 - animationController.value,
                child: Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    color: widget.active ? Colors.blue : Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}