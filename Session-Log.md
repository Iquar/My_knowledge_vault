---
tags: [system/log]
created: 2026-07-19
---

# Session Log

## 2026-07-19 — 知识库精简与重构

### 变更摘要

1. **精简知识库** — 仅保留 Inbox + Research，删除其他所有目录
   - 删除：`05-Content/`, `06-Projects/`, `89-Prompts/`, `90-Templates/`, `97-AI-Memory/`, `98-AI-Context/`, `99-Archive/`
   - 删除根目录：`GitHub-Sync-Setup.bat`, `Knowledge-Base-Audit-Report.md`
   - 保留：`00-Inbox`, `04-Research`, `attachments`, `.obsidian`, `.gitignore`

2. **目录重编号**
   - `04-Research` → `01-Research`
   - `00-Inbox` 保持不变
   - 更新了所有内部引用（脚本、Markdown 文件、Topic Hub 的 Dataview 查询）

3. **GitHub 仓库迁移**
   - 旧 remote：`github.com/Iquar/Codex_obsidian`
   - 新 remote：`github.com/Iquar/My_knowledge_vault`
   - Git 代理已配置：`http://127.0.0.1:7890`

4. **自动同步配置**
   - Obsidian Git 插件：每 10 分钟自动 commit，每 30 分钟自动 push

### 当前目录结构

```
My_knowledge_vault/
├── 00-Inbox/          # 收件箱（收集 → 清洗 → 归档）
├── 01-Research/       # 研究库（A 股投资笔记 + Topic Hubs）
│   ├── _Topic-Hubs/   # 8 个主题中心页
│   └── 雕刻韭菜/      # A 股投资研究（主内容）
├── attachments/       # 图片附件
├── .obsidian/         # Obsidian 配置（含 Git + Dataview 插件）
└── .gitignore
```

### 待处理
- 管道尚未实际跑通（`Downloaded`、`Cleaned` 子目录不存在）
- 其他 5 个研究领域（AI、Crypto、美股、编程、量化）尚无内容
