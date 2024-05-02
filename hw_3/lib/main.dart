// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(YahtzeeGame());
}

int renew = 0;
int num = 3;
int set = 0;
int turn = 1;

class YahtzeeGame extends StatefulWidget {
  YahtzeeGame({super.key});

  @override
  State<YahtzeeGame> createState() => _YahtzeeGameState();
}

class _YahtzeeGameState extends State<YahtzeeGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yahtzee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              void goToNextPageIfNeeded() {
                if (turn >= 13) {
                  // Navigate to the next page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NextPage(),
                    ),
                  );
                }
              }

              return Scaffold(
                body: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(height: 110, child: Image.network('https://th.bing.com/th/id/OIP.Ft5v-GtVle7hhA-kEOPF8gHaDm?w=348&h=170&c=7&r=0&o=5&dpr=1.3&pid=1.7')),
                      Expanded(flex: 1, child: YahtzeeScreen()),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Grid()),
                            SizedBox(width: 5),
                            //Expanded(flex: 1, child: Grid2())
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              renew = 0;
                              num = 3;
                              set = 0;
                              turn = 1;
                              for (int x = 0; x < 13; x++) {
                                DiceCount.diceCountMap[x + 1] = 0;
                              }
                              for (int x = 0; x < 13; x++) {
                                RealDiceCount.diceCountMap[x + 1] = 0;
                              }
                              setState(() {});
                            },
                            child: Text('Restart'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              goToNextPageIfNeeded();
                              if (num > 0) {
                                renew = 1;
                                num--;
                                setState(() {});
                              }
                            },
                            child: Text('Roll Dice'),
                          ),
                          Text('回合:$turn/13')
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {int? re = RealDiceCount.diceCountMap[14];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '遊戲結束',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
            Text(
              '總分:$re',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 重置遊戲狀態
                renew = 0;
                num = 3;
                set = 0;
                turn = 1;
                for (int x = 0; x < 13; x++) {
                  DiceCount.diceCountMap[x + 1] = 0;
                }
                for (int x = 0; x < 13; x++) {
                  RealDiceCount.diceCountMap[x + 1] = 0;
                }
                // 導航回 YahtzeeGame
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('重新開始'),
            ),
          ],
        ),
      ),
    );
  }
}

Map<int, String> textMap = {
  3: '三條',
  9: '四條',
  15: '小順',
  21: '大順',
  27: '全選',
  33: '葫蘆',
  39: '快艇',
  36: '總分'
  // 添加更多索引和對應文字
};

Map<int, String> urlMap = {
  0: 'https://cdn.pixabay.com/photo/2014/04/03/10/24/one-310338_640.png',
  6: 'https://cdn.pixabay.com/photo/2014/04/03/11/56/dice-312627_640.png',
  12: 'https://cdn.pixabay.com/photo/2014/04/03/10/24/three-310336_640.png',
  18: 'https://cdn.pixabay.com/photo/2014/04/03/10/24/dice-310335_640.png',
  24: 'https://cdn.pixabay.com/photo/2014/04/03/10/24/five-310334_640.png',
  30: 'https://cdn.pixabay.com/photo/2014/04/03/11/56/dice-312621_640.png',
  // 添加更多索引和URL對應
};

