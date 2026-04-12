# Teacher Toolkit License Protocol 设计文档

## 1. 目标

本项目用于统一 `teacher_hub` 与 `teacher_hub_license_manager` 的授权协议定义，避免两边各维护一套不一致的授权结构。

## 2. 核心对象

- `LicenseTier`
- `LicensePayload`
- 协议常量
- 协议版本号
- 编解码规则

## 3. 设计原则

- 纯 Dart
- 不持有私钥
- 不承担 UI 与数据库职责
- 通过统一测试保证协议稳定
