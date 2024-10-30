# react-native-simple-openvpn [![github stars][github-star-img]][stargazers-url]

[![npm latest][version-img]][pkg-url]
[![download month][dl-month-img]][pkg-url]
[![download total][dl-total-img]][pkg-url]
[![PRs welcome][pr-img]][pr-url]
[![all contributors][contributors-img]](#contributors)
![platforms][platform-img]
[![GNU General Public License][license-img]](LICENSE)

简体中文 | [English](./README.md)

react-native-simple-openvpn 提供了与 OpenVPN 交互的接口

如果本项目对你有所帮助，请 star 🌟 鼓励，谢谢 🙏

## 版本

| RNSimpleOpenvpn | React Native  |
| --------------- | ------------- |
| `1.0.0 ~ 1.2.0` | `0.56 ~ 0.66` |
| `2.0.0 ~ 2.1.1` | `0.63 ~ 0.71` |
| `2.1.2`         | `0.72`        |
| `>= 2.1.3`      | `>= 0.73`     |

详细信息请参考[更改日志](CHANGELOG.md)

## 预览

<p>
  <img src="./.github/images/openvpn-android.gif" height="450" />
  <img src="./.github/images/openvpn-ios.gif" height="450" />
</p>

## 安装

### 添加依赖

```sh
# npm
npm install --save react-native-simple-openvpn

# or use yarn
yarn add react-native-simple-openvpn
```

### Link

从 react-native 0.60 开始，autolinking 将负责链接的步骤

```sh
react-native link react-native-simple-openvpn
```

### Android

在项目的 `android/settings.gradle` 中添加以下代码：

```diff
rootProject.name = 'example'
+ include ':vpnLib'
+ project(':vpnLib').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-simple-openvpn/vpnLib')
apply from: file("../node_modules/@react-native-community/cli-platform-android/native_modules.gradle"); applyNativeModulesSettingsGradle(settings)
include ':app'
```

如果你的 React Native 版本大于等于 0.74，在项目的 `android/app/build.gradle` 中添加以下代码：

```diff
android {
    // ...
+   packaging {
+       jniLibs {
+           useLegacyPackaging = true
+       }
+   }
}
```

#### 导入 jniLibs

由于存在文件大小的限制，jniLibs 无法随模块一起发布到 npm 上。故使用 [GitHub Releases](https://github.com/ccnnde/react-native-simple-openvpn/releases/tag/v2.0.0) 中的 assets 来代替

下载并解压你需要的相应架构的资源，然后将其放入 `android/app/src/main/jniLibs` 中（如果 `jniLibs` 文件夹不存在则手动新建一个）

```sh
project
├── android
│   ├── app
│   │   └── src
│   │       └── main
│   │           └── jniLibs
│   │               ├── arm64-v8a
│   │               ├── armeabi-v7a
│   │               ├── x86
│   │               └── x86_64
│   └── ...
├── ios
└── ...
```

### iOS

如果使用 CocoaPods, 在 `ios/` 目录下运行

```sh
pod install
```

iOS 端 Network Extension 配置以及 OpenVPN 的集成请参阅 [iOS 指南](docs/iOS-Guide.zh-CN.md)

#### 后台退出 App 时关闭 VPN 连接

在项目的 `AppDelegate.m` 中添加以下代码：

```diff
+ #import "RNSimpleOpenvpn.h"

@implementation AppDelegate

// ...

+ - (void)applicationWillTerminate:(UIApplication *)application
+ {
+   [RNSimpleOpenvpn dispose];
+ }

@end
```

请确保 Build Settings 的 Header Search Paths 包含以下路径：

```txt
$(SRCROOT)/../node_modules/react-native-simple-openvpn/ios
```

或者, 如果你使用 CocoaPods 的话，Header Search Paths 应该会自动包含以下路径：

```txt
"${PODS_ROOT}/Headers/Public/react-native-simple-openvpn"
```

## 示例

[项目示例](./example/README.md)

## 用法

```jsx
import React, { useEffect } from 'react';
import { Platform } from 'react-native';
import RNSimpleOpenvpn, { addVpnStateListener, removeVpnStateListener } from 'react-native-simple-openvpn';

const isIPhone = Platform.OS === 'ios';

const App = () => {
  useEffect(() => {
    async function observeVpn() {
      if (isIPhone) {
        await RNSimpleOpenvpn.observeState();
      }

      addVpnStateListener((e) => {
        // ...
      });
    }

    observeVpn();

    return async () => {
      if (isIPhone) {
        await RNSimpleOpenvpn.stopObserveState();
      }

      removeVpnStateListener();
    };
  });

  async function startOvpn() {
    try {
      await RNSimpleOpenvpn.connect({
        remoteAddress: '192.168.1.1 3000',
        ovpnFileName: 'client',
        assetsPath: 'ovpn/',
        providerBundleIdentifier: 'com.example.RNSimpleOvpnTest.NEOpenVPN',
        localizedDescription: 'RNSimpleOvpn',
      });
    } catch (error) {
      // ...
    }
  }

  async function stopOvpn() {
    try {
      await RNSimpleOpenvpn.disconnect();
    } catch (error) {
      // ...
    }
  }

  function printVpnState() {
    console.log(JSON.stringify(RNSimpleOpenvpn.VpnState, undefined, 2));
  }

  // ...
};

export default App;
```

更多内容请查看 [API Reference](docs/Reference.zh-CN.md)

## OpenVPN library

本项目使用到了以下项目

- Android - [ics-openvpn](https://github.com/schwabe/ics-openvpn) v0.7.33
- iOS - [OpenVPNAdapter](https://github.com/ss-abramchuk/OpenVPNAdapter) v0.8.0

## Star History

[![star history chart][star-history-img]][star-history-url]

## Contributors

感谢以下所有做出贡献的人

[![contributors list][contributors-list-img]][contributors-url]

## License

[GPLv2](LICENSE) © Nor Cod

<!-- badge url -->

[pkg-url]: https://www.npmjs.com/package/react-native-simple-openvpn
[stargazers-url]: https://github.com/ccnnde/react-native-simple-openvpn/stargazers
[github-star-img]: https://img.shields.io/github/stars/ccnnde/react-native-simple-openvpn?label=Star%20Project&style=social
[version-img]: https://img.shields.io/npm/v/react-native-simple-openvpn?color=deepgreen&style=flat-square
[dl-month-img]: https://img.shields.io/npm/dm/react-native-simple-openvpn?style=flat-square
[dl-total-img]: https://img.shields.io/npm/dt/react-native-simple-openvpn?label=total&style=flat-square
[pr-img]: https://img.shields.io/badge/PRs-welcome-blue.svg?style=flat-square
[pr-url]: https://makeapullrequest.com
[contributors-img]: https://img.shields.io/github/contributors/ccnnde/react-native-simple-openvpn?color=blue&style=flat-square
[contributors-url]: https://github.com/ccnnde/react-native-simple-openvpn/graphs/contributors
[contributors-list-img]: https://contrib.rocks/image?repo=ccnnde/react-native-simple-openvpn
[platform-img]: https://img.shields.io/badge/platforms-android%20|%20ios-lightgrey?style=flat-square
[star-history-img]: https://api.star-history.com/svg?repos=ccnnde/react-native-simple-openvpn&type=Date
[star-history-url]: https://star-history.com/#ccnnde/react-native-simple-openvpn&Date
[license-img]: https://img.shields.io/badge/license-GPL%20v2-orange?style=flat-square
