# Teacher Toolkit License Protocol 实施计划

## Phase 1：协议骨架

- 建立协议库目录
- 提供协议常量
- 提供版本号
- 提供统一导出入口

## Phase 2：授权载荷模型

- 定义 `LicenseTier`
- 定义 `LicensePayload`
- 提供 `toMap / fromMap`

## Phase 3：编解码规则

- 定义 payload 的 JSON 结构
- 定义 Base64Url 编解码
- 增加协议测试

## Phase 4：协议演进

- 支持协议版本升级
- 为后续授权文件格式扩展预留结构
