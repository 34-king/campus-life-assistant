# 校园生活助手 · 技术报告

> 移动应用开发实践课程（Vibe Coding版）
> 河南理工大学 · 2026年春季

---

## 1. 项目背景

### 1.1 项目简介

校园生活助手是一款面向高校学生的跨平台移动应用，旨在整合学生日常校园生活中常用的功能，包括课程表查询、食堂菜单浏览、校园公告查看、校园卡管理、成绩查询、校历查看等，解决学生需要在多个平台间切换的痛点。

### 1.2 开发目标

- 使用 Flutter 3.x 开发跨平台应用
- 支持 Android 设备正常运行（最低 API 21）
- 包含 3-5 个核心功能页面
- 实现本地数据持久化和网络数据交互
- 符合 Material Design 3 规范，支持深色模式
- 使用 AI 工具辅助开发

---

## 2. 技术选型

| 技术 | 选择理由 |
|------|---------|
| **Flutter 3.41** | 一套代码同时支持 Android/iOS/Web，Hot Reload 提升开发效率 |
| **Dart 3.11** | Flutter 官方语言，类型安全，性能优秀 |
| **Provider** | 官方推荐状态管理方案，轻量级，易于理解 |
| **SharedPreferences** | Android 原生键值存储，适合保存简单配置和收藏数据 |
| **Material Design 3** | Google 最新设计规范，支持动态主题和深色模式 |
| **HTTP (wttr.in)** | 免费天气 API，无需 API Key，JSON 格式返回 |

---

## 3. 架构设计

### 3.1 整体架构

```
┌─────────────────────────────────────────────────┐
│                    UI Layer                      │
│  12 Page Widgets（Material Design 3）           │
├─────────────────────────────────────────────────┤
│               State Management                   │
│  Provider（ChangeNotifierProvider）             │
│     ├── FavoritesProvider（收藏状态）           │
│     └── ThemeProvider（主题状态）                │
├─────────────────────────────────────────────────┤
│               Data Layer                         │
│     ├── MockData（模拟数据）                    │
│     ├── SharedPreferences（本地持久化）          │
│     └── HTTP API（实时天气）                    │
└─────────────────────────────────────────────────┘
```

### 3.2 数据流

```
用户操作 → Provider.notifyListeners() → Consumer Widget rebuild → UI更新
                    ↑
              SharedPreferences（跨会话持久化）
```

### 3.3 路由设计

```
/splash  →  启动页（2秒动画） →  /home  →  主界面（底部导航5个Tab）
                                              ├── 首页（天气+课程+快捷入口）
                                              ├── 课程表
                                              ├── 食堂菜单
                                              ├── 校园公告
                                              └── 个人中心
路由页面：/map（校园地图）/card（校园卡）/grade（成绩）/calendar（校历）
          /favorites（收藏）/settings（设置）
```

---

## 4. 功能实现

### 4.1 智能首页（home_page.dart）

- **实时天气**：通过 HTTP 请求 wttr.in API 获取焦作市实时天气数据（JSON 格式），包含温度、天气描述
- **今日课程**：根据当前星期几从 MockData 中过滤当天的课程列表，按节次排序显示
- **快捷入口**：6 个功能入口（食堂、公告、地图、校园卡、成绩、校历），点击跳转到对应页面

### 4.2 课程表（schedule_page.dart）

- 周视图网格布局，横向+纵向可滚动
- 横轴：周一至周日（7列），纵轴：第1-10节课
- 每个课程格子使用不同颜色（基于课程名哈希值），显示课程名和教室
- 支持跨节次显示（多节课合并为一个格子）

### 4.3 食堂菜单（canteen_page.dart）

- TabBar 按食堂分类显示（全部/学苑餐厅/学子餐厅等）
- 每个菜品卡片显示名称、描述、价格、评分
- 收藏按钮：点击收藏/取消收藏菜品，状态由 FavoritesProvider 管理

### 4.4 校园公告（notice_page.dart）

- 列表显示所有公告，包含类别标签、日期
- 点击公告弹出底部 Sheet 显示详情（DraggableScrollableSheet）
- 收藏按钮：支持收藏/取消收藏公告

### 4.5 校园卡（card_page.dart）

- 虚拟校园卡界面：渐变色背景，显示余额、学生信息（姓名/学号/院系）
- 快捷操作：充值、挂失、流水、付款码（模拟）
- 今日消费汇总卡片
- 最近交易流水列表（6条）

### 4.6 成绩查询（grade_page.dart）

- 学期选择器（PopupMenuButton），支持切换学期
- GPA 总览卡片：显示 GPA、平均分、总学分、课程数
- 成绩列表：每门课显示分数环形指示器、课程名、学分、等级标签（优秀/良好/中等/及格）
- GPA 计算：加权平均（绩点×学分 / 总学分）

### 4.7 校历（calendar_page.dart）

- 月份导航（上一月/下一月/返回今天）
- 月视图日历网格：显示日期、今日高亮、有事件的日期标记圆点
- 点击日期切换，底部显示该日的事件列表
- 事件类型：假期、考试、活动、教务，不同颜色标识

