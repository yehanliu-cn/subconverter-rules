# AI Rules Upstream Layout

当前 AI 规则采用“上游维护 + 本地补丁”的结构：

- `💬 Claude`
  - 上游主规则：`blackmatrix7/ios_rule_script` 的 `Claude.list`
  - 本地补丁：`claude/claude.list`

- `💬 ChatGPT+Gemini`
  - 上游主规则：
    - `blackmatrix7/ios_rule_script` 的 `OpenAI.list`
    - `blackmatrix7/ios_rule_script` 的 `Gemini.list`
  - 本地补丁：`ai/chatgpt_gemini.list`

- `💬 其他海外AI`
  - 仍由本仓库维护：`other-ai/other_ai.list`

本地补丁文件只保留以下内容：

- 上游未覆盖但你已验证必须补充的域名
- 你自己的 Google 服务 / Google Play / 特殊 AI 域名偏好
- 与 Magic Catling 运行实际行为相关的补充项

长期维护建议：

1. 优先观察上游是否已收录新域名
2. 只有上游未覆盖、且你已验证必须补充时，再改本地补丁文件
3. 不要把大批通用域名重新复制回本地补丁，避免再次回到“全量手维护”
