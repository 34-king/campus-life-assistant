# 校园生活助手 · 架构设计文档

> 技术实现说明：代码结构、状态管理、数据交互

---

## 一、代码结构

```
xyshzsapp/
├── lib/
│   ├── main.dart                    # 应用入口
│   │   ├── main()                  # Provider 初始化 + 持久化加载
│   │   ├── CampusLifeApp           # MaterialApp 配置（主题/路由）
│   │   └── MainScreen              # 底部导航 + 页面切换
│   │
│   ├── models/
│   │   └── school_data.dart        # 6个数据模型 + MockData
│   │       ├── Course              # 课程模型（name/teacher/classroom/dayOfWeek/startSlot/duration）
│   │       ├── Dish                # 菜品模型（name/canteen/price/rating）
│   │       ├── Notice              # 公告模型（title/date/content/category）
│   │       ├── CardTransaction     # 交易模型（time/location/amount/balance）
│   │       ├── GradeRecord         # 成绩模型（courseName/credit/score/gradePoint）
│   │       ├── CalendarEvent       # 校历事件（date/title/type）
│   │       └── MockData            # 模拟数据 + 工具方法
│   │
│   ├── providers/
│   │   ├── favorites_provider.dart # 收藏状态管理
│   │   │   ├── FavoritesProvider extends ChangeNotifier
│   │   │   ├── init()             # 从 SharedPreferences 加载
│   │   │   ├── toggleDishFavorite() / toggleNoticeFavorite()
│   │   │   └── favoriteDishes / favoriteNotices (getter)
│   │   │
│   │   └── theme_provider.dart     # 主题状态管理
│   │       ├── ThemeProvider extends ChangeNotifier
│   │       ├── themeMode (getter)  # system/light/dark
│   │       ├── setThemeMode()      # 切换 + 持久化
│   │       ├── notificationsEnabled
│   │       └── fontScale / fontSizeLabel
│   │
│   └── pages/                      # 12个页面
│       ├── splash_page.dart        # 启动动画
│       ├── home_page.dart          # 首页（天气+课程+入口）
│       ├── schedule_page.dart      # 课程表（周视图）
│       ├── canteen_page.dart       # 食堂菜单（Tab筛选）
│       ├── notice_page.dart        # 校园公告（Sheet弹窗）
│       ├── card_page.dart          # 校园卡（交易流水）
│       ├── grade_page.dart         # 成绩查询（GPA）
│       ├── calendar_page.dart      # 校历（月视图）
│       ├── map_page.dart           # 校园地图（建筑）
│       ├── profile_page.dart       # 个人中心
│       ├── favorites_page.dart     # 收藏管理
│       └── settings_page.dart      # 设置
```

## 二、状态管理架构

### Provider 树

```
main() ──▶ MultiProvider
              ├── ChangeNotifierProvider<FavoritesProvider>
              │   ├── CanteenPage (_DishCard)
              │   ├── NoticePage (_NoticeCard)
              │   └── FavoritesPage
              └── ChangeNotifierProvider<ThemeProvider>
                  ├── CampusLifeApp (themeMode)
                  └── SettingsPage
```

### 数据流

```
用户操作 → Provider 方法调用 → _save() 持久化 → notifyListeners()
  ↑                                                      │
  └──────────────────────────────────────────────────────┘
         Consumer Widget 重建 → UI 更新
```

### 状态管理合理性

| 维度 | 说明 |
|------|------|
| **关注点分离** | FavoritesProvider 管收藏，ThemeProvider 管主题，互不干扰 |
| **持久化** | 每次状态变更自动写入 SharedPreferences |
| **响应式** | 使用 Consumer 精确控制重建范围，避免整页重建 |
| **可测试** | Provider 不依赖 UI，可单独测试状态逻辑 |

## 三、数据交互设计

### 本地数据（SharedPreferences）

| Key | Value | 用途 |
|-----|-------|------|
| `favorite_dishes` | `List<String>` | 收藏的菜品名列表 |
| `favorite_notices` | `List<String>` | 收藏的公告标题列表 |
| `theme_mode` | `String` | `system`/`light`/`dark` |
| `notifications` | `bool` | 通知开关 |
| `font_scale` | `int` | 0/1/2（小/中/大） |

### 网络数据（HTTP + JSON）

```
┌──────────┐     GET https://wttr.in/Jiaozuo?format=j1     ┌──────────┐
│ HomePage │ ────────────────────────────────────────────▶ │ wttr.in  │
│          │ ◀──────────────────────────────────────────── │  API     │
│          │     JSON Response                             │          │
└──────────┘     {                                         └──────────┘
                    current_condition: [{
                      temp_C: "28",
                      weatherDesc: [{ value: "晴" }]
                    }]
                  }
```

### 模拟数据（MockData）

所有业务数据使用模拟数据，集中管理在 `school_data.dart` 的 `MockData` 类中：

- 11 门课程（含 1-16周、1-8周不同周期）
- 15 道菜品（5个食堂）
- 8 条公告
- 10 条交易记录
- 14 条成绩记录（2个学期）
- 14 个校历事件

## 四、路由设计

| 路由 | 页面 | 导航方式 |
|------|------|---------|
| `/splash` | SplashPage | 启动路由，2秒后跳转 |
| `/home` | MainScreen | 主界面，含底部导航 |
| `/card` | CardPage | 快捷入口跳转 |
| `/grade` | GradePage | 快捷入口/个人中心跳转 |
| `/calendar` | CalendarPage | 快捷入口跳转 |
| `/map` | MapPage | 快捷入口跳转 |
| `/favorites` | FavoritesPage | 个人中心跳转 |
| `/settings` | SettingsPage | 个人中心跳转 |

## 五、代码清晰度说明

### 命名规范

- **文件**：小写蛇形命名（`home_page.dart`）
- **类**：大驼峰命名（`FavoritesProvider`）
- **方法**：小驼峰命名（`toggleDishFavorite`）
- **私有**：下划线前缀（`_buildCardFace`）

### 组件化

- 每个页面独立文件
- 内部私有组件用下划线类（`_DishCard`、`_ActionBtn`）
- 公共组件可提取到 `widgets/` 目录

### 注释

- 模型类：文档注释（`///`）
- 关键逻辑：行内注释（`//`）
- AI 标注：文件头部 `[AI-GEN]` / `[HUMAN]`
