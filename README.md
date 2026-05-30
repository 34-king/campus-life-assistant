# 🏫 校园生活助手 - Campus Life Assistant

> 移动应用开发实践课程（Vibe Coding版）期末项目
> **河南理工大学** · 2026年春季 · 任建吉老师

---

## 📱 项目概述

一款面向高校学生的跨平台校园生活助手 App，使用 **Flutter 3.x** 开发，支持 **Android/iOS/Web** 平台运行。

### 核心功能

| 功能 | 页面 | 说明 |
|------|------|------|
| 🏠 智能首页 | `home_page.dart` | 实时天气、今日课程、快捷入口 |
| 📚 课程表 | `schedule_page.dart` | 周课表网格视图，彩色课程卡片 |
| 🍽 食堂菜单 | `canteen_page.dart` | 按食堂筛选、搜索菜品、收藏 |
| 📰 校园公告 | `notice_page.dart` | 公告列表、详情弹窗、收藏 |
| 💳 校园卡 | `card_page.dart` | 虚拟校园卡、余额、交易流水 |
| 📋 成绩查询 | `grade_page.dart` | 按学期查看成绩、GPA 统计 |
| 📅 校历 | `calendar_page.dart` | 月视图日历、事件标记 |
| 🗺 校园地图 | `map_page.dart` | 主要建筑网格展示、详情弹窗 |
| 👤 个人中心 | `profile_page.dart` | 个人信息、快捷入口 |
| ❤️ 我的收藏 | `favorites_page.dart` | 菜品和公告的统一收藏管理 |
| ⚙️ 设置 | `settings_page.dart` | 深色模式切换、通知、字号 |
| 🎬 启动页 | `splash_page.dart` | 品牌动画，2秒自动跳转 |

---

## 🛠 技术栈

| 技术 | 用途 |
|------|------|
| **Flutter 3.41.9** | 跨平台 UI 框架 |
| **Dart 3.11** | 开发语言 |
| **Material Design 3** | UI 设计规范 |
| **Provider** | 状态管理 |
| **SharedPreferences** | 本地数据持久化 |
| **HTTP** | 实时天气数据 (wttr.in) |
| **Git** | 版本控制 |

---

## 📁 项目结构

```
xyshzsapp/
├── lib/
│   ├── main.dart              # 应用入口 + 路由
│   ├── models/
│   │   └── school_data.dart   # 数据模型 + 模拟数据
│   ├── providers/
│   │   ├── favorites_provider.dart  # 收藏状态管理
│   │   └── theme_provider.dart      # 主题切换管理
│   ├── pages/
│   │   ├── splash_page.dart   # 启动动画页
│   │   ├── home_page.dart     # 首页（天气+课程+快捷入口）
│   │   ├── schedule_page.dart # 课程表
│   │   ├── canteen_page.dart  # 食堂菜单
│   │   ├── notice_page.dart   # 校园公告
│   │   ├── card_page.dart     # 校园卡
│   │   ├── grade_page.dart    # 成绩查询
│   │   ├── calendar_page.dart # 校历
│   │   ├── map_page.dart      # 校园地图
│   │   ├── profile_page.dart  # 个人中心
│   │   ├── favorites_page.dart# 我的收藏
│   │   └── settings_page.dart # 设置页
│   └── widgets/               # 公共组件（预留）
├── android/                   # Android 平台配置
├── test/
│   └── widget_test.dart       # 基础 Widget 测试
├── pubspec.yaml               # 依赖配置
└── README.md                  # 本文件
```

---

## 🚀 快速开始

### 环境要求

- Flutter SDK 3.x
- Dart SDK 3.x
- Android SDK (API 21+)
- 可选：Xcode (iOS 构建)

### 安装运行

```bash
# 1. 克隆仓库
git clone <仓库地址>
cd xyshzsapp

# 2. 安装依赖
flutter pub get

# 3. 运行（Android）
flutter run

# 4. 运行（Web）
flutter run -d chrome
```

### 构建 APK

```bash
flutter build apk --debug
# 输出路径: build/app/outputs/flutter-apk/app-debug.apk
```

---

## 🤖 AI 协作说明

本项目开发全程使用 **Trae AI IDE** 辅助编码。

### 代码标注规则

每个源文件头部标注了 AI 参与度：

- `// 🤖 AI Generated` — AI 直接生成的代码
- `// ✏️ Human Modified` — 人工修改过的部分
- `// 📝 Human Written` — 手写的代码

### 典型协作流程

1. **需求描述** → 在 Trae AI Chat 中描述功能需求
2. **AI 生成** → AI 生成初始代码
3. **人工审查** → 检查代码逻辑，调整 UI 细节
4. **整合测试** → 整合到项目，运行测试
5. **迭代优化** → 重复上述步骤

### 使用的 Prompt 模板

详见 [附录：Prompt 模板](./docs/prompts.md)

---

## 📊 课程要求对照

| 要求 | 状态 | 实现说明 |
|------|------|---------|
| Flutter 3.x + Android API 21+ | ✅ | Flutter 3.41.9, minSdk自动适配 |
| 3-5个核心页面 | ✅ | 12个页面 |
| Material Design 3 | ✅ | colorSchemeSeed + useMaterial3 |
| 深色模式 | ✅ | ThemeMode.system + 手动切换 |
| 本地持久化 | ✅ | SharedPreferences 收藏/主题持久化 |
| 网络数据交互 | ✅ | wttr.in 实时天气 API |
| Provider 状态管理 | ✅ | FavoritesProvider + ThemeProvider |
| AI 协作开发 | ✅ | Trae IDE 全程辅助 |
| Git 版本控制 | ✅ | 本仓库 |
| APK 可安装包 | ✅ | `flutter build apk --debug` |
| 鸿蒙适配方案 | 📝 | 见下方 |

### 鸿蒙适配方案（HarmonyOS NEXT）

如需适配鸿蒙系统，有以下两种方案：

**方案 A：Flutter 跨平台（推荐快速适配）**
```yaml
# 在 pubspec.yaml 中添加鸿蒙平台支持
# 当前 Flutter 3.41 已实验性支持 HarmonyOS
flutter build harmonyos
```

**方案 B：ArkTS 重写核心页面**
将以下核心页面使用 ArkTS + DevEco Studio 重写：
- `home_page.dart` → `pages/HomePage.ets`
- `canteen_page.dart` → `pages/CanteenPage.ets`
- `schedule_page.dart` → `pages/SchedulePage.ets`

---

## 📝 技术要点

### 状态管理架构
```
ChangeNotifierProvider
  ├── FavoritesProvider  ← 收藏状态（菜品/公告）
  └── ThemeProvider      ← 主题模式（浅色/深色/跟随系统）
```

### 数据流
```
MOCK DATA → Provider → Consumer Widget → UI
   ↑                          |
   └──────────────────────────┘ (setState/notifyListeners)
```

### 本地存储
```
SharedPreferences
  ├── favorite_dishes: List<String>
  ├── favorite_notices: List<String>
  ├── theme_mode: String
  ├── notifications_enabled: bool
  └── font_scale_index: int
```

---

## 👨‍💻 作者

- **开发者**：张同学
- **指导老师**：任建吉
- **学校**：河南理工大学
- **时间**：2026年春季学期

---

## 📜 开源协议

本项目仅供学习交流使用。
