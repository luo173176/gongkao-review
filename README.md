# 考公复盘（gongkao-review）

公务员考试套卷复盘工具。不是笔记应用，而是一个完整的复盘闭环：

> 记录套卷 → 录入各模块正确率与用时 → 标记错题与错因 → 生成复盘结论 → 创建行动项 → 追踪统计趋势 → 沉淀知识卡片 → 下次复盘检查上次行动项

- **离线优先**：所有数据保存在手机本地 SQLite（Drift），不依赖任何后端。
- **平台**：Android APK。
- **当前版本**：v0.1.0

## 功能

| 模块 | 说明 |
| --- | --- |
| 仪表盘 | 考试倒计时、今日到期行动项、最近一次套卷正确率、正确率趋势、快捷入口 |
| 套卷记录 | 新增/编辑/删除套卷；行测五大固定模块（常识判断、言语理解、数量关系、判断推理、资料分析）录入总题数/正确数/用时/目标正确率；申论按题型记录得分、问题、改进点 |
| 错题本 | 错题录入与检索；错因分类（知识不会、方法不熟、粗心、审题错、时间不够、蒙对、蒙错、其他）；支持标签、搜索、按模块/错因筛选 |
| 复盘报告 | KPT / PDCA 双模板；自动汇总本套卷各模块正确率、错因分布；显示上次未完成行动项；「行动」一栏可一键生成行动项 |
| 行动项 | 标题、负责人、截止日期、优先级、状态；逾期高亮；完成勾选；可关联套卷/错题 |
| 统计 | 正确率趋势、模块强弱对比、时间分配、错因分布（饼图）、行动项完成率；支持近 7 天 / 近 30 天 / 全部 |
| 知识卡片 | 行测公式、申论素材、面试题、经验卡片；标签、搜索、收藏 |
| 数据管理 | 导出 JSON 备份 / 导出错题 CSV（Excel 可读）/ 导入 JSON 恢复 / 清空数据 |
| 设置 | 考试日期、目标分数、负责人、深色模式 |

## 截图

<!-- TODO: 发布后替换为真实截图 -->
![仪表盘占位](docs/screenshots/home.png)
![统计占位](docs/screenshots/stats.png)

> 截图占位，欢迎自建后补图。

## 安装 APK

1. 到 [Releases](https://github.com/luo173176/gongkao-review/releases) 页面下载最新 `app-release.apk`。
2. 手机上点开安装；系统提示「未知来源」时，允许该来源安装即可。
3. APK 未做应用商店签名，属调试签名发布版，仅个人使用。

## 本地构建

环境要求：Flutter stable 3.x、JDK 17、Android SDK（API 35+）。

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # 生成 drift 代码
flutter analyze
flutter test
flutter build apk --release
# 产物：build/app/outputs/flutter-apk/app-release.apk
```

国内网络建议先设置镜像：

```bash
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

## GitHub Actions 构建

仓库内置工作流 [.github/workflows/build-apk.yml](.github/workflows/build-apk.yml)：

- 触发：push `v*` 标签，或 Actions 页面手动触发（workflow_dispatch）。
- 环境：Ubuntu + Temurin JDK 17 + Flutter stable。
- 步骤：pub get → build_runner 生成代码 → analyze → test → 构建 release APK → 上传 artifact。
- 若由 `v*` 标签触发，自动创建 GitHub Release 并附上 APK。

手动触发一次构建：仓库 Actions 页 → Build APK → Run workflow。

## 项目结构

```
lib/
├── models/       # 固定枚举（模块、错因、优先级…）
├── db/           # Drift 表定义与数据库
├── providers/    # Riverpod 状态与数据流
├── services/     # 统计、备份(JSON)、CSV 纯函数
├── pages/        # 页面（首页/套卷/错题/统计/我的…）
├── widgets/      # 通用组件
├── router.dart   # go_router 路由与底部导航
└── main.dart
```

## 技术栈

Flutter stable · Dart 3 · Material 3 · Riverpod · go_router · Drift(SQLite) · fl_chart · intl · share_plus · file_picker

## 说明

- 不内置任何题库内容，仅提供用户自行录入与本地存储。
- 欢迎提 issue 反馈问题。

## License

仅供学习与个人使用。
