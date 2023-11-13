# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1050-azure
- Image Version: 20231030.2.0
- Systemd version: 245.4-4ubuntu3.22

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.3 (Eshell 13.2)
- Erlang rebar3 3.22.1
- GNU C++: 9.4.0, 10.5.0
- GNU Fortran: 9.4.0, 10.5.0
- Julia 1.9.3
- Kotlin 1.9.10-release-459
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.18.2
- Perl 5.30.0
- Python 3.8.10
- Ruby 2.7.0p0
- Swift 5.9.1

### Package Management
- cpan 1.64
- Helm 3.13.1
- Homebrew 4.1.17
- Miniconda 23.9.0
- Npm 9.8.1
- NuGet 6.6.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.2.1
- RubyGems 3.1.2
- Vcpkg (build from commit 06c79a9af)
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
- Gradle 8.4
- Lerna 7.4.1
- Maven 3.8.8
- Sbt 1.9.7

### Tools
- Ansible 2.13.13
- apt-fast 1.9.12
- AzCopy 10.21.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.4.0
- Bazelisk 1.18.0
- Bicep 0.22.6
- Buildah 1.22.3
- CMake 3.27.7
- CodeQL Action Bundle 2.15.1
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.23.0
- Docker-Buildx 0.11.2
- Docker Client 24.0.7
- Docker Server 24.0.7
- Fastlane 2.216.0
- Git 2.42.0
- Git LFS 3.4.0
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 8.7.0
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.20.0
- Kubectl 1.28.3
- Kustomize 5.2.1
- Leiningen 2.10.0
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.31.2
- n 9.2.0
- Newman 6.0.0
- nvm 0.39.5
- OpenSSL 1.1.1f-1ubuntu2.20
- Packer 1.9.4
- Parcel 2.10.1
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.91.1
- R 4.3.1
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.6.2
- yamllint 1.32.0
- yq 4.35.2
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.174
- AWS CLI 2.13.30
- AWS CLI Session Manager Plugin 1.2.497.0
- AWS SAM CLI 1.99.0
- Azure CLI 2.53.1
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.37.0
- Google Cloud CLI 452.0.1
- Netlify CLI 16.9.3
- OpenShift CLI 4.13.18
- ORAS CLI 1.1.0
- Vercel CLI 32.5.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.382+5           | JAVA_HOME_8_X64      |
| 11.0.21+9 (default) | JAVA_HOME_11_X64     |
| 17.0.9+9            | JAVA_HOME_17_X64     |
| 21.0.1+12           | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 7.4.33, 8.0.30, 8.1.25, 8.2.12
- Composer 2.6.5
- PHPUnit 8.5.34
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.1.0
- GHC 9.8.1
- GHCup 0.1.19.4
- Stack 2.13.1

### Rust Tools
- Cargo 1.73.0
- Rust 1.73.0
- Rustdoc 1.73.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.68.1
- Cargo audit 0.18.3
- Cargo clippy 0.1.73
- Cargo outdated 0.13.1
- Cbindgen 0.26.0
- Rustfmt 1.6.0

### Browsers and Drivers
- Google Chrome 118.0.5993.117
- ChromeDriver 118.0.5993.70
- Chromium 118.0.5993.0
- Microsoft Edge 118.0.2088.76
- Microsoft Edge WebDriver 118.0.2088.76
- Selenium server 4.14.0
- Mozilla Firefox 119.0
- Geckodriver 0.33.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.416, 7.0.113, 7.0.203, 7.0.310, 7.0.403
- nbgv 3.6.133+2d32d93cb1

### Databases
- MongoDB 5.0.22
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.9
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.34-0ubuntu0.20.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.1.167.1

### Cached Tools

#### Go
- 1.19.13
- 1.20.10
- 1.21.3

#### Node.js
- 14.21.3
- 16.20.2
- 18.18.2
- 20.9.0

#### Python
- 3.7.17
- 3.8.18
- 3.9.18
- 3.10.13
- 3.11.6
- 3.12.0

#### PyPy
- 2.7.18 [PyPy 7.3.13]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.18 [PyPy 7.3.13]
- 3.10.13 [PyPy 7.3.13]

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.8
- 3.0.6
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.16

