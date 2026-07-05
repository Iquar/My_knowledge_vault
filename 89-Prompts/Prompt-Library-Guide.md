---
tags: [system/prompts, guide]
created: 2026-07-06
updated: 2026-07-06
---

# Prompt Library Guide

## 设计原则
1. **可复用**: 每个 Prompt 经过测试后入库
2. **参数化**: 使用 `{{placeholder}}` 标记可变部分
3. **版本管理**: 记录每次修改和效果迭代
4. **场景标注**: 每个 Prompt 标注适用场景和平台

## Prompt 生命周期
1. **实验**: 在对话中测试，记录效果
2. **入库**: 使用 Prompt Template 存入对应分类目录
3. **迭代**: 根据实际使用效果更新版本
4. **归档**: 不再使用的 Prompt 移至 99-Archive

## 分类说明
| 目录 | 用途 |
|------|------|
| Research/ | 研究分析、信息提取、总结 |
| Workflow/ | 工作流自动化、流程优化 |
| Automation/ | 代码生成、脚本、自动化 |
| Business/ | 商业分析、策略、市场 |
| Content/ | 通用内容创作 |
| Video-Script/ | 视频脚本撰写 |
| Cover-Design/ | 封面、配图设计 |

## 命名规范
`{序号}_{用途说明}_{平台/工具}.md`
- 序号: 两位数字 (01, 02, ...)
- 用途说明: 简短英文
- 平台/工具: 可选，标注适用平台
