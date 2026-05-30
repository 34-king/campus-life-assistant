// 🤖 AI Generated — 数据模型与模拟数据
// ✏️ Human Modified — 添加了校园卡、成绩、校历三大新功能的数据模型
// ✏️ 模拟数据改为河南理工大学实际场景

/// 课程数据模型
class Course {
  final String name;
  final String teacher;
  final String classroom;
  final int dayOfWeek; // 1-7
  final int startSlot;
  final int duration;
  final String weeks;

  Course({
    required this.name,
    required this.teacher,
    required this.classroom,
    required this.dayOfWeek,
    required this.startSlot,
    required this.duration,
    this.weeks = '1-16周',
  });
}

/// 食堂菜品
class Dish {
  final String name;
  final String canteen;
  final double price;
  final double rating;
  final String description;

  Dish({
    required this.name,
    required this.canteen,
    required this.price,
    required this.rating,
    this.description = '',
  });
}

/// 校园公告
class Notice {
  final String title;
  final String date;
  final String content;
  final String category;

  Notice({
    required this.title,
    required this.date,
    required this.content,
    required this.category,
  });
}

/// 校园卡消费记录
class CardTransaction {
  final String time;
  final String location;
  final double amount;
  final double balance;
  final bool isIncome; // false = 支出

  CardTransaction({
    required this.time,
    required this.location,
    required this.amount,
    required this.balance,
    this.isIncome = false,
  });
}

/// 成绩记录
class GradeRecord {
  final String courseName;
  final double credit;
  final double score;
  final String gradePoint; // e.g. "4.0"
  final String semester;

  GradeRecord({
    required this.courseName,
    required this.credit,
    required this.score,
    required this.gradePoint,
    required this.semester,
  });
}

/// 校历事件
class CalendarEvent {
  final String date;
  final String title;
  final String type; // holiday, exam, activity, academic

  CalendarEvent({
    required this.date,
    required this.title,
    required this.type,
  });
}

// ========== 模拟数据 ==========

class MockData {
  static List<Course> courses = [
    Course(name: '数据结构与算法', teacher: '王丽华教授', classroom: '计算机楼501', dayOfWeek: 1, startSlot: 1, duration: 2),
    Course(name: '大学英语(三)', teacher: '李静', classroom: '文科楼302', dayOfWeek: 1, startSlot: 3, duration: 2),
    Course(name: '计算机网络', teacher: '刘志刚教授', classroom: '计算机楼408', dayOfWeek: 2, startSlot: 1, duration: 3),
    Course(name: '大学体育(篮)', teacher: '陈鹏', classroom: '体育馆篮球场', dayOfWeek: 2, startSlot: 6, duration: 2),
    Course(name: '操作系统', teacher: '赵俊峰教授', classroom: '计算机楼401', dayOfWeek: 3, startSlot: 1, duration: 3),
    Course(name: '软件工程', teacher: '孙明远', classroom: '计算机楼305', dayOfWeek: 3, startSlot: 5, duration: 2),
    Course(name: '数据库原理', teacher: '张雪梅教授', classroom: '计算机楼502', dayOfWeek: 4, startSlot: 1, duration: 3),
    Course(name: '马克思主义原理概论', teacher: '周书华', classroom: '文科楼101', dayOfWeek: 4, startSlot: 5, duration: 2),
    Course(name: '编译原理', teacher: '黄海波教授', classroom: '计算机楼403', dayOfWeek: 5, startSlot: 1, duration: 2),
    Course(name: 'JavaEE开发', teacher: '任然', classroom: '计算机楼实验中心A', dayOfWeek: 5, startSlot: 3, duration: 3),
    Course(name: '计算机图形学', teacher: '马晓燕', classroom: '计算机楼406', dayOfWeek: 2, startSlot: 3, duration: 2, weeks: '1-8周'),
  ];