class Grid extends StatefulWidget {
  const Grid({super.key, Key? keys});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  void handleGridClick(int index) {
    int re = 1;
    if (index == 1 && RealDiceCount.diceCountMap[1] == 0) {
      RealDiceCount.diceCountMap[1] = DiceCount.diceCountMap[1]!;
    } else if (index == 7 && RealDiceCount.diceCountMap[2] == 0) {
      RealDiceCount.diceCountMap[2] = DiceCount.diceCountMap[2]!;
    } else if (index == 13 && RealDiceCount.diceCountMap[3] == 0) {
      RealDiceCount.diceCountMap[3] = DiceCount.diceCountMap[3]!;
    } else if (index == 19 && RealDiceCount.diceCountMap[4] == 0) {
      RealDiceCount.diceCountMap[4] = DiceCount.diceCountMap[4]!;
    } else if (index == 25 && RealDiceCount.diceCountMap[5] == 0) {
      RealDiceCount.diceCountMap[5] = DiceCount.diceCountMap[5]!;
    } else if (index == 31 && RealDiceCount.diceCountMap[6] == 0) {
      RealDiceCount.diceCountMap[6] = DiceCount.diceCountMap[6]!;
    } else if (index == 4 && RealDiceCount.diceCountMap[7] == 0) {
      RealDiceCount.diceCountMap[7] = DiceCount.diceCountMap[7]!;
    } else if (index == 10 && RealDiceCount.diceCountMap[8] == 0) {
      RealDiceCount.diceCountMap[8] = DiceCount.diceCountMap[8]!;
    } else if (index == 16 && RealDiceCount.diceCountMap[9] == 0) {
      RealDiceCount.diceCountMap[9] = DiceCount.diceCountMap[9]!;
    } else if (index == 22 && RealDiceCount.diceCountMap[10] == 0) {
      RealDiceCount.diceCountMap[10] = DiceCount.diceCountMap[10]!;
    } else if (index == 28 && RealDiceCount.diceCountMap[11] == 0) {
      RealDiceCount.diceCountMap[11] = DiceCount.diceCountMap[11]!;
    } else if (index == 34 && RealDiceCount.diceCountMap[12] == 0) {
      RealDiceCount.diceCountMap[12] = DiceCount.diceCountMap[12]!;
    } else if (index == 40 && RealDiceCount.diceCountMap[13] == 0) {
      RealDiceCount.diceCountMap[13] = DiceCount.diceCountMap[13]!;
    } else {
      re = 0;
    }

    RealDiceCount.diceCountMap[14] = RealDiceCount.diceCountMap[1]! +
        RealDiceCount.diceCountMap[2]! +
        RealDiceCount.diceCountMap[3]! +
        RealDiceCount.diceCountMap[4]! +
        RealDiceCount.diceCountMap[5]! +
        RealDiceCount.diceCountMap[6]! +
        RealDiceCount.diceCountMap[7]! +
        RealDiceCount.diceCountMap[8]! +
        RealDiceCount.diceCountMap[9]! +
        RealDiceCount.diceCountMap[10]! +
        RealDiceCount.diceCountMap[11]! +
        RealDiceCount.diceCountMap[12]! +
        RealDiceCount.diceCountMap[13]!;

    if (re == 1) {
      for (int x = 0; x < 13; x++) {
        DiceCount.diceCountMap[x + 1] = 0;
      }
      setState(() {
        num = 3;
        turn++;
      });
    }

    //print('Clicked on grid at index: $index');
    // 在這裡添加您希望執行的動作
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: 42, // 6x6 共 36 個格子
        itemBuilder: (BuildContext context, int index) {
          Color color = Colors.white;
          if (index % 3 == 1) {
            color = Colors.red; // 第二行的顏色為紅色
          } else if (index % 3 == 2) {
            color = Colors.blue; // 第三行的顏色為藍色
          }

          // 從urlMap中獲取對應的URL
          String imageUrl = urlMap[index] ?? '';

          // 如果索引为1，则显示 DiceCount 中的值
          String text = '';
          if (index == 1) {
            text = '${DiceCount.diceCountMap[1]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 2) {
            text = '${RealDiceCount.diceCountMap[1]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 8) {
            text = '${RealDiceCount.diceCountMap[2]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 7) {
            text = '${DiceCount.diceCountMap[2]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 13) {
            text = '${DiceCount.diceCountMap[3]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 14) {
            text = '${RealDiceCount.diceCountMap[3]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 19) {
            text = '${DiceCount.diceCountMap[4]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 20) {
            text = '${RealDiceCount.diceCountMap[4]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 25) {
            text = '${DiceCount.diceCountMap[5]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 26) {
            text = '${RealDiceCount.diceCountMap[5]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 31) {
            text = '${DiceCount.diceCountMap[6]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 32) {
            text = '${RealDiceCount.diceCountMap[6]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 3) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 9) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 15) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 21) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 27) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 33) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 36) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 39) {
            text = textMap[index] ?? '';
            if (text == '0') {
              text = '';
            }
          } else if (index == 4) {
            text = '${DiceCount.diceCountMap[7]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 5) {
            text = '${RealDiceCount.diceCountMap[7]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 10) {
            text = '${DiceCount.diceCountMap[8]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 11) {
            text = '${RealDiceCount.diceCountMap[8]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 16) {
            text = '${DiceCount.diceCountMap[9]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 17) {
            text = '${RealDiceCount.diceCountMap[9]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 22) {
            text = '${DiceCount.diceCountMap[10]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 23) {
            text = '${RealDiceCount.diceCountMap[10]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 28) {
            text = '${DiceCount.diceCountMap[11]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 29) {
            text = '${RealDiceCount.diceCountMap[11]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 34) {
            text = '${DiceCount.diceCountMap[12]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 35) {
            text = '${RealDiceCount.diceCountMap[12]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 40) {
            text = '${DiceCount.diceCountMap[13]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 41) {
            text = '${RealDiceCount.diceCountMap[13]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 38) {
            text = '${RealDiceCount.diceCountMap[14]}';
            if (text == '0') {
              text = '';
            }
          } else if (index == 37) {
            text = '剩$num次';
            if (text == '0') {
              text = '';
            }
          }

          return GestureDetector(
            onTap: () {
              // 在這裡處理點擊事件
              handleGridClick(index);
            },
            child: Container(
              color: color,
              child: Center(
                child: imageUrl.isNotEmpty
                    ? Image.network(imageUrl)
                    : Text(
                        text,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/* class Grid2 extends StatefulWidget {
  const Grid2({super.key});

  @override
  State<Grid2> createState() => _Grid2State();
}

class _Grid2State extends State<Grid2> {

  void handleGridClick(int index) {
  print('Clicked on grid at index: $index');
  // 在這裡添加您希望執行的動作
}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: 21, // 6x6 共 36 個格子
        itemBuilder: (BuildContext context, int index) {
          Color color = Colors.white;
          if (index % 3 == 1) {
            color = Colors.red; // 第二行的顏色為紅色
          } else if (index % 3 == 2) {
            color = Colors.blue; // 第三行的顏色為藍色
          }

          // 從textMap中獲取對應的文字
          String text = textMap[index] ?? '';

          String text0 = '';
          if (index == 1) {
            text = '${DiceCount.diceCountMap[7]}';
            if(text=='0'){text='';}
          } else if (index == 4) {
            text = '${DiceCount.diceCountMap[8]}';
            if(text=='0'){text='';}
          }else if(index==7){
            text='${DiceCount.diceCountMap[9]}';
            if(text=='0'){text='';}
          }else if(index==10){
            text='${DiceCount.diceCountMap[10]}';
            if(text=='0'){text='';}
          }else if(index==13){
            text='${DiceCount.diceCountMap[11]}';
            if(text=='0'){text='';}
          }else if(index==16){
            text='${DiceCount.diceCountMap[12]}';
            if(text=='0'){text='';}
          }else if(index==19){
            text='${DiceCount.diceCountMap[13]}';
            if(text=='0'){text='';}
          }
          print(text0);
          return GestureDetector(
      onTap: () {
        // 在這裡處理點擊事件
        handleGridClick(index);
      },
      child: Container(
            color: color,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 20,color: Colors.black),
                
              ),
            ),
          ));
        },
      ),
    );
  }
} */

class DiceCount {
  static Map<int, int> diceCountMap = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
  };

  static Map<int, int> getDiceCountMap() {
    return diceCountMap;
  }
}

class RealDiceCount {
  static Map<int, int> diceCountMap = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
    7: 0,
    8: 0,
    9: 0,
    10: 0,
    11: 0,
    12: 0,
    13: 0,
    14: 0,
  };

  static Map<int, int> getDiceCountMap() {
    return diceCountMap;
  }
}

class YahtzeeScreen extends StatefulWidget {
  const YahtzeeScreen({super.key});

  @override
  _YahtzeeScreenState createState() => _YahtzeeScreenState();
}

class _YahtzeeScreenState extends State<YahtzeeScreen> {
  List<int> dice = [1, 1, 1, 1, 1];
  Random random = Random();
  List<int> selectedDice = [];

  void rollDice() {
    setState(() {
      for (int i = 0; i < dice.length; i++) {
        if (!selectedDice.contains(i)) {
          dice[i] = random.nextInt(6) + 1;
        }
      }
      // 計算有多少個 1 點

      int countOfOnes = 0;
      for (int die in dice) {
        if (die == 1) {
          countOfOnes++;
        }
      }
      print('Number of ones: $countOfOnes');
      //diceCountMap[1]=countOfOnes;
      DiceCount.diceCountMap[1] = countOfOnes;
      int countOfTwos = 0;
      for (int die in dice) {
        if (die == 2) {
          countOfTwos++;
        }
      }
      countOfTwos = countOfTwos * 2;
      print('Number of two: $countOfTwos');
      //diceCountMap[2]=countOfTwos;
      DiceCount.diceCountMap[2] = countOfTwos;
      int countOfThree = 0;
      for (int die in dice) {
        if (die == 3) {
          countOfThree++;
        }
      }
      countOfThree = countOfThree * 3;
      print('Number of three: $countOfThree');
      //diceCountMap[3]=countOfThree;
      DiceCount.diceCountMap[3] = countOfThree;
      int countOfFour = 0;
      for (int die in dice) {
        if (die == 4) {
          countOfFour++;
        }
      }
      countOfFour = countOfFour * 4;
      print('Number of four: $countOfFour');
      //diceCountMap[4]=countOfFour;
      DiceCount.diceCountMap[4] = countOfFour;
      int countOfFive = 0;
      for (int die in dice) {
        if (die == 5) {
          countOfFive++;
        }
      }
      countOfFive = countOfFive * 5;
      print('Number of five: $countOfFive');
      //diceCountMap[5]=countOfFive;
      DiceCount.diceCountMap[5] = countOfFive;
      int countOfSix = 0;
      for (int die in dice) {
        if (die == 6) {
          countOfSix++;
        }
      }
      countOfSix = countOfSix * 6;
      print('Number of six: $countOfSix');
      //diceCountMap[6]=countOfSix;
      DiceCount.diceCountMap[6] = countOfSix;

      int threethree = 0;
      if (countOfOnes > 2 ||
          countOfTwos > 4 ||
          countOfThree > 6 ||
          countOfFour > 8 ||
          countOfFive > 10 ||
          countOfSix > 12) {
        threethree = countOfOnes +
            countOfTwos +
            countOfThree +
            countOfFour +
            countOfFive +
            countOfSix;
      } else {
        threethree = 0;
      }
      ;
      DiceCount.diceCountMap[7] = threethree;

      int fourfour = 0;
      if (countOfOnes > 3 ||
          countOfTwos > 6 ||
          countOfThree > 9 ||
          countOfFour > 12 ||
          countOfFive > 15 ||
          countOfSix > 18) {
        fourfour = countOfOnes +
            countOfTwos +
            countOfThree +
            countOfFour +
            countOfFive +
            countOfSix;
      } else {
        fourfour = 0;
      }
      ;
      DiceCount.diceCountMap[8] = fourfour;

      int small = 0;
      if (countOfOnes > 0 &&
          countOfTwos > 0 &&
          countOfThree > 0 &&
          countOfFour > 0) {
        small = 30;
      } else if (countOfFive > 0 &&
          countOfTwos > 0 &&
          countOfThree > 0 &&
          countOfFour > 0) {
        small = 30;
      } else if (countOfFive > 0 &&
          countOfSix > 0 &&
          countOfThree > 0 &&
          countOfFour > 0) {
        small = 30;
      } else {
        small = 0;
      }
      DiceCount.diceCountMap[9] = small;

      int big = 0;
      if (countOfOnes > 0 &&
          countOfTwos > 0 &&
          countOfThree > 0 &&
          countOfFour > 0 &&
          countOfFive > 0) {
        big = 40;
      } else if (countOfFive > 0 &&
          countOfTwos > 0 &&
          countOfThree > 0 &&
          countOfFour > 0 &&
          countOfSix > 0) {
        big = 40;
      } else {
        big = 0;
      }
      DiceCount.diceCountMap[10] = big;

      DiceCount.diceCountMap[11] = countOfOnes +
          countOfTwos +
          countOfThree +
          countOfFour +
          countOfFive +
          countOfSix;

      int fullhouse = 0;
      if (countOfOnes == 3 ||
          countOfTwos == 6 ||
          countOfThree == 9 ||
          countOfFour == 12 ||
          countOfFive == 15 ||
          countOfSix == 18) {
        if (countOfOnes == 2 ||
            countOfTwos == 4 ||
            countOfThree == 6 ||
            countOfFour == 8 ||
            countOfFive == 10 ||
            countOfSix == 12) {
          fullhouse = 25;
        }
      } else {
        fullhouse = 0;
      }
      DiceCount.diceCountMap[12] = fullhouse;

      int fastfast = 0;
      if (countOfOnes == 5 ||
          countOfTwos == 10 ||
          countOfThree == 15 ||
          countOfFour == 20 ||
          countOfFive == 25 ||
          countOfSix == 30) {
        fastfast = 50;
      } else {
        fastfast = 0;
      }
      DiceCount.diceCountMap[13] = fastfast;

      print(DiceCount.diceCountMap);
      print(renew);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (renew == 1) {
      rollDice();
      renew = 0; // 重置 renew 變數，避免多次觸發 rollDice()
    }

    return Expanded(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < dice.length; i++)
                    Die(
                      die: dice[i],
                      isSelected: selectedDice.contains(i),
                      onDieSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            selectedDice.add(i);
                          } else {
                            selectedDice.remove(i);
                          }
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class Die extends StatefulWidget {
  final int die;
  final Function(bool) onDieSelected;
  final bool isSelected;

  const Die(
      {super.key,
      required this.die,
      required this.onDieSelected,
      required this.isSelected});

  @override
  _DieState createState() => _DieState();
}

class _DieState extends State<Die> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onDieSelected(!widget.isSelected);
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.grey : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '${widget.die}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
