---
tags: [system/inbox, workflow]
created: 2026-07-06
---

# Research Collection Workflow

## 完整流程
```mermaid
flowchart LR
    A[Web Clipper] --> B[Downloaded]
    C[MarkDownload] --> B
    D[手动输入] --> B
    B --> E[Research Cleaner]
    E --> F[Cleaned]
    F --> G[01-Research 分类归档]
    G --> H[添加标签 + Topic Hub 链接]
```

## 每日操作
1. 检查 `01-Inbox/Downloaded` 是否有新文件
2. 运行 Research Cleaner 处理新文件
3. 将清洗后的文件移入对应 Research 子目录
4. 更新 Topic Hub 索引

## 每周操作
1. 清空 `01-Inbox/Cleaned`
2. 检查孤立的 `Attachments`
3. 更新 Knowledge Graph 链接
