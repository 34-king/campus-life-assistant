# 校园生活助手 - HarmonyOS NEXT 适配方案

## 一、概述

本文档描述了将 Flutter 校园生活助手（xyshzsapp）适配到 HarmonyOS NEXT 平台的完整方案。适配采用 **ArkTS + ArkUI** 原生开发方式，确保应用在 HarmonyOS 设备上的最佳性能和原生体验。

## 二、架构适配

### 2.1 Flutter → ArkTS 概念映射

| Flutter 概念 | HarmonyOS 对应 | 说明 |
|------------|----------------|------|
| Widget | @Component | ArkTS 中使用 @Component 装饰器声明组件 |
| StatefulWidget | @State + @Component | 使用 @State 管理组件内状态 |
| StatelessWidget | @Component (无状态) | 仅有 build 方法的纯展示组件 |
| Provider | AppStorage + @State | 全局状态使用 AppStorage，局部状态用 @State |
| MaterialApp | EntryAbility + @Entry | 使用 EntryAbility 管理应用生命周期 |
| Navigator.push | router.pushUrl | 页面间导航 |
| ThemeData | 全局颜色变量 + @State 切换 | 深色模式通过状态变量控制 |
| SharedPreferences | AppStorage / PersistentStorage | 本地持久化存储 |

### 2.2 页面结构适配

```
Flutter 页面                     HarmonyOS 页面
────────────                     ────────────
splash_page.dart      →          SplashPage.ets    (启动动画)
main.dart (IndexedStack) →       Index.ets          (Tabs 底部导航)
home_page.dart        →          HomePage.ets       (天气+课程+快捷入口)
schedule_page.dart    →          SchedulePage.ets   (周视图课程表)
canteen_page.dart     →          CanteenPage.ets    (食堂菜单 Tab)
notice_page.dart      →          NoticePage.ets     (公告列表)
profile_page.dart     →          ProfilePage.ets    (个人中心)
card_page.dart        →          CardPage.ets       (校园卡)
grade_page.dart       →          GradePage.ets      (成绩查询)
calendar_page.dart    →          CalendarPage.ets   (校历)
map_page.dart         →          MapPage.ets        (校园地图)
favorites_page.dart   →          FavoritesPage.ets  (我的收藏)
settings_page.dart    →          SettingsPage.ets   (设置)
```

### 2.3 数据模型映射

Flutter 数据类:
```dart
class Course {
  String name;
  String teacher;
  String classroom;
  int dayOfWeek;
  int startSlot;
  int duration;
}
```

ArkTS 数据类:
```typescript
export class Course {
  name: string = '';
  teacher: string = '';
  classroom: string = '';
  dayOfWeek: number = 1;
  startSlot: number = 1;
  duration: number = 2;
}
```

## 三、关键技术适配方案

### 3.1 底部导航栏

**Flutter** 使用 `NavigationBar` + `IndexedStack`：
```dart
NavigationBar(
  selectedIndex: _currentIndex,
  destinations: [...],
)
```

**HarmonyOS** 使用 `Tabs` 组件：
```typescript
Tabs({ barPosition: BarPosition.End, index: this.currentIndex })
  .onChange((index: number) => { this.currentIndex = index; })
{
  TabContent() { HomePage() }
    .tabBar(this.buildTabBar('首页'))
  // ...
}
```

### 3.2 状态管理

**Flutter** 使用 Provider + ChangeNotifier：
- FavoritesProvider: 管理收藏状态
- ThemeProvider: 管理主题切换

**HarmonyOS** 使用 AppStorage + @State：
```typescript
// 全局存储
AppStorage.setOrCreate('favManager', new FavoritesManager());

// 组件内状态
@Component
struct MyComponent {
  @State isDark: boolean = AppStorage.get<boolean>('isDark') ?? false;
}
```

### 3.3 深色模式

Flutter 通过 ThemeData 的 brightness 属性切换。HarmonyOS 通过 @State 控制背景色和文字颜色：

```typescript
.backgroundColor(this.isDark ? '#1C1C1E' : '#F5F5F5')
.fontColor(this.isDark ? '#FFFFFF' : '#333333')
```

### 3.4 网络请求

Flutter 使用 `http` 包获取天气数据（wttr.in API）。HarmonyOS 使用 `@kit.NetworkKit` 的 `http` 模块。

### 3.5 本地持久化

Flutter 使用 `SharedPreferences`。HarmonyOS 使用 `AppStorage` 或 `PersistentStorage`。

