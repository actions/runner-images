| Announcements |
|-|
| [[Ubuntu 20.04 and Ubuntu 22.04  Oses] Go  1.22.x  will be set as default on September, 20](https://github.com/actions/runner-images/issues/10500) |
| [Ubuntu 24.04 is now available](https://github.com/actions/runner-images/issues/9848) |
***
# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1071-azure
- Image Version: 20240908.1.0
- Systemd version: 245.4-4ubuntu3.23

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.3 (Eshell 13.2)
- Erlang rebar3 3.24.0
- GNU C++: 10.5.0
- GNU Fortran: 10.5.0
- Julia 1.10.5
- Kotlin 2.0.20-release-360
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.4
- Perl 5.30.0
- Python 3.8.10
- Ruby 2.7.0p0
- Swift 5.10.1

### Package Management
- cpan 1.64
- Helm 3.15.4
- Homebrew 4.3.19
- Miniconda 24.7.1
- Npm 10.7.0
- NuGet 6.6.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.7.1
- RubyGems 3.1.2
- Vcpkg (build from commit eba7c6a89)
- Yarn 1.22.22

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
- Gradle 8.10
- Lerna 8.1.8
- Maven 3.8.8
- Sbt 1.10.1

### Tools
- Ansible 2.13.13
- apt-fast 1.10.0
- AzCopy 10.26.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 7.3.1
- Bazelisk 1.21.0
- Bicep 0.29.47
- Buildah 1.22.3
- CMake 3.30.3
- CodeQL Action Bundle 2.18.3
- Docker Amazon ECR Credential Helper 0.8.0
- Docker Compose v2 2.27.1
- Docker-Buildx 0.16.2
- Docker Client 26.1.3
- Docker Server 26.1.3
- Fastlane 2.222.0
- Git 2.46.0
- Git LFS 3.5.1
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 9.2.1
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.24.0
- Kubectl 1.31.0
- Kustomize 5.4.3
- Leiningen 2.11.2
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.33.1
- n 10.0.0
- Newman 6.2.1
- nvm 0.40.1
- OpenSSL 1.1.1f-1ubuntu2.23
- Packer 1.11.2
- Parcel 2.12.0
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.131.0
- R 4.4.1
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.9.5
- yamllint 1.35.1
- yq 4.44.3
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.174
- AWS CLI 2.17.46
- AWS CLI Session Manager Plugin 1.2.650.0
- AWS SAM CLI 1.123.0
- Azure CLI 2.64.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.55.0
- Google Cloud CLI 491.0.0
- Netlify CLI 17.35.0
- OpenShift CLI 4.15.19
- ORAS CLI 1.2.0
- Vercel CLI 37.4.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.422+5           | JAVA_HOME_8_X64      |
| 11.0.24+8 (default) | JAVA_HOME_11_X64     |
| 17.0.12+7           | JAVA_HOME_17_X64     |
| 21.0.4+7            | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 7.4.33, 8.0.30, 8.1.29, 8.2.23, 8.3.11
- Composer 2.7.9
- PHPUnit 8.5.39
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.12.1.0
- GHC 9.10.1
- GHCup 0.1.30.0
- Stack 3.1.1

### Rust Tools
- Cargo 1.81.0
- Rust 1.81.0
- Rustdoc 1.81.0
- Rustup 1.27.1

#### Packages
- Bindgen 0.70.1
- Cargo audit 0.20.1
- Cargo clippy 0.1.81
- Cargo outdated 0.15.0
- Cbindgen 0.27.0
- Rustfmt 1.7.1

### Browsers and Drivers
- Google Chrome 128.0.6613.119
- ChromeDriver 128.0.6613.119
- Chromium 128.0.6613.0
- Microsoft Edge 128.0.2739.67
- Microsoft Edge WebDriver 128.0.2739.68
- Selenium server 4.24.0
- Mozilla Firefox 129.0.2
- Geckodriver 0.35.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.425, 7.0.410, 8.0.401
- nbgv 3.6.143+57d4199a9c

### Databases
- MongoDB 5.0.28
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.13
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.39-0ubuntu0.20.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.3.566.1

### Cached Tools

#### Go
- 1.20.14
- 1.21.13
- 1.22.7

#### Node.js
- 16.20.2
- 18.20.4
- 20.17.0

#### Python
- 3.7.17
- 3.8.18
- 3.9.19
- 3.10.14
- 3.11.9
- 3.12.5

#### PyPy
- 2.7.18 [PyPy 7.3.17]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.14 [PyPy 7.3.17]

#### Ruby
- 3.0.7
- 3.1.6
- 3.2.5

### PowerShell Tools
- PowerShell 7.4.5

#### PowerShell Modules
- Az: 12.1.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.23.0
- Pester: 5.6.1
- PSScriptAnalyzer: 1.22.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                         |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                             |
| Android SDK Platforms      | android-35 (rev 1)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                          |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                                      |
| Google Play services       | 49                                                                                                                                                                                                                                                                              |
| Google Repository          | 58                                                                                                                                                                                                                                                                              |
| NDK                        | 26.3.11579264<br>27.1.12297006 (default)                                                                                                                                                                                                                                        |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/27.1.12297006 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/27.1.12297006 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/27.1.12297006 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/27.1.12297006 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag       | Digest                                                                   | Created    |
| -------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16          | sha256:452e7292acee0ee16c332324d7de05fa2c99f9994ecc9f0779c602916a672ae4  | 2024-01-27 |
| alpine:3.17          | sha256:3451da08fc6ef554a100da3e2df5ac6d598c82f2a774d5f6ed465c3d80cd163a  | 2024-09-06 |
| alpine:3.18          | sha256:3ddf7bf1d408188f9849efbf4f902720ae08f5131bb39013518b918aa056d0de  | 2024-09-06 |
| alpine:3.19          | sha256:ae65dbf8749a7d4527648ccee1fa3deb6bfcae34cbc30fc67aa45c44dcaa90ee  | 2024-09-06 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:8ccc486c29a3ad02ad5af7f1156e2152dff3ba5634eec9be375269ef123457d8  | 2024-09-04 |
| debian:9             | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest | sha256:e0b10610709509aded9b101a61a090e24a5161f46d5eb8a479297fe96aa5d8ac  | 2024-08-15 |
| node:16              | sha256:f77a1aef2da8d83e45ec990f45df50f1a286c5fe8bbfb8c6e4246c6389705c0b  | 2023-09-07 |
| node:16-alpine       | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18              | sha256:ca07c02d13baf021ff5aadb3b48bcd1fcdd454826266ac313ce858676e8c1548  | 2024-07-09 |
| node:18-alpine       | sha256:02376a266c84acbf45bd19440e08e48b1c8b98037417334046029ab585de03e2  | 2024-07-09 |
| node:20              | sha256:48db4f6ea21d134be744207225753a1730c4bc1b4cdf836d44511c36bf0e34d7  | 2024-08-21 |
| node:20-alpine       | sha256:2d07db07a2df6830718ae2a47db6fedce6745f5bcd174c398f2acdda90a11c03  | 2024-08-21 |
| ubuntu:20.04         | sha256:fa17826afb526a9fc7250e0fbcbfd18d03fe7a54849472f86879d8bf562c629e  | 2024-08-13 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.9                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.23                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.18.28-0ubuntu0.20.04.1        |
| dpkg                   | 1.19.7ubuntu3.2                   |
| dpkg-dev               | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| findutils              | 4.7.0-1ubuntu1                    |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| g++                    | 4:9.3.0-1ubuntu2                  |
| gcc                    | 4:9.3.0-1ubuntu2                  |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3ubuntu1               |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libc6-dev              | 2.31-0ubuntu9.16                  |
| libcurl4               | 7.68.0-1ubuntu2.23                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6+deb10u1build0.20.04.1  |
| libgtk-3-0             | 3.24.20-0ubuntu1.2                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.6                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.16                  |
| m4                     | 1.4.18-4                          |
| make                   | 4.2.1-1.2                         |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.11               |
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
| sqlite3                | 3.31.1-4ubuntu0.6                 |
| ssh                    | 1:8.2p1-4ubuntu0.11               |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.5                 |
| swig                   | 4.0.1-5build1                     |
| tar                    | 1.30+dfsg-7ubuntu0.20.04.4        |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2024a-0ubuntu0.20.04.1            |
| unzip                  | 6.0-25ubuntu1.2                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2.1                 |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.17      |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

