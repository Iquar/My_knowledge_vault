---
tags: [system/projects, template]
created: 2026-07-06
---

# Project Status Template

## 使用说明
每个项目在 `06-Projects/` 下创建独立文件夹，文件夹内必须包含 `Project-Status.md`。

## Project-Status.md 模板

```
---
tags: [project, {{project_tag}}]
created: {{date}}
updated: {{date}}
status: {{status}}
---

# {{project_name}} - Project Status

## 当前状态
- **状态**: {{status}}
- **开始日期**: {{start_date}}
- **目标完成**: {{target_date}}
- **完成度**: {{progress}}%

## 已完成
- [x] 

## 待办事项
- [ ] 

## 下一步（优先级排序）
1. 
2. 
3. 

## 风险 & 阻塞项
| 风险 | 影响 | 缓解措施 | 状态 |
|------|------|----------|------|
| | | | |

## 决策记录
| 日期 | 决策 | 理由 |
|------|------|------|
| | | |

## 相关资源
- [[ ]]
```

## 状态值
- `planning`: 规划中
- `active`: 进行中
- `paused`: 暂停
- `completed`: 已完成
- `archived`: 已归档
