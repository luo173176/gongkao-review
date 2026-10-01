import '../db/app_db.dart';

/// 错题 CSV 导出（纯函数，便于测试）。
/// 文件带 BOM，Excel 打开中文不乱码。

class MistakeCsvRow {
  const MistakeCsvRow({required this.examName, required this.mistake});
  final String examName;
  final Mistake mistake;
}

String csvEscape(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n') || value.contains('\r')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}

const List<String> mistakeCsvHeaders = [
  '所属套卷',
  '模块',
  '知识点',
  '题目摘要',
  '我的答案',
  '正确答案',
  '错误原因',
  '正确思路',
  '改进动作',
  '标签',
  '创建时间',
];

String mistakesCsv(List<MistakeCsvRow> rows) {
  final buf = StringBuffer('\uFEFF');
  buf.writeln(mistakeCsvHeaders.map(csvEscape).join(','));
  for (final row in rows) {
    final m = row.mistake;
    final cells = [
      row.examName,
      m.module,
      m.knowledgePoint,
      m.question,
      m.myAnswer,
      m.correctAnswer,
      m.wrongReason,
      m.correctIdea,
      m.action,
      m.tags,
      m.createdAt.toIso8601String(),
    ].map(csvEscape).join(',');
    buf.writeln(cells);
  }
  return buf.toString();
}
