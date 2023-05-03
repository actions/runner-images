| Announcements |
|-|
| [[All OSes] Go 1.17.x will be removed and 1.20.x set as default on April, 3](https://github.com/actions/runner-images/issues/7276) |
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 2022/08/08 and will be fully unsupported by 2023/04/01](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 22.04
- OS Version: 22.04.2 LTS
- Kernel Version: 5.15.0-1034-azure
- Image Version: 20230326.2

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 12.0.1, 13.0.1, 14.0.0
- Clang-format: 12.0.1, 13.0.1, 14.0.0
- Clang-tidy: 12.0.1, 13.0.1, 14.0.0
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 9.5.0, 10.4.0, 11.3.0, 12.1.0
- GNU Fortran: 9.5.0, 10.4.0, 11.3.0, 12.1.0
- Julia 1.8.5
- Kotlin 1.8.10-release-430
- Mono 6.12.0.182
- MSBuild 16.10.1.31701 (Mono 6.12.0.182)
- Node.js 18.15.0
- Perl 5.34.0
- Python 3.10.6
- Python3 3.10.6
- Ruby 3.0.2p107
- Swift 5.7.3

### Package Management
- cpan 1.64
- Helm 3.11.2
- Homebrew 4.0.9
- Miniconda 23.1.0
- Npm 9.5.0
- NuGet 6.3.1.1
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.2.0
- RubyGems 3.3.5
- Vcpkg (build from commit b81bc3a83)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

#### Homebrew note
```
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
```

### Project Management
- Lerna 6.6.1
- Maven 3.8.8

### Tools
- Ansible 2.14.3
- apt-fast 1.9.12
- AzCopy 10.17.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.1.1
- Bazelisk 1.13.2
- Bicep 0.15.31
- Buildah 1.23.1
- CMake 3.26.1
- CodeQL Action Bundles 2.12.4 2.12.5
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.16.0+azure-2
- Docker-Buildx 0.10.4
- Docker-Moby Client 20.10.23+azure-2
- Docker-Moby Server 20.10.23+azure-2
- Fastlane 2.212.1
- Git 2.40.0
- Git LFS 3.3.0
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 7.69.1
- jq 1.6
- Kind 0.17.0
- Kubectl 1.26.3
- Kustomize 5.0.1
- Leiningen 2.10.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.29.0
- n 9.0.1
- Newman 5.3.2
- nvm 0.39.3
- OpenSSL 3.0.2-0ubuntu1.8
- Packer 1.8.6
- Parcel 2.8.3
- Podman 3.4.4
- Pulumi 3.59.1
- R 4.2.3
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.4.2
- yamllint 1.30.0
- yq 4.33.1
- zstd 1.5.4

### CLI Tools
- Alibaba Cloud CLI 3.0.158
- AWS CLI 2.11.6
- AWS CLI Session Manager Plugin 1.2.463.0
- AWS SAM CLI 1.78.0
- Azure CLI 2.46.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.25.1
- Google Cloud SDK 423.0.0
- Hub CLI 2.14.2
- Netlify CLI 13.2.1
- OpenShift CLI 4.12.8
- ORAS CLI 1.0.0
- Vercel CLI 28.18.1

### Java
| Version              | Vendor          | Environment Variable |
| -------------------- | --------------- | -------------------- |
| 8.0.362+9            | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.18+10 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.6+10            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.5.5
- PHPUnit 8.5.33
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.1.0
- GHC 9.6.1
- GHCup 0.1.19.2
- Stack 2.9.3

### Rust Tools
- Cargo 1.68.1
- Rust 1.68.1
- Rustdoc 1.68.1
- Rustup 1.25.2

#### Packages
- Bindgen 0.64.0
- Cargo audit 0.17.5
- Cargo clippy 0.1.68
- Cargo outdated 0.11.2
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 111.0.5563.110
- ChromeDriver 111.0.5563.64
- Chromium 111.0.5547.0
- Microsoft Edge 111.0.1661.54
- Microsoft Edge WebDriver 111.0.1661.54
- Selenium server 4.8.0
- Mozilla Firefox 111.0.1
- Geckodriver 0.32.2

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Tools
- .NET Core SDK: 6.0.407, 7.0.104, 7.0.202
- nbgv 3.5.119+5d25f54fec

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.7
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.32-0ubuntu0.22.04.2
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 16.1.8089.0

### Cached Tools

#### Go
- 1.17.13
- 1.18.10
- 1.19.7
- 1.20.2

#### Node.js
- 14.21.3
- 16.19.1
- 18.15.0

#### Python
- 3.7.16
- 3.8.16
- 3.9.16
- 3.10.10
- 3.11.2

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.16 [PyPy 7.3.11]

#### Ruby
- 3.1.3

### PowerShell Tools
- PowerShell 7.2.10

#### PowerShell Modules
- Az: 9.3.0
- MarkdownPS: 1.9
- Microsoft.Graph: 1.24.0
- Pester: 5.4.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                      |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 9.0                                                                                                                                                                                                          |
| Android Emulator           | 32.1.12                                                                                                                                                                                                      |
| Android SDK Build-tools    | 33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                         |
| Android SDK Platform-Tools | 34.0.1                                                                                                                                                                                                       |
| Android SDK Platforms      | android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                                                                                       |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                   |
| Google Play services       | 49                                                                                                                                                                                                           |
| Google Repository          | 58                                                                                                                                                                                                           |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)                                                                                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                            |

