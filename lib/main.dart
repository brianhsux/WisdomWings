import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category_page.dart';
import 'challenge.dart';
import 'local_storage_manager.dart';
import 'dart:developer' as developer;

// class Question {
//   String category;
//   String question;
//   List<String> options;
//   int correctAnswer;

//   Question({
//     required this.category,
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // const LocalStorageManager localStorageManager = LocalStorageManager();
  // final Map<String, dynamic> jsonData = await localStorageManager.getJsonData();

  // developer.log("jsonData: " + jsonData.toString());
  runApp(const WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({Key? key}) : super(key: key);
  final String jsonKey = 'default_data_json_key';

  Future<void> _saveJsonData(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(data);
    await prefs.setString(jsonKey, jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to the Wisdom World!!!',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool dataSaved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // Prepare your JSON data here
      final Map<String, dynamic> jsonData = {
        "categories": [
          {
            "name": "宇宙和天文学",
            "questions": [
              {
                "question": "什么是哈勃望远镜？",
                "options": ["天体望远镜", "显微镜", "电子显微镜", "望远镜"],
                "correctAnswer": 0
              },
              {
                "question": "太阳系中最大的行星是？",
                "options": ["金星", "土星", "火星", "木星"],
                "correctAnswer": 3
              },
              {
                "question": "什么是超新星？",
                "options": ["新的太阳系", "星星的坍缩", "星星的爆炸", "星星的合并"],
                "correctAnswer": 2
              },
              {
                "question": "什么是黑洞？",
                "options": ["大质量星星的残骸", "星星的表面", "星云中的气体", "星星的光球"],
                "correctAnswer": 0
              },
              {
                "question": "光年是用来测量什么的？",
                "options": ["时间", "质量", "速度", "距离"],
                "correctAnswer": 3
              },
              {
                "question": "什么是星座？",
                "options": ["天体的轨道", "星星的颜色", "编号的星星", "连在一起形成图案的星星"],
                "correctAnswer": 3
              },
              {
                "question": "什么是行星？",
                "options": ["固体的天体", "星星", "太阳", "环绕太阳运动的天体"],
                "correctAnswer": 0
              },
              {
                "question": "什么是星际尘埃？",
                "options": ["水星的表面", "星星的残骸", "星系中漂浮的微小颗粒", "外行星的大气层"],
                "correctAnswer": 2
              },
              {
                "question": "什么是星系？",
                "options": ["单一的恒星", "一组星星", "巨大的气体球", "亿万星星和行星的集合"],
                "correctAnswer": 3
              },
              {
                "question": "什么是射电望远镜？",
                "options": ["观察太阳的望远镜", "探测射电波的望远镜", "用于地球科学的仪器", "观察月球的望远镜"],
                "correctAnswer": 1
              }
            ],
          },
          {
            "name": "生物学",
            "questions": [
              {
                "question": "什么是DNA的全称？",
                "options": ["脱氧核糖核酸", "核糖核酸", "蛋白质", "磷脂"],
                "correctAnswer": 0
              },
              {
                "question": "细胞的基本单位是什么？",
                "options": ["核糖体", "有丝分裂", "细胞核", "细胞"],
                "correctAnswer": 3
              },
              {
                "question": "植物通过哪个过程进行光合作用？",
                "options": ["呼吸作用", "蒸腾作用", "光解水作用", "变色作用"],
                "correctAnswer": 2
              },
              {
                "question": "哪种生物可以进行自养作用？",
                "options": ["细菌", "真菌", "植物", "动物"],
                "correctAnswer": 2
              },
              {
                "question": "下列哪个不是动物细胞的特征？",
                "options": ["细胞壁", "线粒体", "细胞膜", "细胞核"],
                "correctAnswer": 0
              },
              {
                "question": "人类的基因组有多少条染色体？",
                "options": ["46条", "23条", "32条", "64条"],
                "correctAnswer": 0
              },
              {
                "question": "下列哪个不属于脊椎动物？",
                "options": ["鱼类", "昆虫", "鸟类", "哺乳动物"],
                "correctAnswer": 1
              },
              {
                "question": "细胞核的主要功能是什么？",
                "options": ["合成蛋白质", "储存能量", "细胞分裂", "控制细胞活动"],
                "correctAnswer": 3
              },
              {
                "question": "光合作用发生在植物的哪个器官？",
                "options": ["根部", "叶绿体", "细胞膜", "细胞核"],
                "correctAnswer": 1
              },
              {
                "question": "哪个器官负责人类的呼吸作用？",
                "options": ["心脏", "肺部", "肝脏", "脾脏"],
                "correctAnswer": 1
              }
            ]
          },
          {
            "name": "历史",
            "questions": [
              {
                "question": "下列哪个是世界上最古老的已知文明？",
                "options": ["古埃及文明", "美索不达米亚文明", "古希腊文明", "印度河流域文明"],
                "correctAnswer": 3
              },
              {
                "question": "古代世界七大奇迹中现存的唯一建筑是？",
                "options": ["巴比伦空中花园", "吴哥窟", "金字塔", "雅典卫城"],
                "correctAnswer": 2
              },
              {
                "question": "谁被认为是现代中国的统一者？",
                "options": ["秦始皇", "汉武帝", "唐太宗", "宋太祖"],
                "correctAnswer": 0
              },
              {
                "question": "以下哪个事件标志着罗马帝国的终结？",
                "options": ["查士丁尼的统治", "君士坦丁堡的陷落", "西罗马帝国的覆灭", "波斯战争的结束"],
                "correctAnswer": 2
              },
              {
                "question": "《共产党宣言》的作者是？",
                "options": ["卢梭和孟德斯鸠", "马克思和恩格斯", "孔子和老子", "亚里士多德和苏格拉底"],
                "correctAnswer": 1
              },
              {
                "question": "第一次世界大战的导火线是？",
                "options": ["萨拉热窝事件", "法国大革命", "布尔战争", "波斯战争"],
                "correctAnswer": 0
              },
              {
                "question": "哪位古希腊哲学家被认为是西方哲学的奠基人？",
                "options": ["苏格拉底", "亚里士多德", "柏拉图", "赫拉克利特"],
                "correctAnswer": 0
              },
              {
                "question": "谁是第一位登上月球的人？",
                "options": ["尼尔·阿姆斯特朗", "巴兹·奥尔德林", "约翰·格伦", "尤里·加加林"],
                "correctAnswer": 0
              },
              {
                "question": "美国独立战争的起因是？",
                "options": ["波士顿茶党事件", "杰克逊的大屠杀", "亚历山大大帝的入侵", "法国大革命"],
                "correctAnswer": 0
              },
              {
                "question": "以下哪个人物是文艺复兴时期的艺术家？",
                "options": ["莎士比亚", "米开朗基罗", "但丁", "哥白尼"],
                "correctAnswer": 1
              }
            ]
          }
        ],
      };

      // Call the _saveJsonData method to save the JSON data
      await WelcomeApp()._saveJsonData(jsonData);

      // Navigate to the CategoryPage
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CategoryPage()),
      // );

      developer.log("_saveJsonData done: " + jsonData.toString());
      setState(() {
        dataSaved = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Wisdom World!!!',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            if (dataSaved)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage()),
                  );
                },
                child: const Text('Start Wisdom'),
              ),
            if (!dataSaved) const Text('Initializing data...'),
          ],
        ),
      ),
    );
  }
}
