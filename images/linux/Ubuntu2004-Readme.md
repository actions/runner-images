| Announcements |
|-|
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 2022/08/08 and will be fully unsupported by 2023/04/01](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 20.04
- OS Version: 20.04.5 LTS
- Kernel Version: 5.15.0-1034-azure
- Image Version: 20230305.1

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
- Node.js 18.14.2
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.7.3

### Package Management
- cpan 1.64
- Helm 3.11.1
- Homebrew 4.0.4
- Miniconda 23.1.0
- Npm 9.5.0
- NuGet 6.3.1.1
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.1.0
- RubyGems 3.1.2
- Vcpkg (build from commit 8daf70c56)
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
- Lerna 6.5.1
- Maven 3.8.7
- Sbt 1.8.2

### Tools
- Ansible 2.13.8
- apt-fast 1.9.12
- AzCopy 10.17.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.0.0
- Bazelisk 1.13.2
- Bicep 0.14.85
- Buildah 1.22.3
- CMake 3.25.2
- CodeQL Action Bundles 2.12.2 2.12.3
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.16.0+azure-2
- Docker-Buildx 0.10.3
- Docker-Moby Client 20.10.23+azure-2
- Docker-Moby Server 20.10.23+azure-2
- Fastlane 2.212.1
- Git 2.39.2
- Git LFS 3.3.0
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.68.2
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.17.0
- Kubectl 1.26.2
- Kustomize 5.0.0
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
- PhantomJS 2.1.1
- Podman 3.4.2
- Pulumi 3.55.0
- R 4.2.2
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.3.9
- yamllint 1.29.0
- yq 4.31.2
- zstd 1.5.4

### CLI Tools
- Alibaba Cloud CLI 3.0.152
- AWS CLI 2.11.0
- AWS CLI Session Manager Plugin 1.2.398.0
- AWS SAM CLI 1.76.0
- Azure CLI 2.45.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.23.0
- Google Cloud SDK 420.0.0
- Hub CLI 2.14.2
- Netlify CLI 13.0.1
- OpenShift CLI 4.12.5
- ORAS CLI 0.16.0
- Vercel CLI 28.16.12

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
- PHP: 7.4.33, 8.0.28, 8.1.16, 8.2.3
- Composer 2.5.4
- PHPUnit 8.5.33
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.6.2.0
- GHC 9.4.4
- GHCup 0.1.19.2
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
- Google Chrome 110.0.5481.177
- ChromeDriver 110.0.5481.77
- Chromium 110.0.5481.0
- Microsoft Edge 110.0.1587.63
- Microsoft Edge WebDriver 110.0.1587.63
- Selenium server 4.8.0
- Mozilla Firefox 110.0.1
- Geckodriver 0.32.2

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Tools
- .NET Core SDK: 3.1.120, 3.1.202, 3.1.302, 3.1.426, 6.0.406, 7.0.103, 7.0.201
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
- 1.17.13
- 1.18.10
- 1.19.6
- 1.20.1

#### Node.js
- 14.21.3
- 16.19.1
- 18.14.2

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
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.16 [PyPy 7.3.11]

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.7
- 3.0.5
- 3.1.3

### PowerShell Tools
- PowerShell 7.2.10

#### PowerShell Modules
- Az: 9.3.0
- Az (Cached): 3.1.0.zip, 4.4.0.zip, 5.9.0.zip, 6.6.0.zip, 7.5.0.zip
- MarkdownPS: 1.9
- Microsoft.Graph: 1.23.0
- Pester: 5.4.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                           |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                               |
| Android Emulator           | 32.1.11                                                                                                                                                                           |
| Android SDK Build-tools    | 33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3              |
| Android SDK Platform-Tools | 34.0.0                                                                                                                                                                            |
| Android SDK Platforms      | android-33-ext4 (rev 1)<br>android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                            |
| Android Support Repository | 47.0.0                                                                                                                                                                            |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                        |
| Google Play services       | 49                                                                                                                                                                                |
| Google Repository          | 58                                                                                                                                                                                |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)                                                                                                                            |
| SDK Patch Applier v4       | 1                                                                                                                                                                                 |

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
| alpine:3.14             | sha256:560e7a4fa5c891d1830f5591c80b8e472fa6cd386b7254cdf65ccc3249292a34  | 2023-02-11 |
| alpine:3.15             | sha256:689659b1f08e9fdfb85190144098c378beb5a53b328f7ced7883a74a1157c709  | 2023-02-11 |
| alpine:3.16             | sha256:1bd67c81e4ad4b8f4a5c1c914d7985336f130e5cefb3e323654fd09d6bcdbbe2  | 2023-02-11 |
| buildpack-deps:bullseye | sha256:6f2703639d3d17f70288d4ba212d55e159b682a990c20fc2a6562b098f01a1e7  | 2023-03-01 |
| buildpack-deps:buster   | sha256:63be0fe0bfb9d06b8747dcd87683787ef6d82c6f05b8a2ae213c38d56dc2bf53  | 2023-03-01 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:2d356e1e22c0902f88ef65cb7159ecd5a96feb62345747edfd4324b0d83a2923  | 2023-03-01 |
| debian:11               | sha256:f81bf5a8b57d6aa1824e4edb9aea6bd5ef6240bcc7d86f303f197a2eb77c430f  | 2023-03-01 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:751921dc37d2f842de38c9387f891fe6ae7d80f03d050ea98f780d7e0874ba00  | 2023-02-13 |
| node:14                 | sha256:481a78885f7a83f86fcb3ac48dab9bede651851d1b250650c17645a988902728  | 2023-03-01 |
| node:14-alpine          | sha256:49d052af1616dbf5f2bd8b71fca9a4b7c688955e72bbe3e0126c4b28d7675577  | 2023-02-17 |
| node:16                 | sha256:8ef06c513538040a988ac7731afa8ad8b1135cfe5d8b6ad78489d80c6f6c0137  | 2023-03-01 |
| node:16-alpine          | sha256:95a849eafc573ad0d972fd67c569369e7aa94d55a21ede3b972e3137e5f8e43a  | 2023-02-21 |
| node:18                 | sha256:8b2c008211854f4ee9ca328910d1c6bff8f30fc9fdf834b48f7ea40992a2079a  | 2023-03-01 |
| node:18-alpine          | sha256:f8a51c36b0be7434bbf867d4a08decf0100e656203d893b9b0f8b1fe9e40daea  | 2023-02-22 |
| ubuntu:16.04            | sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6  | 2021-08-31 |
| ubuntu:18.04            | sha256:1e32b9c52e8f22769df41e8f61066c77b2b35b0a423c4161c0e48eca2fd24f75  | 2023-03-01 |
| ubuntu:20.04            | sha256:9fa30fcef427e5e88c76bc41ad37b7cc573e1d79cecb23035e413c4be6e476ab  | 2023-03-01 |

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
| curl                   | 7.68.0-1ubuntu2.16                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.16.1-0ubuntu2.12              |
| dpkg                   | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.5    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libcurl4               | 7.68.0-1ubuntu2.16                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.5    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.5    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.5                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9build1                     |
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
| rsync                  | 3.1.3-8ubuntu0.4                  |
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
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.6       |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