#### Environment variables
| Name                    | Value                                       |
| ----------------------- | ------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                  |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                  |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.14             | sha256:fa26727c28837d1471c2f1524d297a0255c153b5d023d7badd1412be7e6e12a2  | 2023-02-11 |
| alpine:3.15             | sha256:59b00c6f1614a599aa83d946d2a276c9257d2d29461c86c6a114d9932f2ddcd4  | 2023-02-11 |
| alpine:3.16             | sha256:2cf17aa35fbcb6ece81692a64bfbadaf096590241ed9f95dd5f94f0e9f674784  | 2023-02-11 |
| alpine:3.17             | sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517  | 2023-02-11 |
| buildpack-deps:bullseye | sha256:d2e6d0b6233d9da4534d22e96ea4338fbf36a7657b6d60aae20260140ce43148  | 2023-03-23 |
| buildpack-deps:buster   | sha256:56e11e205661d628368fbcd0edee38d666d507351e5c74f2795128cd71c6f52b  | 2023-03-23 |
| debian:10               | sha256:235f2a778fbc0d668c66afa9fd5f1efabab94c1d6588779ea4e221e1496f89da  | 2023-03-23 |
| debian:11               | sha256:7b991788987ad860810df60927e1adbaf8e156520177bd4db82409f81dd3b721  | 2023-03-23 |
| moby/buildkit:latest    | sha256:ca34989052fc2467dcd283d2000c2ad8c7cd6213c5ff0fcabef1a9cfb0651b3a  | 2023-03-23 |
| node:14                 | sha256:a97048059988c65f974b37dfe25a44327069a0f4f81133624871de0063b98075  | 2023-03-23 |
| node:14-alpine          | sha256:1d02d4073d7dfd58950a222a862f8b819afd774560b7b3e992b27ff4cd088285  | 2023-02-17 |
| node:16                 | sha256:e97b6d302062583e09be70f430b703637f6ef26c2cbb0d7bfed61e0be9d7a974  | 2023-03-23 |
| node:16-alpine          | sha256:fcb03294d3c0695cf9762dec94c0366f08e7a8c6a3c1e062d38c80ac30684d8a  | 2023-02-21 |
| node:18                 | sha256:c21209748c829660e0b49cbd14d2f9d81ea82ffb02a8a7932ebacf70d01573a3  | 2023-03-23 |
| node:18-alpine          | sha256:ffc770cdc09c9e83cccd99d663bb6ed56cfaa1bab94baf1b12b626aebeca9c10  | 2023-03-08 |
| ubuntu:18.04            | sha256:8aa9c2798215f99544d1ce7439ea9c3a6dfd82de607da1cec3a8a2fae005931b  | 2023-03-08 |
| ubuntu:20.04            | sha256:24a0df437301598d1a4b62ddf59fa0ed2969150d70d748c84225e6501e9c36b9  | 2023-03-08 |
| ubuntu:22.04            | sha256:67211c14fa74f070d27cc59d69a7fa9aeff8e28ea118ef3babc295a0428a6d21  | 2023-03-08 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.1                     |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| build-essential        | 12.9ubuntu3                         |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1                     |
| curl                   | 7.81.0-1ubuntu1.10                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.1-1ubuntu1.3                 |
| dpkg                   | 1.21.1ubuntu2.1                     |
| fakeroot               | 1.28-1ubuntu1                       |
| file                   | 1:5.41-3                            |
| flex                   | 2.6.4-8build2                       |
| fonts-noto-color-emoji | 2.038-0ubuntu1                      |
| ftp                    | 20210827-4build1                    |
| gnupg2                 | 2.2.27-3ubuntu2.1                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.2 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1                        |
| jq                     | 1.6-2.1ubuntu3                      |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libcurl4               | 7.81.0-1ubuntu1.10                  |
| libgbm-dev             | 22.2.5-0ubuntu0.1\~22.04.1          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2                    |
| libmagic-dev           | 1:5.41-3                            |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.2 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.2 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.1                   |
| libssl-dev             | 3.0.2-0ubuntu1.8                    |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2                       |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.1                     |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5   |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.1                  |
| p7zip-full             | 16.02+dfsg-8                        |
| p7zip-rar              | 16.02-3build1                       |
| parallel               | 20210822+ds-2                       |
| pass                   | 1.7.4-5                             |
| patchelf               | 0.14.3-1                            |
| pkg-config             | 0.29.2-1ubuntu3                     |
| pollinate              | 4.33-3ubuntu2                       |
| python-is-python3      | 3.9.2-2                             |
| rpm                    | 4.17.0+dfsg1-4build1                |
| rsync                  | 3.2.7-0ubuntu0.22.04.2              |
| shellcheck             | 0.8.0-2                             |
| sphinxsearch           | 2.2.11-8                            |
| sqlite3                | 3.37.2-2ubuntu0.1                   |
| ssh                    | 1:8.9p1-3ubuntu0.1                  |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.3                    |
| swig                   | 4.0.2-1ubuntu1                      |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.1        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2022g-0ubuntu0.22.04.1              |
| unzip                  | 6.0-26ubuntu3.1                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1                     |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.3-2ubuntu2.8                 |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

