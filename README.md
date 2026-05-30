#  校园生活助手 - Campus Life Assistant

> **移动应用开发实践课程（Vibe Coding版）期末项目**
> **河南理工大学** · 2026年春季 · 任建吉老师

---

## 项目概述

一款面向高校学生的跨平台校园生活助手 App，使用 **Flutter 3.x** 开发，支持 **Android** 平台运行。

### 核心功能（9大页面）

| 页面 | 功能说明 |
|------|---------|
| 智能首页 | 实时天气（wttr.in API）、今日课程卡片、6个快捷入口 |
| 课程表 | 周视图网格，彩色课程卡片，按节次/天排列 |
| 食堂菜单 | 按食堂Tab筛选，菜品收藏 |
| 校园公告 | 公告列表，底部弹窗查看详情，收藏 |
| 校园卡 | 虚拟校园卡（余额、学生信息）、交易流水 |
| 成绩查询 | 按学期查看成绩、GPA统计、分数环形指示器 |
| 校历 | 月视图日历，假期/考试/活动事件标记 |
| 校园地图 | 主要建筑网格展示，点击查看详情 |
| 个人中心 | 个人信息、成绩查询入口、收藏管理、设置 |

---

## 技术栈

| 技术 | 用途 |
|------|------|
| **Flutter 3.41.9** | 跨平台 UI 框架 |
| **Dart 3.11** | 开发语言 |
| **Material Design 3** | UI 设计规范（useMaterial3） |
| **Provider** | 状态管理（ChangeNotifierProvider） |
| **SharedPreferences** | 本地数据持久化 |
| **HTTP (wttr.in API)** | 实时天气数据获取 |
| **Git** | 版本控制 |

---

## 项目结构

```
xyshzsapp/
├── lib/
│   ├── main.dart                     # 应用入口 + 路由 + 底部导航
│   ├── models/
│   │   └── school_data.dart          # 数据模型 + 模拟数据（课程/菜品/公告/交易/成绩/校历）
│   ├── providers/
│   │   ├── favorites_provider.dart   # 收藏状态管理（菜品+公告）
│   │   └── theme_provider.dart       # 主题切换（浅色/深色/跟随系统）
│   └── pages/
│       ├── splash_page.dart          # 启动动画页
│       ├── home_page.dart            # 首页（天气+课程+快捷入口）
│       ├── schedule_page.dart        # 课程表（周视图）
│       ├── canteen_page.dart         # 食堂菜单（Tab筛选+收藏）
│       ├── notice_page.dart          # 校园公告
│       ├── card_page.dart            # 校园卡（余额+交易流水）
│       ├── grade_page.dart           # 成绩查询（GPA统计）
│       ├── calendar_page.dart        # 校历（月视图+事件）
│       ├── map_page.dart             # 校园地图
│       ├── profile_page.dart         # 个人中心
│       ├── favorites_page.dart       # 我的收藏
│       └── settings_page.dart        # 设置（深色模式）
├── android/                          # Android 平台配置
├── test/
│   └── widget_test.dart              # Widget 测试
└── pubspec.yaml                      # 依赖配置
```

---

## 快速开始

### 环境要求

- Flutter SDK 3.x
- Dart SDK 3.x
- Android SDK (API 21+)

### 安装运行

```bash
# 1. 克隆仓库
git clone <仓库地址>
cd xyshzsapp

# 2. 安装依赖
flutter pub get

# 3. 运行（连接 Android 设备后）
flutter run

# 4. 构建 APK
flutter build apk --debug
# APK 路径：build/app/outputs/flutter-apk/app-debug.apk
```

---

## 课程要求对照

| 要求 | 状态 | 实现方式 |
|------|------|---------|
| Flutter 3.x + Android API 21+ | ✅ | Flutter 3.41.9 |
| 3-5个核心页面 | ✅ | 实际12个页面 |
| Material Design 3 | ✅ | `useMaterial3: true` + `colorSchemeSeed` |
| 深色模式切换 | ✅ | ThemeProvider + SharedPreferences 持久化 |
| 本地数据持久化 | ✅ | SharedPreferences（收藏/主题/通知/字体） |
| 网络数据交互 | ✅ | wttr.in API 实时天气（JSON） |
| Provider 状态管理 | ✅ | FavoritesProvider + ThemeProvider |
| Git 版本控制 | ✅ | 本仓库 |
| 可安装 APK | ✅ | flutter build apk --debug |
| AI 协作开发 | ✅ | Trae AI IDE 辅助编码 |

---

## 数据模型

### 课程（Course）
- name, teacher, classroom, dayOfWeek, startSlot, duration, weeks

### 菜品（Dish）
- name, canteen, price, rating, description

### 公告（Notice）
- title, date, content, category

### 校园卡交易（CardTransaction）
- time, location, amount, balance, isIncome

### 成绩（GradeRecord）
- courseName, credit, score, gradePoint, semester

### 校历事件（CalendarEvent）
- date, title, type（holiday/exam/activity/academic）

---

## 状态管理架构

```
ChangeNotifierProvider (MaterialApp 外层)
  ├── FavoritesProvider ← SharedPreferences ← 菜品/公告收藏
  └── ThemeProvider     ← SharedPreferences ← 主题模式/通知/字体
```

---

## 作者

- **开发者**：河南理工大学 计算机科学与技术 张同学
- **指导老师**：任建吉
- **时间**：2026年春季学期
