import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data/storage_manager.dart';
import 'states/user_state_model.dart';
import 'ui/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(
      MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(//可优化为MultiProvider：不止一个状态，该项目把需要状态管理元素都冗杂在UserStateModel中，可分离出
      create: (BuildContext context) => UserStateModel()..init(),
      child: MaterialApp(
        builder: BotToastInit(),
        //配置中文
        localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //此处
          const Locale('zh', 'CN'),
          const Locale('en', 'US'),
        ],
        locale: Locale('zh'),
        title: "经信所出差审批系统",
        home: MainPage(),
        navigatorObservers: [BotToastNavigatorObserver()],
        //2.registered route observer
        theme: Theme.of(context).copyWith(
            scaffoldBackgroundColor: Colors.white,
            primaryColorDark: Color(0xff388e3c),
            primaryColorLight: Color(0xffC8E6C9),
            primaryColor: Color(0xff4CAF50),
            accentColor: Color(0xff4CAF50),
            dividerColor: Color(0xbdbdbd),
            iconTheme:
                Theme.of(context).iconTheme.copyWith(color: Color(0xffffffff)),
            textTheme: Theme.of(context).textTheme.copyWith(
                subtitle1: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                button: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white),
                subtitle2: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.grey, fontSize: 20)),
            buttonTheme: Theme.of(context).buttonTheme.copyWith(minWidth: 100),
            buttonBarTheme:
                Theme.of(context).buttonBarTheme.copyWith(buttonMinWidth: 100)),
      ),
    );
  }
}
