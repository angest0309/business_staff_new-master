# registration_staff

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



### 项目内容
1. 主界面相关代码： lib/ui/mainwidget
2. 填报界面：lib/ui/dialog/register_dialog
3. 状态逻辑： states/user_state_model.dart 观察者模式，ui通过绑定state，state变化时会主动刷新ui
4. 常量定义：config/const.dart:32
5. 网络请求封装：data/user_repo.dart:10
6. 本地配置存储， data/storage_manager.dart:3
```dart
// set
StorageManager.sp.setString("key", "value");
// get
StorageManager.sp.getString("key");
```
7. 工具类
- 参数校验：common/check.dart:4
- 日期格式转换：common/date.dart:5
