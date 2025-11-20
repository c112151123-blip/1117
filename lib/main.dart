import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// 全局 AudioPlayer 實例
final player=AudioPlayer()..setReleaseMode(ReleaseMode.loop);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 四個分頁
  final tabs=[
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  int previousIndex=0;
  int currentIndex=0;

  // 初始化狀態，播放第一個螢幕的音訊
  @override
  void initState() {
    super.initState();
    // 應用程式啟動時，預設播放 Screen1 的音訊
    player.play(AssetSource("1.mp3"));
  }

  // 避免音訊控制邏輯在 build 方法中被重複調用
  /*
  @override
  Widget build(BuildContext context) {
    if (currentIndex==0) player.play(AssetSource("1.mp3")); // <-- 這一行應避免在 build 執行
    // ...
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的自傳"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        selectedFontSize: 18,
        unselectedFontSize: 14,
        iconSize: 30,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: currentIndex==0? Image.asset('assets/a1.png', width: 40, height: 40,):Image.asset('assets/a11.png', width: 30, height: 30,), label:"自我介紹",),
          BottomNavigationBarItem(icon: currentIndex==1? Image.asset('assets/a2.png', width: 40, height: 40,):Image.asset('assets/a21.png', width: 30, height: 30,), label:"學習歷程",),
          BottomNavigationBarItem(icon: currentIndex==2? Image.asset('assets/a3.jpg', width: 40, height: 40,):Image.asset('assets/a31.jpg', width: 30, height: 30,), label:"學習計畫",),
          BottomNavigationBarItem(icon: currentIndex==3? Image.asset('assets/a4.png', width: 40, height: 40,):Image.asset('assets/a41.png', width: 30, height: 30,), label:"專業方向",),
        ],
        onTap: (index) {
          setState(() {
            previousIndex=currentIndex;
            currentIndex=index;


            player.stop();

            String audioAsset = '';
            switch (index) {
              case 0:
                audioAsset = "1.mp3";
                break;
              case 1:
                audioAsset = "2.mp3";
                break;
              case 2:
                audioAsset = "3.mp3";
                break;
              case 3:
                audioAsset = "4.mp3";
                break;
            }

            // 播放新的音訊
            player.play(AssetSource(audioAsset));

          });
        },
      ),
    );
  }
}


class Screen1 extends StatelessWidget {
  Screen1({super.key});

  final String s1="我出生在一個很平凡但很美滿的小家庭，父親是個工程師兼家庭主夫，母親是個文書工作者。姐姐和我都還在學校求學。父母用民主的方式管教我們，希望我們能夠獨立自主、主動學習，累積人生經驗，但他們會適時的給予鼓勵和建議，父母親只對我們要求兩件事，第一是保持健康，第二是過得快樂。因為沒有健康的身體，就算有再多的才華、再大的抱負也無法發揮出來。又因為家境並不富裕，所以必須專心於課業上，學得一技之長，將來才能自立更生。"
      "因從小看著父親當工程師所以我也想當，於是高職進了資訊科，進高職後，每天都覺得很充實、很快樂。高職學生的特色是基本都上科大，所以我不斷地努力學習，最後到達高科。";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //標題
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Text("Who am I", style: TextStyle(fontSize: 32,
                fontWeight: FontWeight.bold),
            ),
          ),
          //自傳部分
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3,),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.amberAccent, offset: Offset(6,6)),
              ],
            ),
            child: Text(s1, style: const TextStyle(fontSize: 20,)),
          ),
          const SizedBox(height: 15),
          Container(
            color: Colors.redAccent,
            child: Image.asset('assets/a1.png'),
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(image: AssetImage('assets/a2.png'), fit: BoxFit.cover),
                ),
              ),
              //SizedBox(width: 10,),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(image: AssetImage('assets/a3.jpg'), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class Screen2 extends StatelessWidget {
  Screen2({super.key});

  final List<Map<String, String>> experiences = [
    {
      'title': '高中時期',
      'period': '2020.09 - 2023.06',
      'detail': '在高職三年，專注於校內科目。這段經歷確立了我未來投入資訊工程的目標。',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "我的學習歷程",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experiences[index]['title']!,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '時間：${experiences[index]['period']!}',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const Divider(height: 15, thickness: 1),
                        Text(
                          experiences[index]['detail']!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}



class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // 加上 SingleChildScrollView
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "未來學習計畫",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const SizedBox(height: 20,),

          // 大一時期
          const Text("大一時期 ", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.only(left: 15),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.amber, width: 4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. 程式語言：開始學習 C/C++ 與組合語言，打下未來寫程式的基礎。", style: const TextStyle(fontSize: 20,)),
              ],
            ),
          ),

          const SizedBox(height: 30,),

          // 大二時期
          const Text("大二時期", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.only(left: 15),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.redAccent, width: 4)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. 核心課程：學習資料結構、微處理機、系統程式等核心課程。", style: TextStyle(fontSize: 20,)),
              ],
            ),
          ),

          const SizedBox(height: 30,),

          // 大三時期
          const Text("大三時期", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.only(left: 15),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.purple, width: 4)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" 1.畢業專題：確定畢業專題方向，組建團隊並開始研究開發。", style: TextStyle(fontSize: 20,)),
              ],
            ),
          ),

          const SizedBox(height: 30,),

          const SizedBox(height: 20,),
          Center(
            child: Image.asset('assets/a3.jpg', width: 250, height: 250,), // 放置圖片
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );
  }
}


class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "專業方向與展望",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          const SizedBox(height: 20),

          // 方向一：軟體工程師 (Software Engineer)
          buildDirectionCard(
            context,
            '軟體開發與工程',
            '專注於應用程式、系統、或是後端服務的設計、開發與維護。',
            'assets/a4.png', // 假設這是你的 a4.png
            Colors.lightBlue.shade100,
          ),

          const SizedBox(height: 20),

          // 方向二：資料科學家 (Data Scientist)
          buildDirectionCard(
            context,
            '人工智慧與資料分析',
            '利用統計學、機器學習等技術，從海量資料中提取洞察，建立預測模型。',
            'assets/a2.png', // 範例圖片
            Colors.green.shade100,
          ),



          const SizedBox(height: 20),


        ],
      ),
    );
  }

  // 輔助方法：創建專業方向的卡片
  Widget buildDirectionCard(BuildContext context, String title, String detail, String imagePath, Color color) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    detail,
                    style: const TextStyle(fontSize: 16),
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
