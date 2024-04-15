| Announcements |
|-|
| [[Ubuntu] ubuntu-toolchain-r/test repository will be removed from images on May 6](https://github.com/actions/runner-images/issues/9679) |
***
# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1060-azure
- Image Version: 20240414.1.0
- Systemd version: 245.4-4ubuntu3.23

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.3 (Eshell 13.2)
- Erlang rebar3 3.23.0
- GNU C++: 9.4.0, 10.5.0
- GNU Fortran: 9.4.0, 10.5.0
- Julia 1.10.2
- Kotlin 1.9.23-release-779
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.2
- Perl 5.30.0
- Python 3.8.10
- Ruby 2.7.0p0
- Swift 5.10

### Package Management
- cpan 1.64
- Helm 3.14.4
- Homebrew 4.2.17
- Miniconda 24.1.2
- Npm 10.5.0
- NuGet 6.6.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.5.0
- RubyGems 3.1.2
- Vcpkg (build from commit ad3bae574)
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
- Gradle 8.7
- Lerna 8.1.2
- Maven 3.8.8
- Sbt 1.9.9

### Tools
- Ansible 2.13.13
- apt-fast 1.10.0
- AzCopy 10.24.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 7.1.1
- Bazelisk 1.19.0
- Bicep 0.26.170
- Buildah 1.22.3
- CMake 3.29.2
- CodeQL Action Bundle 2.17.0
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.23.3
- Docker-Buildx 0.13.1
- Docker Client 24.0.9
- Docker Server 24.0.9
- Fastlane 2.220.0
- Git 2.43.2
- Git LFS 3.5.1
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 8.11.2
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.22.0
- Kubectl 1.29.3
- Kustomize 5.4.1
- Leiningen 2.11.2
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.32.0
- n 9.2.1
- Newman 6.1.2
- nvm 0.39.7
- OpenSSL 1.1.1f-1ubuntu2.22
- Packer 1.10.2
- Parcel 2.12.0
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.112.0
- R 4.3.3
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.8.0
- yamllint 1.35.1
- yq 4.43.1
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.174
- AWS CLI 2.15.38
- AWS CLI Session Manager Plugin 1.2.553.0
- AWS SAM CLI 1.115.0
- Azure CLI 2.59.0
- Azure CLI (azure-devops) 1.0.0
- GitHub CLI 2.47.0
- Google Cloud CLI 471.0.0
- Netlify CLI 17.22.1
- OpenShift CLI 4.15.8
- ORAS CLI 1.1.0
- Vercel CLI 34.0.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.402+6           | JAVA_HOME_8_X64      |
| 11.0.22+7 (default) | JAVA_HOME_11_X64     |
| 17.0.10+7           | JAVA_HOME_17_X64     |
| 21.0.2+13           | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 7.4.33, 8.0.30, 8.1.27, 8.2.18, 8.3.6
- Composer 2.7.2
- PHPUnit 8.5.38
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.3.0
- GHC 9.8.2
- GHCup 0.1.22.0
- Stack 2.15.5

### Rust Tools
- Cargo 1.77.2
- Rust 1.77.2
- Rustdoc 1.77.2
- Rustup 1.27.0

#### Packages
- Bindgen 0.69.4
- Cargo audit 0.20.0
- Cargo clippy 0.1.77
- Cargo outdated 0.15.0
- Cbindgen 0.26.0
- Rustfmt 1.7.0

### Browsers and Drivers
- Google Chrome 123.0.6312.122
- ChromeDriver 123.0.6312.122
- Chromium 123.0.6312.0
- Microsoft Edge 123.0.2420.97
- Microsoft Edge WebDriver 123.0.2420.97
- Selenium server 4.19.1
- Mozilla Firefox 125.0
- Geckodriver 0.34.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.421, 7.0.408, 8.0.204
- nbgv 3.6.133+2d32d93cb1

### Databases
- MongoDB 5.0.26
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.11
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.36-0ubuntu0.20.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.2.111.2

### Cached Tools

#### Go
- 1.20.14
- 1.21.9
- 1.22.2

#### Node.js
- 16.20.2
- 18.20.2
- 20.12.2

#### Python
- 3.7.17
- 3.8.18
- 3.9.19
- 3.10.14
- 3.11.9
- 3.12.3

#### PyPy
- 2.7.18 [PyPy 7.3.15]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.18 [PyPy 7.3.15]
- 3.10.13 [PyPy 7.3.15]

#### Ruby
- 3.0.6
- 3.1.4

### PowerShell Tools
- PowerShell 7.4.1

#### PowerShell Modules
- Az: 11.3.1
- MarkdownPS: 1.9
- Microsoft.Graph: 2.17.0
- Pester: 5.5.0
- PSScriptAnalyzer: 1.22.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                           |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                               |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                         |
| Android SDK Platforms      | android-34-ext8 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                            |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                        |
| Google Play services       | 49                                                                                                                                                                                                |
| Google Repository          | 58                                                                                                                                                                                                |
| NDK                        | 24.0.8215888<br>25.2.9519653 (default)<br>26.3.11579264                                                                                                                                           |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag       | Digest                                                                   | Created    |
| -------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16          | sha256:452e7292acee0ee16c332324d7de05fa2c99f9994ecc9f0779c602916a672ae4  | 2024-01-27 |
| alpine:3.17          | sha256:53cf9478b76f4c8fae126acbdfb79bed6e69e628faff572ebe4a029d3d247d98  | 2024-01-27 |
| alpine:3.18          | sha256:11e21d7b981a59554b3f822c49f6e9f57b6068bb74f49c4cd5cc4c663c7e5160  | 2024-01-27 |
| debian:10            | sha256:873743c4eec09ddea0dcac0cda31fce2ff348ed41cd1d5c33ecee7d42f03052f  | 2024-04-10 |
| debian:11            | sha256:26d72b71f88865377988af6f54da9aaa5bed201f39bcee13eb55737016660df2  | 2024-04-10 |
| debian:9             | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest | sha256:00d2c6b8f39ae515e0eadd74f39e71a5efdc94321c9b919692a2aa32deef2bb1  | 2024-03-18 |
| node:16              | sha256:f77a1aef2da8d83e45ec990f45df50f1a286c5fe8bbfb8c6e4246c6389705c0b  | 2023-09-07 |
| node:16-alpine       | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18              | sha256:bdbe1cff7e74208531a90ffcfa32b1cb909d4720d9aa60b649b26b9e7ba439a5  | 2024-04-11 |
| node:18-alpine       | sha256:80338ff3fc4e989c1d5264a23223cec1c6014e812e584e825e78d1a98d893381  | 2024-04-11 |
| node:20              | sha256:844b41cf784f66d7920fd673f7af54ca7b81e289985edc6cd864e7d05e0d133c  | 2024-04-11 |
| node:20-alpine       | sha256:ec0c413b1d84f3f7f67ec986ba885930c57b5318d2eb3abc6960ee05d4f2eb28  | 2024-04-11 |
| ubuntu:20.04         | sha256:80ef4a44043dec4490506e6cc4289eeda2d106a70148b74b5ae91ee670e9c35d  | 2024-02-16 |

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
| curl                   | 7.68.0-1ubuntu2.22                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.16.48-0ubuntu0.20.04.1        |
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
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.9    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3ubuntu1               |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libc6-dev              | 2.31-0ubuntu9.14                  |
| libcurl4               | 7.68.0-1ubuntu2.22                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6+deb10u1build0.20.04.1  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.9    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.9    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.6                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.14                  |
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
| tzdata                 | 2024a-0ubuntu0.20.04              |
| unzip                  | 6.0-25ubuntu1.2                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.17      |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

