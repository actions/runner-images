| Announcements |
|-|
| [[all OSs] Default Nodejs version will be set to 18 on February, 13](https://github.com/actions/runner-images/issues/7002) |
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 2022/08/08 and will be fully unsupported by 2023/04/01](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 18.04
- OS Version: 18.04.6 LTS
- Kernel Version: 5.4.0-1103-azure
- Image Version: 20230217.2

## Installed Software

### Language and Runtime
- Bash 4.4.20(1)-release
- Clang: 9.0.0
- Clang-format: 9.0.0
- Clang-tidy: 9.0.0
- Dash 0.5.8-2.10
- Erlang 25.0.4 (Eshell 13.0.4)
- Erlang rebar3 3.20.0
- GNU C++: 7.5.0, 9.4.0, 10.3.0
- GNU Fortran: 7.5.0, 9.4.0, 10.3.0
- Julia 1.8.5
- Kotlin 1.8.10-release-430
- Mono 6.12.0.182
- MSBuild 16.10.1.31701 (Mono 6.12.0.182)
- Node.js 16.19.1
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.7.3

### Package Management
- cpan 1.64
- Helm 3.11.1
- Homebrew 4.0.1
- Miniconda 23.1.0
- Npm 8.19.3
- NuGet 6.3.1.1
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 1.0.0
- RubyGems 2.7.6
- Vcpkg (build from commit 31a159c1c)
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
- Ant 1.10.5
- Gradle 8.0.1
- Maven 3.8.7
- Sbt 1.8.2

### Tools
- Ansible 2.11.12
- apt-fast 1.9.12
- AzCopy 10.17.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.0.0
- Bazelisk 1.13.2
- Bicep 0.14.46
- Buildah 1.22.3
- CMake 3.25.2
- CodeQL Action Bundles 2.12.1 2.12.2
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.16.0+azure-2
- Docker-Buildx 0.10.3
- Docker-Moby Client 20.10.23+azure-2
- Docker-Moby Server 20.10.22+azure-1
- Git 2.39.2
- Git LFS 3.2.0
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.68.1
- HHVM (HipHop VM) 4.164.0
- jq 1.5
- Kind 0.17.0
- Kubectl 1.26.1
- Kustomize 5.0.0
- Leiningen 2.10.0
- MediaInfo 17.12
- Mercurial 4.5.3
- Minikube 1.29.0
- n 9.0.1
- Newman 5.3.2
- nvm 0.39.3
- OpenSSL 1.1.1-1ubuntu2.1~18.04.21
- Packer 1.8.6
- Parcel 2.8.3
- PhantomJS 2.1.1
- Podman 3.4.2
- Pulumi 3.55.0
- R 4.2.2
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 1.3.9
- yamllint 1.28.0
- yq 4.30.8
- zstd 1.5.4

### CLI Tools
- Alibaba Cloud CLI 3.0.149
- AWS CLI 2.10.1
- AWS CLI Session Manager Plugin 1.2.398.0
- AWS SAM CLI 1.73.0
- Azure CLI 2.45.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.23.0
- Google Cloud SDK 418.0.0
- Hub CLI 2.14.2
- Netlify CLI 12.13.1
- OpenShift CLI 4.12.3
- ORAS CLI 0.16.0
- Vercel CLI 28.16.2

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.362+9 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.18+10          | Eclipse Temurin | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK   | JAVA_HOME_12_X64     |
| 17.0.6+10           | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP Tools
- PHP: 7.2.34, 7.3.33, 7.4.33, 8.0.28, 8.1.16, 8.2.3
- Composer 2.5.4
- PHPUnit 8.5.32
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.6.2.0
- GHC 9.4.4
- GHCup 0.1.19.0
- Stack 2.9.3

### Rust Tools
- Cargo 1.67.1
- Rust 1.67.1
- Rustdoc 1.67.1
- Rustup 1.25.2

#### Packages
- Bindgen 0.64.0
- Cargo audit 0.17.4
- Cargo clippy 0.1.67
- Cargo outdated 0.11.2
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 110.0.5481.100
- ChromeDriver 110.0.5481.77
- Chromium 110.0.5481.0
- Microsoft Edge 110.0.1587.50
- Microsoft Edge WebDriver 110.0.1587.50
- Selenium server 4.8.0
- Mozilla Firefox 110.0
- Geckodriver 0.32.2

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Tools
- .NET Core SDK: 3.1.120, 3.1.202, 3.1.302, 3.1.426, 6.0.406
- nbgv 3.5.119+5d25f54fec

### Databases
- MongoDB 5.0.14
- sqlite3 3.22.0

#### PostgreSQL
- PostgreSQL 14.7
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 5.7.41
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
- 1.16.15
- 1.17.13
- 1.18.10

#### Node.js
- 14.21.3
- 16.19.1
- 18.14.1

#### Python
- 2.7.18
- 3.6.15
- 3.7.15
- 3.8.16
- 3.9.16
- 3.10.10
- 3.11.2

#### PyPy
- 2.7.18 [PyPy 7.3.11]
- 3.6.12 [PyPy 7.3.3]
- 3.9.16 [PyPy 7.3.11]

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.10
- 2.7.7
- 3.0.5
- 3.1.3

### PowerShell Tools
- PowerShell 7.2.9

#### PowerShell Modules
- Az: 9.3.0
- Az (Cached): 3.1.0.zip, 4.4.0.zip, 5.9.0.zip, 6.6.0.zip, 7.5.0.zip
- MarkdownPS: 1.9
- Microsoft.Graph: 1.22.0
- Pester: 5.4.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.29  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.14.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                                       |
| Android Emulator           | 32.1.11                                                                                                                                                                                                                                                                                   |
| Android SDK Build-tools    | 33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 34.0.0                                                                                                                                                                                                                                                                                    |
| Android SDK Platforms      | android-33-ext4 (rev 1)<br>android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                 |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                                    |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                    |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                                                |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                                  |
| Google Play services       | 49                                                                                                                                                                                                                                                                                        |
| Google Repository          | 58                                                                                                                                                                                                                                                                                        |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)                                                                                                                                                                                                                                    |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                         |

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
| alpine:3.12             | sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69  | 2022-04-05 |
| alpine:3.13             | sha256:469b6e04ee185740477efa44ed5bdd64a07bbdd6c7e5f5d169e540889597b911  | 2022-08-09 |
| alpine:3.14             | sha256:560e7a4fa5c891d1830f5591c80b8e472fa6cd386b7254cdf65ccc3249292a34  | 2023-02-11 |
| buildpack-deps:bullseye | sha256:40b14eb195795a586ac132c9b506253bc3e4ee7f48a63b685e5bf37e80b774cf  | 2023-02-09 |
| buildpack-deps:buster   | sha256:a3e4aaa53bf83302adfb9d8b9ba3996948e4605baac297921d3a173c14603748  | 2023-02-09 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:233c3bbc892229c82da7231980d50adceba4db56a08c0b7053a4852782703459  | 2023-02-09 |
| debian:11               | sha256:43ef0c6c3585d5b406caa7a0f232ff5a19c1402aeb415f68bcd1cf9d10180af8  | 2023-02-09 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:751921dc37d2f842de38c9387f891fe6ae7d80f03d050ea98f780d7e0874ba00  | 2023-02-13 |
| node:14                 | sha256:a58436325059a278c35079034ce5c98dace7204a2a5748929ccc79087f959daa  | 2023-02-17 |
| node:14-alpine          | sha256:1a1a30ee1faa7d512917e277cc8c81744e79096de3561ecda7ea17cc2ceab372  | 2023-02-17 |
| node:16                 | sha256:102e907ac88ac60cbad62b09ce003fa11618687621c45da2a2514703be1d1b1a  | 2023-02-17 |
| node:16-alpine          | sha256:77f92924c9734d4acdeb5ec42de85867b10c0031f2e861d26cdae6abd56cf858  | 2023-02-17 |
| node:18                 | sha256:888e7f9ead4aa3257e9c91528b9f63a427d8a926876ef5ae27ecba2651ae211d  | 2023-02-17 |
| node:18-alpine          | sha256:178bf3eb09c4245fda8c81c1063c0d55c45d7a7f4ddc5296814107b1dc610450  | 2023-02-17 |
| ubuntu:16.04            | sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6  | 2021-08-31 |
| ubuntu:18.04            | sha256:a3765b4d74747b5e9bdd03205b3fbc4fa19a02781c185f97f24c8f4f84ed7bbf  | 2023-01-26 |
| ubuntu:20.04            | sha256:4a45212e9518f35983a976eead0de5eecc555a2f047134e9dd2cfc589076a00d  | 2023-02-01 |