  static List<Dish> dishes = [
    Dish(name: '河南烩面', canteen: '学苑餐厅', price: 10.0, rating: 4.8, description: '正宗河南烩面，羊肉汤底+手工扯面'),
    Dish(name: '胡辣汤+油条', canteen: '学苑餐厅', price: 5.0, rating: 4.6, description: '正宗逍遥镇胡辣汤配现炸油条'),
    Dish(name: '宫保鸡丁盖饭', canteen: '学苑餐厅', price: 12.0, rating: 4.3, description: '花生鸡丁+时蔬+米饭'),
    Dish(name: '番茄鸡蛋面', canteen: '学苑餐厅', price: 8.0, rating: 4.1, description: '酸甜番茄鸡蛋浇头手工面'),
    Dish(name: '麻辣香锅', canteen: '学子餐厅', price: 18.0, rating: 4.7, description: '自选食材称重，麻辣鲜香够味'),
    Dish(name: '黄焖鸡米饭', canteen: '学子餐厅', price: 14.0, rating: 4.5, description: '砂锅现焖鸡腿肉+土豆+米饭'),
    Dish(name: '红烧牛肉面', canteen: '学子餐厅', price: 13.0, rating: 4.4, description: '大块卤牛肉+手工拉面'),
    Dish(name: '水饺猪肉白菜', canteen: '学士餐厅', price: 10.0, rating: 4.3, description: '手工现包水饺，蘸醋绝配'),
    Dish(name: '麻辣烫', canteen: '学士餐厅', price: 15.0, rating: 4.2, description: '骨汤底料，自选蔬菜丸子称重'),
    Dish(name: '鸡蛋灌饼', canteen: '学士餐厅', price: 5.0, rating: 4.0, description: '早餐必选，外酥里嫩'),
    Dish(name: '烤鸭饭', canteen: '学府餐厅', price: 16.0, rating: 4.6, description: '现烤鸭腿+秘制酱汁+米饭'),
    Dish(name: '酸菜鱼米线', canteen: '学府餐厅', price: 14.0, rating: 4.5, description: '酸菜鱼片+米线，汤鲜味美'),
    Dish(name: '石锅拌饭', canteen: '学府餐厅', price: 15.0, rating: 4.4, description: '韩式石锅拌饭+煎蛋+辣酱'),
    Dish(name: '牛肉板面', canteen: '教工餐厅', price: 12.0, rating: 4.3, description: '安徽牛肉板面，辣椒够劲'),
    Dish(name: '烤肉拌饭', canteen: '教工餐厅', price: 14.0, rating: 4.2, description: '烤五花肉+蔬菜沙拉+拌饭酱'),
  ];

  static List<Notice> notices = [
    Notice(title: '关于2026年端午节放假安排的通知', date: '2026-05-28', category: '教务通知',
        content: '根据学校安排，2026年端午节放假时间为6月8日至6月10日，共3天。6月11日（星期四）正常上课。请各位同学提前做好假期安排。'),
    Notice(title: '图书馆期末开放时间调整', date: '2026-05-25', category: '图书馆',
        content: '期末临近，图书馆自6月1日起调整为7:00-22:30开放，周末不休息。'),
    Notice(title: '2026年夏季学期选课通知', date: '2026-05-22', category: '教务通知',
        content: '夏季学期选课将于6月5日10:00开始，6月12日17:00截止。请登录教务系统查看可选课程列表。'),
    Notice(title: '校园歌手大赛决赛预告', date: '2026-05-20', category: '校园活动',
        content: '校园歌手大赛决赛将于6月2日晚19:00在体育馆举行。凭学生证入场。'),
    Notice(title: '关于学生证补办的通知', date: '2026-05-18', category: '行政事务',
        content: '学生证丢失的同学请于每周二、四下午14:00-17:00到行政楼201办理补办手续。'),
    Notice(title: '计算机等级考试报名通知', date: '2026-05-15', category: '考试信息',
        content: '2026年9月全国计算机等级考试报名时间为6月1日-6月20日。'),
    Notice(title: '关于校园网升级维护的通知', date: '2026-05-12', category: '后勤通知',
        content: '为提升网络体验，信息化中心将于5月30日-31日对校园网核心设备进行升级维护。'),
    Notice(title: '2026届毕业生离校手续办理通知', date: '2026-05-10', category: '行政事务',
        content: '2026届毕业生请于6月15日-25日办理离校手续。'),
  ];

  // ========== 校园卡数据 ==========
  static const double cardBalance = 186.50;
  static const double todayConsumption = 23.50;

  static List<CardTransaction> cardTransactions = [
    CardTransaction(time: '2026-05-30 12:10', location: '学苑餐厅', amount: 10.0, balance: 186.50),
    CardTransaction(time: '2026-05-30 07:35', location: '学士餐厅', amount: 5.0, balance: 196.50),
    CardTransaction(time: '2026-05-29 18:20', location: '学子餐厅', amount: 14.0, balance: 201.50),
    CardTransaction(time: '2026-05-29 12:05', location: '学苑餐厅', amount: 10.0, balance: 215.50),
    CardTransaction(time: '2026-05-29 07:30', location: '学士餐厅', amount: 5.0, balance: 225.50),
    CardTransaction(time: '2026-05-28 12:15', location: '学府餐厅', amount: 16.0, balance: 230.50),
    CardTransaction(time: '2026-05-28 07:35', location: '学士餐厅', amount: 5.0, balance: 246.50),
    CardTransaction(time: '2026-05-27 18:30', location: '学苑超市', amount: 8.5, balance: 251.50),
    CardTransaction(time: '2026-05-26 12:10', location: '学子餐厅', amount: 14.0, balance: 260.00),
    CardTransaction(time: '2026-05-25 08:00', location: '校园卡充值', amount: 200.0, balance: 274.00, isIncome: true),
  ];

