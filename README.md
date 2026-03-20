# Subconverter 自定义规则

自定义分流规则，用于 AI 服务和流媒体。

## 规则文件

| 文件 | 用途 | 锁定节点 |
|------|------|----------|
| `claude/claude.list` | Claude 独立规则 | 手动切换1-6 |
| `ai/chatgpt_gemini.list` | ChatGPT+Gemini+Copilot+YouTube+FCM | 手动切换1-6+直连 |
| `other-ai/other_ai.list` | 其他海外AI（剔除Claude） | 手动切换1-6+直连 |
| `china/china_direct.list` | 国内直连（字节/百度/阿里/腾讯/国内AI） | 直连 |

## 使用方法

在 subconverter 配置中引用：
```ini
ruleset=💬 Claude,https://raw.githubusercontent.com/yehanliu-cn/subconverter-rules/main/claude/claude.list
ruleset=💬 ChatGPT+Gemini,https://raw.githubusercontent.com/yehanliu-cn/subconverter-rules/main/ai/chatgpt_gemini.list
ruleset=💬 其他海外AI,https://raw.githubusercontent.com/yehanliu-cn/subconverter-rules/main/other-ai/other_ai.list
ruleset=🇨🇳 国内直连,https://raw.githubusercontent.com/yehanliu-cn/subconverter-rules/main/china/china_direct.list
```

## 更新记录

- 2026-03-20: 初始版本（Claude/ChatGPT+Gemini/其他海外AI/国内直连）