#### PowerShell Modules
- Az: 9.3.0
- Az (Cached): 3.1.0.zip, 4.4.0.zip, 5.9.0.zip, 6.6.0.zip, 7.5.0.zip
- MarkdownPS: 1.9
- Microsoft.Graph: 2.8.0
- Pester: 5.5.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                           |
| Android Emulator           | 32.1.15                                                                                                                                                                                                                                                       |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                                                |
| Android SDK Platform-Tools | 34.0.5                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-34-ext8 (rev 1)<br>android-34 (rev 2)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                        |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                            |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)<br>26.1.10909125                                                                                                                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                             |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/26.1.10909125 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16             | sha256:a8cbb8c69ee71561f4b69c066bad07f7e510caaa523da26fbfc606b10bd7934b  | 2023-08-07 |
| alpine:3.17             | sha256:f71a5f071694a785e064f05fed657bf8277f1b2113a8ed70c90ad486d6ee54dc  | 2023-08-07 |
| alpine:3.18             | sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978  | 2023-09-28 |
| buildpack-deps:bullseye | sha256:e5587c367e13ef9c01dede7c4085056a65e24caa7257a53c303c6c074fe6034e  | 2023-10-12 |
| buildpack-deps:buster   | sha256:82e25c1dea159632964a4c576380aa6ae9fd1d28c42b1f967d5474167ee4f6a1  | 2023-10-12 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:853b9ec779e55f670cbdcb5e15bfb778b5be2c5c61fc8c655638b7a977d273c6  | 2023-10-11 |
| debian:11               | sha256:c141beaa9e0767774221cc82efe3a6712a1cc4f75d2699334dfd9a28a6f7357b  | 2023-10-11 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:d4187a7326f20d04fafd075f80ccc5d3f8cfd4f665c6e03d158a78e4f64bf3db  | 2023-10-19 |
| node:14                 | sha256:a158d3b9b4e3fa813fa6c8c590b8f0a860e015ad4e59bbce5744d2f6fd8461aa  | 2023-04-12 |
| node:14-alpine          | sha256:434215b487a329c9e867202ff89e704d3a75e554822e07f3e0c0f9e606121b33  | 2023-03-29 |
| node:16                 | sha256:f77a1aef2da8d83e45ec990f45df50f1a286c5fe8bbfb8c6e4246c6389705c0b  | 2023-09-07 |
| node:16-alpine          | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18                 | sha256:a6385a6bb2fdcb7c48fc871e35e32af8daaa82c518900be49b76d10c005864c2  | 2023-10-18 |
| node:18-alpine          | sha256:435dcad253bb5b7f347ebc69c8cc52de7c912eb7241098b920f2fc2d7843183d  | 2023-10-18 |
| node:20                 | sha256:62efd17e997bc843aefa4c003ed84f43dfac83fa6228c57c898482e50a02e45c  | 2023-10-25 |
| node:20-alpine          | sha256:8e015de364a2eb2ed7c52a558e9f716dcb615560ffd132234087c10ccc1f2c63  | 2023-10-25 |
| ubuntu:16.04            | sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6  | 2021-08-31 |
| ubuntu:18.04            | sha256:152dc042452c496007f07ca9127571cb9c29697f42acbfad72324b2bb2e43c98  | 2023-05-30 |
| ubuntu:20.04            | sha256:ed4a42283d9943135ed87d4ee34e542f7f5ad9ecf2f244870e23122f703f91c2  | 2023-10-03 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.6                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.20                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.16.1-0ubuntu2.16              |
| dpkg                   | 1.19.7ubuntu3.2                   |
| dpkg-dev               | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| g++                    | 4:9.3.0-1ubuntu2                  |
| gcc                    | 4:9.3.0-1ubuntu2                  |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.9    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libc6-dev              | 2.31-0ubuntu9.12                  |
| libcurl4               | 7.68.0-1ubuntu2.20                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.9    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.9    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.5                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.12                  |
| m4                     | 1.4.18-4                          |
| make                   | 4.2.1-1.2                         |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.9                |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pigz                   | 2.4-1                             |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8ubuntu0.7                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.5                 |
| ssh                    | 1:8.2p1-4ubuntu0.9                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.5                 |
| swig                   | 4.0.1-5build1                     |
| tar                    | 1.30+dfsg-7ubuntu0.20.04.3        |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2023c-0ubuntu0.20.04.2            |
| unzip                  | 6.0-25ubuntu1.1                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.9       |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |
