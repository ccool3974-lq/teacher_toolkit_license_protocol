# Teacher Toolkit License Protocol

`Teacher Toolkit License Protocol` 是 `teacher_hub` 与 `teacher_hub_license_manager` 共享的离线授权密钥协议库。

## 作用

- 定义 `LicensePayload`
- 定义协议前缀、产品标识与协议版本，当前结构化前缀为 `TTK3`
- 提供 payload 的编码与解码规则
- 提供发码前与激活前可复用的纯 Dart payload 校验规则
- 统一声明离线授权密钥字段：产品、授权编号、绑定姓名、可选绑定用户码、有效天数、永久授权标记、签发时间、激活截止时间与 nonce
- 作为发码端与验权端的共同协议基础，不按免费版、基础版、高级版或功能点授权

## 不包含的能力

- 私钥
- 正式签名逻辑
- 正式发码逻辑或发码工具
- 客户端验签页面
- Flutter UI
- 数据库存储
- SharedPreferences 或文件存储
