# Router Notes

## Purpose

This directory stores router-side reference material that is intentionally
separate from the general rule sources in `config/custom_rules.ini`.

The current confirmed production direction is:

- Rules are maintained in GitHub and consumed through the remote subscription.
- Router runtime DNS is managed separately on the router/plugin side.
- Claude, ChatGPT+Gemini, and other overseas AI groups stay on manual switch
  groups to avoid region drift and account risk.

## Files

- `router_dns_fake_ip.yaml`
  - Verified router DNS reference using `fake-ip`
  - Intended for manual router/plugin DNS configuration
  - Not consumed directly by `subconverter`

## Important Notes

### 1. Static YAML exports are not the source of truth

Static exports such as local `AP_lyhjfc.yaml` should be treated as temporary
troubleshooting artifacts only.

The long-term source of truth is:

- GitHub rule files
- Remote subscription output
- Router runtime DNS configuration

### 2. `proxy-gfw-no-ai.list` is a self-hosted dependency

`config/custom_rules.ini` currently uses:

```ini
ruleset=🚀 节点选择,https://sub-cover.lyhpaul.top/proxy-gfw-no-ai.list
```

This avoids AI domains being reintroduced into `🚀 节点选择`, but it is a
single self-hosted dependency.

If `sub-cover.lyhpaul.top` becomes unavailable, a future improvement should add
one of these:

- a GitHub-hosted mirror of the same list
- a documented fallback to a slimmer upstream list such as ACL4SSR ProxyLite

### 3. Router DNS should be versioned as reference, not forced globally

The router DNS fix is intentionally stored as a reference file instead of being
forced into the generic rule config, because:

- router plugins and Mihomo builds differ in behavior
- desktop and mobile clients should not inherit router runtime DNS blindly
- router DNS changes are operational settings, not just rule-source changes
