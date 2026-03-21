# Router Light Plan

目标：

- AI 仅允许 `🔒 手动切换1-6`
- Google 通用服务单独分组，不再与 Gemini / ChatGPT 绑死
- Netflix 默认锁定香港
- 常见海外服务单独进 `🌐 全球服务`
- 常见 NSFW / 海外站点通过 `Loyalsoldier proxy.txt` 统一进 `🌐 全球服务`
- 其他服务走最快节点
- 保留 `🔒 手动切换1-6`
- 降低规则总量，减少路由器端不稳定

对应配置文件：

- `/root/subconverter-rules/config/router_light.ini`

与现有 `custom_rules.ini` 的区别：

1. AI 组不再自动选国家组，只允许 `🔒 手动切换1-6`
2. 不再引入 `ChinaIp.list` / `ChinaCompanyIp.list` / `ChinaMedia.list` / `UnBan.list` / `proxy-gfw-no-ai.list`
3. 只保留：
   - AI
   - Google 通用服务
   - Netflix
   - 常见海外服务
   - 主要 NSFW 站点
   - 国内直连
   - 自动兜底
4. 保留 `🔒 手动切换1-6`，方便人工锁节点
5. `🐟 漏网之鱼` 默认 `DIRECT`，但显式提供 `🌐 全球服务`、国家组、`🔒 手动切换1-6` 作为人工兜底
6. 删除明显重复项：
   - 单独的 `chat.openai.com`
   - `NetflixIP.list`
   - `claude.list` 中与上游重复的核心域名 / 通用第三方域名

适用场景：

- 路由器现网主订阅
- 追求稳定而不是大而全
- 桌面端另走自己的客户端配置
