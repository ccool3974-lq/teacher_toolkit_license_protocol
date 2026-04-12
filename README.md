# Teacher Toolkit License Protocol

`Teacher Toolkit License Protocol` 是 `teacher_hub` 与 `teacher_hub_license_manager` 的共享授权协议库。

## 作用

- 定义 `LicensePayload`
- 定义协议前缀、产品标识与协议版本
- 提供 payload 的编码与解码规则
- 统一声明首次激活截止日期等跨端生效的授权字段
- 作为发码端与验权端的共同协议基础

## 不包含的能力

- 私钥
- 正式发码逻辑
- 客户端验签页面
- 数据库存储