### Installed apt packages
| Name              | Version                           |
| ----------------- | --------------------------------- |
| aria2             | 1.33.1-1                          |
| autoconf          | 2.69-11                           |
| automake          | 1:1.15.1-3ubuntu2                 |
| binutils          | 2.30-21ubuntu1\~18.04.8           |
| bison             | 2:3.0.4.dfsg-1build1              |
| brotli            | 1.0.3-1ubuntu1.3                  |
| build-essential   | 12.4ubuntu1                       |
| bzip2             | 1.0.6-8.1ubuntu0.2                |
| coreutils         | 8.28-1ubuntu1                     |
| curl              | 7.58.0-2ubuntu3.22                |
| dbus              | 1.12.2-1ubuntu1.4                 |
| dnsutils          | 1:9.11.3+dfsg-1ubuntu1.18         |
| dpkg              | 1.19.0.5ubuntu2.4                 |
| fakeroot          | 1.22-2ubuntu1                     |
| file              | 1:5.32-2ubuntu0.4                 |
| flex              | 2.6.4-6                           |
| ftp               | 0.17-34                           |
| gnupg2            | 2.2.4-1ubuntu1.6                  |
| haveged           | 1.9.1-6                           |
| imagemagick       | 8:6.9.7.4+dfsg-16ubuntu6.15       |
| iproute2          | 4.15.0-2ubuntu1.3                 |
| iputils-ping      | 3:20161105-1ubuntu3               |
| jq                | 1.5+dfsg-2                        |
| lib32z1           | 1:1.2.11.dfsg-0ubuntu2.2          |
| libc++-dev        | 6.0-2                             |
| libc++abi-dev     | 6.0-2                             |
| libcurl3          | 7.58.0-2ubuntu3.22                |
| libgbm-dev        | 20.0.8-0ubuntu1\~18.04.1          |
| libgconf-2-4      | 3.2.6-4ubuntu1                    |
| libgsl-dev        | 2.4+dfsg-6                        |
| libgtk-3-0        | 3.22.30-1ubuntu4                  |
| libmagic-dev      | 1:5.32-2ubuntu0.4                 |
| libmagickcore-dev | 8:6.9.7.4+dfsg-16ubuntu6.15       |
| libmagickwand-dev | 8:6.9.7.4+dfsg-16ubuntu6.15       |
| libsecret-1-dev   | 0.18.6-1                          |
| libsqlite3-dev    | 3.22.0-1ubuntu0.7                 |
| libtool           | 2.4.6-2                           |
| libunwind8        | 1.2.1-8                           |
| libxkbfile-dev    | 1:1.0.9-2                         |
| libxss1           | 1:1.2.2-1                         |
| libyaml-dev       | 0.1.7-2ubuntu3                    |
| locales           | 2.27-3ubuntu1.6                   |
| m4                | 1.4.18-1                          |
| mediainfo         | 17.12-1                           |
| mercurial         | 4.5.3-1ubuntu2.2                  |
| net-tools         | 1.60+git20161116.90da8a0-1ubuntu1 |
| netcat            | 1.10-41.1                         |
| openssh-client    | 1:7.6p1-4ubuntu0.7                |
| p7zip-full        | 16.02+dfsg-6                      |
| p7zip-rar         | 16.02-2                           |
| parallel          | 20161222-1                        |
| pass              | 1.7.1-3                           |
| patchelf          | 0.9-1                             |
| pkg-config        | 0.29.1-0ubuntu2                   |
| pollinate         | 4.33-0ubuntu1\~18.04.2            |
| python-setuptools | 39.0.1-2ubuntu0.1                 |
| rpm               | 4.14.1+dfsg1-2                    |
| rsync             | 3.1.2-2.1ubuntu1.5                |
| shellcheck        | 0.4.6-1                           |
| sphinxsearch      | 2.2.11-2                          |
| sqlite3           | 3.22.0-1ubuntu0.7                 |
| ssh               | 1:7.6p1-4ubuntu0.7                |
| sshpass           | 1.06-1                            |
| subversion        | 1.9.7-4ubuntu1.1                  |
| sudo              | 1.8.21p2-3ubuntu1.5               |
| swig              | 3.0.12-1                          |
| tar               | 1.29b-2ubuntu0.3                  |
| telnet            | 0.17-41                           |
| texinfo           | 6.5.0.dfsg.1-2                    |
| time              | 1.7-25.1build1                    |
| tk                | 8.6.0+9                           |
| tzdata            | 2022g-0ubuntu0.18.04              |
| unzip             | 6.0-21ubuntu1.2                   |
| upx               | 3.94-4                            |
| wget              | 1.19.4-1ubuntu2.2                 |
| xorriso           | 1.4.8-3                           |
| xvfb              | 2:1.19.6-1ubuntu4.14              |
| xz-utils          | 5.2.2-1.3ubuntu0.1                |
| zip               | 3.0-11build1                      |
| zsync             | 0.6.2-3ubuntu1                    |

