# Sub2clash 规则仓库

这个仓库现在只保留 `sub2clash` 需要的规则文件、路由器自定义规则，以及少量维护脚本。

未来文档说明统一以本文件为准，不再拆分多个 `.md`。

## 仓库结构

| 文件 | 用途 |
|------|------|
| `claude/claude.list` | Claude 本地补丁规则 |
| `ai/chatgpt_gemini.list` | ChatGPT / Gemini 本地补丁规则 |
| `ai/chatgpt_patch.list` | ChatGPT 补丁规则 |
| `ai/gemini_patch.list` | Gemini 补丁规则 |
| `other-ai/other_ai.list` | 其他海外 AI 规则 |
| `china/china_direct.list` | 国内直连 |
| `google/google_services.list` | Google 通用服务 |
| `global/outlook_office.list` | Outlook / Office 直连 |
| `global/nsfw_sites.list` | 常见海外 NSFW / 特殊站点 |
| `router/magic_catling_custom_rules.txt` | `sub2clash` / 路由器自定义规则模板 |
| `router/magic_catling_custom_rule_encoded.yaml` | 编码版路由规则 |
| `scripts/sync_github.sh` | 本地与 GitHub 双向同步脚本 |

## 使用方式

按你的 `sub2clash` 配置直接引用规则文件，或使用 `router/` 下的模板生成路由规则。

如果要和 GitHub 仓库保持双向最新，执行：

```bash
bash scripts/sync_github.sh
```

脚本行为：

- 工作区必须干净，否则直接退出，避免覆盖未提交改动
- 远端领先时仅拉取更新本地
- 本地领先时仅推送到 GitHub
- 双方都有新提交时先 `rebase` 再推送

## AI 规则维护原则

当前 AI 规则采用“上游维护 + 本地补丁”的结构，避免再次回到全量手工维护。

### Claude

- 上游主规则：`blackmatrix7/ios_rule_script` 的 `Claude.list`
- 本地补丁：`claude/claude.list`

### ChatGPT + Gemini

- 上游主规则：
  - `blackmatrix7/ios_rule_script` 的 `OpenAI.list`
  - `blackmatrix7/ios_rule_script` 的 `Gemini.list`
- 本地补丁：`ai/chatgpt_gemini.list`

### 其他海外 AI

- 仍由本仓库维护：`other-ai/other_ai.list`

本地补丁文件只保留以下内容：

- 上游未覆盖但已验证必须补充的域名
- 你自己的 Google 服务 / Google Play / 特殊 AI 域名偏好
- 与 Magic Catling 实际运行行为相关的补充项

长期维护建议：

1. 先观察上游是否已收录新域名。
2. 只有上游未覆盖、且你已验证必须补充时，再改本地补丁文件。
3. 不要把大批通用域名重新复制回本地补丁。

## Router Light 方案

当前路由器轻量方案的目标是：

- AI 仅允许 `🔒 手动切换1-6`
- Google 通用服务单独分组，不再与 Gemini / ChatGPT 绑死
- Netflix 默认锁定香港
- 常见海外服务单独进 `🌐 全球服务`
- 常见 NSFW / 海外站点统一进 `🌐 全球服务`
- 其他服务走最快节点
- 降低规则总量，减少路由器端不稳定

对应主模板：

- `router/magic_catling_custom_rules.txt`

设计取向：

1. AI 组不自动选国家组，只允许手动锁定节点。
2. 只保留核心规则分类，避免路由器规则过大。
3. `🐟 漏网之鱼` 默认 `DIRECT`，但保留人工兜底分流。
4. 桌面端和路由器端配置思路分离，路由器优先稳定。

适用场景：

- 路由器现网主订阅
- 追求稳定而不是大而全
- 桌面端另走自己的客户端配置

## 维护约定

- 新的说明文档优先直接补充到 `README.md`
- 除非必须拆分专题文档，否则不要再新增独立说明 `.md`
- 修改规则时，顺手更新本文件对应说明，避免规则和文档脱节

## 更新记录

- 2026-04-15: 合并分散说明到 `README.md`，作为唯一文档入口
- 2026-04-15: 移除 `subconverter` 配置，仅保留 `sub2clash` 相关规则与说明
