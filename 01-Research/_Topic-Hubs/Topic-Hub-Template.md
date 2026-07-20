---
tags: [system/topics, hub-template]
created: 2026-07-06
---

# Topic Hub Template

> 本模板用于创建主题中心页。将 `{{Topic}}` 替换为实际主题名。

---

# {{Topic}} Hub

## 概述
{{description}}

## 相关笔记
```dataview
LIST
FROM "01-Research"
WHERE contains(tags, "topic/{{topic_slug}}")
SORT file.cday DESC
```

## 核心概念
- 

## 相关工具
- 

## 相关 Topic Hub
- 

## 外部资源
- 
