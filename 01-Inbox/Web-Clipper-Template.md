---
tags: [system/clipper, template]
created: 2026-07-06
---

# Research Capture Template (Web Clipper)

## Obsidian Web Clipper 配置
将此模板设置为 Obsidian Web Clipper 的默认捕获模板。

## 模板内容
```
---
title: "{{title}}"
source: "{{url}}"
author: "{{author}}"
date: "{{date|date:'YYYY-MM-DD'}}"
created: "{{date|date:'YYYY-MM-DD HH:mm'}}"
platform: "{{domain}}"
tags: [research, source/web-clip]
---

# {{title}}

> 原文链接: {{url}}
> 作者: {{author}}
> 发布日期: {{published}}

## 核心内容
{{content}}

## 我的笔记
- 
```

## 保存路径
`01-Inbox/Downloaded/{{date|date:'YYYY-MM-DD'}}_{{title}}.md`

## 安装步骤
1. 安装 Obsidian Web Clipper 浏览器扩展
2. 在扩展设置中选择此 Vault
3. 将上述模板粘贴到 Web Clipper 的模板设置中
4. 设置保存路径为 `01-Inbox/Downloaded`