### 4.8 校园地图（map_page.dart）

- 网格布局展示 8 个主要校园建筑
- 每个建筑卡片显示图标、名称、位置
- 点击弹出详情对话框（AlertDialog），包含建筑介绍

### 4.9 个人中心 / 设置 / 收藏

- **个人中心**：头像、个人信息、功能入口列表（成绩查询、考试安排、收藏、设置）
- **设置**：深色模式切换（跟随系统/浅色/深色）、消息通知开关、字体大小
- **收藏**：统一展示收藏的菜品和公告，支持取消收藏

### 4.10 启动页（splash_page.dart）

- 渐变色背景 + 缩放淡入动画
- 学校 Logo + 应用名称
- 2秒后自动跳转到主界面

---

## 5. AI 协作开发

### 5.1 开发工具

本项目使用 **Trae AI IDE** 进行全程辅助开发。

### 5.2 协作流程

1. **需求描述**：用自然语言描述功能需求
2. **AI 生成**：AI 生成初始代码框架
3. **人工审查**：审查代码逻辑，调整 UI 细节
4. **整合测试**：整合到项目，运行测试
5. **迭代优化**：重复上述步骤

### 5.3 Prompt 示例

```
创建一个 Flutter 校园卡页面，包含虚拟卡片界面、余额显示、
交易流水列表、快捷操作按钮（充值/挂失/流水/付款码）
```

---

## 6. 课程要求对照

| 要求 | 实现情况 |
|------|---------|
| Flutter 3.x | Flutter 3.41.9 |
| Android 设备运行 | 最低 API 21，已生成可安装 APK |
| 3-5个核心页面 | 12 个页面（远超要求） |
| Material Design 3 | useMaterial3: true，动态主题色 |
| 深色模式切换 | ThemeMode.system / light / dark |
| 本地持久化 | SharedPreferences 存储收藏 + 主题设置 |
| 网络交互 | wttr.in 天气 API（HTTP+JSON） |
| Provider 状态管理 | FavoritesProvider + ThemeProvider |
| AI 辅助开发 | Trae AI IDE 全程辅助 |
| Git 版本控制 | Git 仓库管理 |
| 可安装 APK | flutter build apk --debug 生成 |

---

## 7. 鸿蒙适配方案（HarmonyOS NEXT）

### 方案 A：Flutter 跨平台（推荐，快速适配）

Flutter 3.x 已实验性支持 HarmonyOS，只需：

```bash
# 添加鸿蒙平台支持
flutter build harmonyos
```

需安装 DevEco Studio 和 HarmonyOS SDK。

### 方案 B：ArkTS 重写核心页面

使用 ArkTS + DevEco Studio 重写以下页面：

| 功能 | Flutter (Dart) | 鸿蒙 (ArkTS) |
|------|---------------|-------------|
| 首页 | `home_page.dart` | `pages/HomePage.ets` |
| 课程表 | `schedule_page.dart` | `pages/SchedulePage.ets` |
| 食堂菜单 | `canteen_page.dart` | `pages/CanteenPage.ets` |
| 个人中心 | `profile_page.dart` | `pages/ProfilePage.ets` |

ArkTS 语法对照示例：

```typescript
// ArkTS 版本首页
@Entry
@Component
struct HomePage {
  @State weather: string = '晴'
  @State courses: Course[] = []

  build() {
    Column() {
      Text('校园生活助手')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      // ...更多组件
    }
    .width('100%')
    .height('100%')
  }
}
```

---

## 8. 未来改进方向

1. **真实后端接入**：对接学校教务系统 API，获取真实课程和成绩数据
2. **用户登录系统**：支持学生身份认证，个性化数据
3. **推送通知**：课程提醒、食堂上新、考试提醒等
4. **离线缓存**：Hive 数据库缓存数据，支持离线使用
5. **更多校园功能**：空教室查询、失物招领、二手交易等
6. **性能优化**：列表虚拟化、图片懒加载、页面预加载

---

## 9. 项目总结

本项目从零开始，使用 Flutter 3.x 和 Trae AI IDE，在有限时间内完成了一个包含 12 个页面的跨平台校园生活助手 App。项目涵盖了 Flutter 开发的核心技术栈：Widget 树构建、状态管理、路由导航、本地持久化、网络请求、Material Design 3 设计规范等。

通过本项目，深入实践了 "Vibe Coding" 开发模式——用 AI 辅助代码生成，人工审查和优化，大幅提升了开发效率。

---

## 10. 参考资料

- [Flutter 官方文档](https://docs.flutter.dev)
- [Material Design 3](https://m3.material.io)
- [Provider 状态管理](https://pub.dev/packages/provider)
- [SharedPreferences](https://pub.dev/packages/shared_preferences)
- [wttr.in Weather API](https://wttr.in)
- [Trae AI IDE](https://trae.ai)


---

## 作者信息

- **开发者**：魏豪（学号：312320020230）
- **指导老师**：任建吉
- **学校**：河南理工大学
- **时间**：2026年春季学期
