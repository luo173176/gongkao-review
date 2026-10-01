// 全局固定枚举值。
// 直接以中文存储到数据库，便于展示与导出，避免额外的映射层。

const List<String> examTypes = ['国考', '省考', '事业单位', '模考'];

/// 行测固定五大模块
const List<String> xingceModules = ['常识判断', '言语理解', '数量关系', '判断推理', '资料分析'];

const List<String> wrongReasons = [
  '知识不会',
  '方法不熟',
  '粗心',
  '审题错',
  '时间不够',
  '蒙对',
  '蒙错',
  '其他',
];

const List<String> priorities = ['高', '中', '低'];

const List<String> actionStatuses = ['待办', '进行中', '完成'];

const List<String> cardTypes = ['行测公式', '申论素材', '面试题', '经验卡片'];
