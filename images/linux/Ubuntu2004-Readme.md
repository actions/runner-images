| Announcements |
|-|
| [GraalVM JDK11 will be removed from agents on April 10, 2023](https://github.com/actions/runner-images/issues/7338) |
| [[All OSes] Go 1.17.x will be removed and 1.20.x set as default on April, 3](https://github.com/actions/runner-images/issues/7276) |
***
# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1035-azure
- Image Version: 20230402.1

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.2.3 (Eshell 13.1.5)
- Erlang rebar3 3.20.0
- GNU C++: 9.4.0, 10.3.0
- GNU Fortran: 9.4.0, 10.3.0
- Julia 1.8.5
- Kotlin 1.8.10-release-430
- Mono 6.12.0.182
- MSBuild 16.10.1.31701 (Mono 6.12.0.182)
- Node.js 18.15.0
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.8

### Package Management
- cpan 1.64
- Helm 3.11.2
- Homebrew 4.0.10
- Miniconda 23.1.0
- Npm 9.5.0
- NuGet 6.3.1.1
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.2.0
- RubyGems 3.1.2
- Vcpkg (build from commit 69efe9cc2)
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
- Ant 1.10.7
- Gradle 8.0.2
- Lerna 6.6.1
- Maven 3.8.8
- Sbt 1.8.2

### Tools
- Ansible 2.13.8
- apt-fast 1.9.12
- AzCopy 10.18.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.1.1
- Bazelisk 1.13.2
- Bicep 0.15.31
- Buildah 1.22.3
- CMake 3.26.2
- CodeQL Action Bundles 2.12.4 2.12.5
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.17.2+azure-1
- Docker-Buildx 0.10.4
- Docker-Moby Client 20.10.23+azure-2
- Docker-Moby Server 20.10.23+azure-2
- Fastlane 2.212.1
- Git 2.40.0
- Git LFS 3.3.0
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.69.1
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.18.0
- Kubectl 1.26.3
- Kustomize 5.0.1
- Leiningen 2.10.0
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.29.0
- n 9.0.1
- Newman 5.3.2
- nvm 0.39.3
- OpenSSL 1.1.1f-1ubuntu2.17
- Packer 1.8.6
- Parcel 2.8.3
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.60.1
- R 4.2.3
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.4.4
- yamllint 1.30.0
- yq 4.33.2
- zstd 1.5.4

### CLI Tools
- Alibaba Cloud CLI 3.0.161
- AWS CLI 2.11.8
- AWS CLI Session Manager Plugin 1.2.463.0
- AWS SAM CLI 1.78.0
- Azure CLI 2.46.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.25.1
- Google Cloud SDK 424.0.0
- Hub CLI 2.14.2
- Netlify CLI 13.2.2
- OpenShift CLI 4.12.9
- ORAS CLI 1.0.0
- Vercel CLI 28.18.3

### Java
| Version              | Vendor          | Environment Variable |
| -------------------- | --------------- | -------------------- |
| 8.0.362+9            | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.18+10 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.6+10            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.3.1 | GRAALVM_11_ROOT       |

### PHP Tools
- PHP: 7.4.33, 8.0.28, 8.1.17, 8.2.4
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
- Cargo 1.68.2
- Rust 1.68.2
- Rustdoc 1.68.2
- Rustup 1.25.2

#### Packages
- Bindgen 0.64.0
- Cargo audit 0.17.5
- Cargo clippy 0.1.68
- Cargo outdated 0.11.2
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 111.0.5563.146
- ChromeDriver 111.0.5563.64
- Chromium 111.0.5547.0
- Microsoft Edge 111.0.1661.62
- Microsoft Edge WebDriver 111.0.1661.62
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
- .NET Core SDK: 3.1.120, 3.1.202, 3.1.302, 3.1.426, 6.0.407, 7.0.104, 7.0.202
- nbgv 3.5.119+5d25f54fec

### Databases
- MongoDB 5.0.15
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.7
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.32-0ubuntu0.20.04.2
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
- 1.18.10
- 1.19.7
- 1.20.2

#### Node.js
- 14.21.3
- 16.20.0
- 18.15.0

#### Python
- 2.7.18
- 3.6.15
- 3.7.16
- 3.8.16
- 3.9.16
- 3.10.10
- 3.11.2

#### PyPy
- 2.7.18 [PyPy 7.3.11]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.16 [PyPy 7.3.11]

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.8
- 3.0.6
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.10

#### PowerShell Modules
- Az: 9.3.0
- Az (Cached): 3.1.0.zip, 4.4.0.zip, 5.9.0.zip, 6.6.0.zip, 7.5.0.zip
- MarkdownPS: 1.9
- Microsoft.Graph: 1.25.0
- Pester: 5.4.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

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
| alpine:3.14             | sha256:0f2d5c38dd7a4f4f733e688e3a6733cb5ab1ac6e3cb4603a5dd564e5bfb80eed  | 2023-03-29 |
| alpine:3.15             | sha256:ecbdce53b2c2f43ab1b19418bcbd3f120a23547d9497030c8d978114512b883e  | 2023-03-29 |
| alpine:3.16             | sha256:c2b622f6e510a0d25bccaffa9e67b75a6860cb09b74bb58cfc36a9ef4331109f  | 2023-03-29 |
| alpine:3.17             | sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126  | 2023-03-29 |
| buildpack-deps:bullseye | sha256:d2e6d0b6233d9da4534d22e96ea4338fbf36a7657b6d60aae20260140ce43148  | 2023-03-23 |
| buildpack-deps:buster   | sha256:56e11e205661d628368fbcd0edee38d666d507351e5c74f2795128cd71c6f52b  | 2023-03-23 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:235f2a778fbc0d668c66afa9fd5f1efabab94c1d6588779ea4e221e1496f89da  | 2023-03-23 |
| debian:11               | sha256:7b991788987ad860810df60927e1adbaf8e156520177bd4db82409f81dd3b721  | 2023-03-23 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:ca34989052fc2467dcd283d2000c2ad8c7cd6213c5ff0fcabef1a9cfb0651b3a  | 2023-03-23 |
| node:14                 | sha256:a97048059988c65f974b37dfe25a44327069a0f4f81133624871de0063b98075  | 2023-03-23 |
| node:14-alpine          | sha256:434215b487a329c9e867202ff89e704d3a75e554822e07f3e0c0f9e606121b33  | 2023-03-29 |
| node:16                 | sha256:051b68ed341fee26f4c08b15815ac4bff6a5351c68e7b33c66912677cc4be7ac  | 2023-03-29 |
| node:16-alpine          | sha256:b4a72f83f52bbe3970bb74a15e44ec4cf6e873ad4787473dfc8a26f5b4e29dd2  | 2023-03-29 |
| node:18                 | sha256:c21209748c829660e0b49cbd14d2f9d81ea82ffb02a8a7932ebacf70d01573a3  | 2023-03-23 |
| node:18-alpine          | sha256:47d97b93629d9461d64197773966cc49081cf4463b1b07de5a38b6bd5acfbe9d  | 2023-03-29 |
| ubuntu:16.04            | sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6  | 2021-08-31 |
| ubuntu:18.04            | sha256:8aa9c2798215f99544d1ce7439ea9c3a6dfd82de607da1cec3a8a2fae005931b  | 2023-03-08 |
| ubuntu:20.04            | sha256:24a0df437301598d1a4b62ddf59fa0ed2969150d70d748c84225e6501e9c36b9  | 2023-03-08 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.4                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| build-essential        | 12.8ubuntu1.1                     |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.18                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.16.1-0ubuntu2.14              |
| dpkg                   | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.7    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libcurl4               | 7.68.0-1ubuntu2.18                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.7    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.7    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.5                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.9                   |
| m4                     | 1.4.18-4                          |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.5                |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8ubuntu0.5                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.5                 |
| ssh                    | 1:8.2p1-4ubuntu0.5                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.4                 |
| swig                   | 4.0.1-5build1                     |
| tar                    | 1.30+dfsg-7ubuntu0.20.04.3        |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2022g-0ubuntu0.20.04.1            |
| unzip                  | 6.0-25ubuntu1.1                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.8       |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