## 四、API 差异对照

| Flutter Widget / API | HarmonyOS ArkUI 替代 | 注意事项 |
|---------------------|---------------------|---------|
| Row/Column | Row/Column | 用法类似，FlexAlign 替代 MainAxisAlignment |
| Stack | Stack | 用法相似 |
| ListView.builder | ForEach + Scroll | ForEach 需要提供 key |
| Container | 直接设置属性 | Container(width:100) → .width(100) |
| Card | Stacked 容器+圆角+阴影 | 通过 backgroundColor + borderRadius + shadow 实现 |
| Text | Text | .fontSize().fontWeight().fontColor() |
| Icon | Text(emoji) 或 Image | 简单图标用 emoji 替代 |
| CircleAvatar | Circle + Text overlay | Circle().overlay(Text()) |
| TextFormField | TextInput | 表单输入组件 |
| RefreshIndicator | PullToRefresh | 下拉刷新组件 |
| InkWell | .onClick() | 点击事件 |
| SizedBox | .width().height() | 设置组件尺寸 |
| Padding | .padding() | 设置内边距 |
| EdgeInsets | Padding 对象 | 使用 { left, right, top, bottom } |

## 五、颜色系统

HarmonyOS 6.1.1 中 Color 支持以下方式：
- 十六进制字符串：`backgroundColor('#FF5757')`
- RGB 值：`Color(255, 87, 87)`
- 命名颜色：`Color.White`

## 六、运行环境

### 6.1 开发环境
- IDE: DevEco Studio 6.1
- SDK: HarmonyOS SDK API 24 (6.1.1 Beta1)
- 构建工具: hvigor

### 6.2 模拟器
- 设备: Pura 90 (phone, API 24)
- 系统: HarmonyOS 6.1.1 Beta1

### 6.3 构建命令
```bash
cd E:\xyshzs
set DEVECO_SDK_HOME=C:\Program Files\Huawei\DevEco Studio\sdk
hvigorw assembleHap --mode module -p product=default -p buildMode=debug
```

## 七、已实现的 HarmonyOS 页面

在 `E:\xyshzs` 项目中已创建以下页面：

| 页面文件 | 对应 Flutter 页面 | 功能 |
|---------|------------------|------|
| Index.ets | main.dart | 主页面 + 底部Tab导航 |
| SplashPage.ets | splash_page.dart | 启动画面 |
| HomePage section | home_page.dart | 天气、课程、快捷入口 |
| SchedulePage section | schedule_page.dart | 周视图课程表 |
| CanteenPage section | canteen_page.dart | 食堂菜单 |
| NoticePage section | notice_page.dart | 校园公告 |
| ProfilePage section | profile_page.dart | 个人中心 |
| CardPage.ets | card_page.dart | 校园卡 |
| GradePage.ets | grade_page.dart | 成绩查询 |
| CalendarPage.ets | calendar_page.dart | 校历 |
| MapPage.ets | map_page.dart | 校园地图 |
| FavoritesPage.ets | favorites_page.dart | 我的收藏 |
| SettingsPage.ets | settings_page.dart | 设置 |

## 八、Flutter 版本兼容方案

当前 Flutter 版本为 3.41.9（Dart 3.11.5），flutter-ohos 分支基于 Flutter 3.22.1（Dart 3.4.0）。
若需直接使用 Flutter 跨平台能力运行于鸿蒙，可：
1. 使用 OpenHarmony-SIG 提供的 `flutter_flutter` SDK（分支 3.22.1-ohos-0.1.0）
2. 配置环境变量指向 flutter-ohos SDK
3. 使用 `flutter create --platforms=ohos` 添加鸿蒙平台支持
4. 构建 HAP 包并安装到鸿蒙设备

## 九、总结

本适配方案采用 ArkTS 原生开发方式，完整移植了 Flutter 版本的 12 个页面和全部功能，包括：
- ✅ 底部导航栏（5个Tab）
- ✅ 实时天气显示
- ✅ 课程表（周视图）
- ✅ 食堂菜单
- ✅ 校园公告
- ✅ 个人中心
- ✅ 校园卡、成绩查询、校历、地图等子页面
- ✅ 收藏功能（AppStorage 持久化）
- ✅ 深色模式支持

通过此方案，校园生活助手应用可在 HarmonyOS NEXT 设备上以原生方式运行，提供流畅的用户体验。