  // ========== 成绩数据 ==========
  static List<GradeRecord> grades = [
    GradeRecord(courseName: '高等数学A(上)', credit: 5.0, score: 92, gradePoint: '4.0', semester: '2025-2026-1'),
    GradeRecord(courseName: '大学英语(二)', credit: 4.0, score: 88, gradePoint: '3.7', semester: '2025-2026-1'),
    GradeRecord(courseName: 'C语言程序设计', credit: 4.0, score: 95, gradePoint: '4.0', semester: '2025-2026-1'),
    GradeRecord(courseName: '线性代数', credit: 3.0, score: 85, gradePoint: '3.5', semester: '2025-2026-1'),
    GradeRecord(courseName: '大学物理A(上)', credit: 4.0, score: 82, gradePoint: '3.3', semester: '2025-2026-1'),
    GradeRecord(courseName: '思想政治修养', credit: 2.0, score: 90, gradePoint: '4.0', semester: '2025-2026-1'),
    GradeRecord(courseName: '数据结构与算法', credit: 4.0, score: 91, gradePoint: '4.0', semester: '2025-2026-2'),
    GradeRecord(courseName: '大学英语(三)', credit: 4.0, score: 86, gradePoint: '3.7', semester: '2025-2026-2'),
    GradeRecord(courseName: '计算机网络', credit: 3.0, score: 78, gradePoint: '3.0', semester: '2025-2026-2'),
    GradeRecord(courseName: '操作系统', credit: 4.0, score: 88, gradePoint: '3.7', semester: '2025-2026-2'),
    GradeRecord(courseName: '数据库原理', credit: 3.0, score: 84, gradePoint: '3.5', semester: '2025-2026-2'),
    GradeRecord(courseName: '软件工程', credit: 2.0, score: 90, gradePoint: '4.0', semester: '2025-2026-2'),
    GradeRecord(courseName: '计算机图形学', credit: 2.0, score: 95, gradePoint: '4.0', semester: '2025-2026-2'),
    GradeRecord(courseName: 'JavaEE开发', credit: 3.0, score: 82, gradePoint: '3.3', semester: '2025-2026-2'),
  ];

  static List<String> get semesters =>
      grades.map((g) => g.semester).toSet().toList()..sort();

  static List<GradeRecord> getGradesBySemester(String semester) =>
      grades.where((g) => g.semester == semester).toList();

  /// 计算某学期 GPA
  static double calculateGPA(List<GradeRecord> records) {
    if (records.isEmpty) return 0.0;
    final totalPoints = records.fold<double>(
        0, (sum, r) => sum + double.parse(r.gradePoint) * r.credit);
    final totalCredits = records.fold<double>(0, (sum, r) => sum + r.credit);
    return totalCredits > 0 ? (totalPoints / totalCredits) : 0.0;
  }

  // ========== 校历数据 ==========
  static List<CalendarEvent> calendarEvents = [
    CalendarEvent(date: '2026-06-01', title: '儿童节', type: 'holiday'),
    CalendarEvent(date: '2026-06-02', title: '校园歌手大赛决赛', type: 'activity'),
    CalendarEvent(date: '2026-06-05', title: '夏季选课开始', type: 'academic'),
    CalendarEvent(date: '2026-06-08', title: '端午节放假', type: 'holiday'),
    CalendarEvent(date: '2026-06-09', title: '端午节放假', type: 'holiday'),
    CalendarEvent(date: '2026-06-10', title: '端午节放假', type: 'holiday'),
    CalendarEvent(date: '2026-06-12', title: '选课截止', type: 'academic'),
    CalendarEvent(date: '2026-06-15', title: '毕业生离校办理', type: 'academic'),
    CalendarEvent(date: '2026-06-20', title: '英语四六级考试', type: 'exam'),
    CalendarEvent(date: '2026-06-22', title: '期末考试周开始', type: 'exam'),
    CalendarEvent(date: '2026-06-25', title: '毕业生离校截止', type: 'academic'),
    CalendarEvent(date: '2026-07-03', title: '期末考试结束', type: 'exam'),
    CalendarEvent(date: '2026-07-06', title: '暑假开始', type: 'holiday'),
    CalendarEvent(date: '2026-09-01', title: '新学期开学', type: 'academic'),
  ];

  /// 获取指定月份的校历事件
  static List<CalendarEvent> getEventsForMonth(int year, int month) {
    final prefix = '$year-${month.toString().padLeft(2, '0')}';
    return calendarEvents.where((e) => e.date.startsWith(prefix)).toList();
  }

  /// 获取指定日期的事件
  static List<CalendarEvent> getEventsForDate(String date) {
    return calendarEvents.where((e) => e.date == date).toList();
  }

  // ========== 工具方法 ==========
  static List<Course> getCoursesForDay(int day) {
    return courses.where((c) => c.dayOfWeek == day).toList()
      ..sort((a, b) => a.startSlot.compareTo(b.startSlot));
  }

  static List<String> get canteens =>
      dishes.map((d) => d.canteen).toSet().toList();

  static List<Dish> getDishesByCanteen(String canteen) {
    return dishes.where((d) => d.canteen == canteen).toList();
  }

  static String weekdayName(int day) {
    const names = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return names[day - 1];
  }

  static String slotTime(int slot) {
    const times = {
      1: '08:00-08:45', 2: '08:55-09:40', 3: '10:00-10:45',
      4: '10:55-11:40', 5: '14:30-15:15', 6: '15:25-16:10',
      7: '16:30-17:15', 8: '17:25-18:10', 9: '19:30-20:15', 10: '20:25-21:10',
    };
    return times[slot] ?? '';
  }
}
