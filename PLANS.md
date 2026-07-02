# Teacher Toolkit License Protocol 实施计划

## 当前实现状态：去版本化离线密钥协议

- 协议版本已升级为 `2`
- 结构化前缀已升级为 `TTK3`，用于区分旧版本控制授权码
- `LicensePayload` 已移除 `tier` 与 `features`
- `LicensePayload` 已保留离线登录密钥所需字段：`product`、`licenseId`、`bindName`、`bindUserCode`、`durationDays`、`permanent`、`issuedAt`、`activationDeadline`、`nonce`
- 已提供 `LicenseCodec` 的 payloadSegment 编码与解码
- 已提供 `LicensePayloadValidator` 的发码前与激活前纯 Dart 校验规则
- 本协议库尚未表示 `teacher_hub` 或 `teacher_hub_license_manager` 已完成接入；两端同步前不能混用新旧协议

## Phase 1：协议骨架

- 建立协议库目录
- 提供协议常量
- 提供版本号
- 提供统一导出入口

## Phase 2：授权载荷模型

- 定义 `LicensePayload`
- 提供 `toMap / fromMap`
- 移除版本分层与功能点授权字段

## Phase 3：编解码规则

- 定义 payload 的 JSON 结构
- 定义 Base64Url 编解码
- 增加协议测试

## Phase 4：离线密钥有效期校验

- 支持协议版本升级
- 提供发码前 payload 校验
- 提供激活前 payload 校验
