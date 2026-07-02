# Teacher Toolkit License Protocol 设计文档

## 1. 目标

本项目用于统一 `teacher_hub` 与 `teacher_hub_license_manager` 的离线授权密钥协议定义，避免两边各维护一套不一致的 payload 结构、协议常量与纯 Dart 校验规则。

## 2. 核心对象

- `LicensePayload`
- `LicenseCodec`
- `LicensePayloadValidator`
- 协议常量
- 协议版本号
- 编码与解码规则

`LicensePayload` 当前字段为：

- `product`
- `licenseId`
- `bindName`
- `bindUserCode`
- `durationDays`
- `permanent`
- `issuedAt`
- `activationDeadline`
- `nonce`

协议库不再定义免费版、基础版、高级版分层，也不再定义功能点授权字段。

## 3. 设计原则

- 纯 Dart
- 不持有私钥
- 不实现正式签名逻辑
- 不承担 UI、数据库、SharedPreferences 或文件存储职责
- 通过统一测试保证协议稳定
