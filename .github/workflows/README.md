# GitHub Actions

`flutter.yml` 提供三类任务：

- `verify`：Push 和 Pull Request 都会执行格式检查、`flutter analyze` 和 `flutter test`。
- `build-android`：读取 Android 签名 Secrets，构建 signed release APK 并上传为 Artifact。
- `build-ios`：使用 GitHub 的 macOS runner 读取签名 Secrets，按 App Store Connect 发布方式构建 iPhone/iPad 的签名 IPA，并上传为 Artifact。

## 手动打包

1. 打开 GitHub 仓库的 **Actions** 页面。
2. 选择 **Flutter CI and Android Build**。
3. 点击 **Run workflow**。
4. 完成后在任务的 **Artifacts** 区域下载 `flutter-starter-apk-signed` 或 `flutter-starter-ios-signed`。

## 签名发布

Android Job 需要在 GitHub 仓库的 **Settings → Secrets and variables → Actions** 中配置：

- `ANDROID_KEYSTORE_BASE64`：Android Keystore/JKS 文件转 Base64
- `ANDROID_KEYSTORE_PASSWORD`：Keystore 密码
- `ANDROID_KEY_ALIAS`：Key alias
- `ANDROID_KEY_PASSWORD`：Key 密码

Workflow 会临时生成 `android/key.properties` 和 `android/upload-keystore.jks`，构建完成后随 runner 销毁。不要把 Keystore、密码或 `key.properties` 提交到仓库。

iOS Job 构建的是签名 IPA，目标平台是 iPhone/iPad，不是 macOS。需要在 GitHub 仓库的 **Settings → Secrets and variables → Actions** 中配置：

- `IOS_CERTIFICATE_BASE64`：Apple Distribution `.p12` 文件转 Base64
- `IOS_CERTIFICATE_PASSWORD`：`.p12` 文件密码
- `IOS_PROVISIONING_PROFILE_BASE64`：与 Bundle ID 和证书匹配的 `.mobileprovision` 转 Base64
- `IOS_PROVISIONING_PROFILE_NAME`：Provisioning Profile 的 Name
- `IOS_TEAM_ID`：Apple Developer Team ID
- `IOS_BUNDLE_ID`：Apple Developer 中注册的 App Bundle ID

CI 会将 `IOS_BUNDLE_ID` 替换工程中的默认 `com.example.flutterStarter` 占位值。

示例转换命令：

```bash
base64 -i distribution.p12 | pbcopy
base64 -i Runner.mobileprovision | pbcopy
```

当前 iOS Workflow 使用 `app-store` 导出方式，适用于上传 TestFlight/App Store。它暂时只上传 IPA Artifact，不会自动提交 App Store Connect；后续可增加 App Store Connect API Key 后再启用自动上传。不要把证书、Profile、密码提交到仓库。
