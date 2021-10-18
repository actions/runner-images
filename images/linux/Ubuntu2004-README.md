| Announcements |
|-|
| [Ubuntu 16.04 environment will be removed on September 20, 2021](https://github.com/actions/virtual-environments/issues/3287) |
***
# Ubuntu 20.04.3 LTS
- Linux kernel version: 5.8.0-1042-azure
- Image Version: 20211011.1

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.0
- Clang-format 10.0.0, 11.0.0, 12.0.0
- Erlang 24.0.5 (Eshell 12.0.3)
- Erlang rebar3 3.17.0
- GNU C++ 9.3.0, 10.3.0
- GNU Fortran 9.3.0, 10.3.0
- Julia 1.6.3
- Kotlin 1.5.31-release-548
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 14.18.0
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.5

### Package Management
- cpan 1.64
- Helm 3.7.0
- Homebrew 3.2.15
- Miniconda 4.10.3
- Npm 6.14.15
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 0.16.4
- RubyGems 3.1.2
- Vcpkg  (build from master \<973a7d5>)
- Yarn 1.22.15

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 7.2
- Lerna 4.0.0
- Maven 3.8.3
- Sbt 1.5.5

### Tools
- Ansible 2.11.5
- apt-fast 1.9.11
- AzCopy 10.12.2 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.2.1
- Bazelisk 1.10.1
- Bicep 0.4.613
- Buildah 1.21.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.21.3
- CodeQL Action Bundle 2.6.3
- Docker Compose v1 1.29.2
- Docker Compose v2 2.0.0
- Docker-Buildx 0.6.3
- Docker-Moby Client 20.10.9+azure-1
- Docker-Moby Server 20.10.9+azure-1
- Fastlane 2.195.0
- Git 2.33.0 (apt source repository: ppa:git-core/ppa)
- Git LFS 2.13.3 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.59.0
- HHVM (HipHop VM) 4.130.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.22.2
- Kustomize 4.4.0
- Leiningen 2.9.7
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.23.2
- Newman 5.3.0
- nvm 0.39.0
- OpenSSL 1.1.1f  31 Mar 2020
- Packer 1.7.6
- PhantomJS 2.1.1
- Podman 3.3.1 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.14.0
- R 4.1.1
- Skopeo 1.3.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.0.8
- yamllint 1.26.3
- yq 4.13.4
- zstd 1.5.0 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.94
- AWS CLI 2.2.44
- AWS CLI Session manager plugin 1.2.245.0
- AWS SAM CLI 1.33.0
- Azure CLI (azure-cli) 2.28.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.20.0
- GitHub CLI 2.0.0
- Google Cloud SDK 360.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 6.10.4
- OpenShift CLI 4.8.13
- ORAS CLI 0.12.0
- Vercel CLI 23.1.2

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.292+1           | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 11.0.11+9 (default) | Adopt OpenJDK | JAVA_HOME_11_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 21.2.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version       |
| -------- | ------------- |
| PHP      | 7.4.24 8.0.11 |
| Composer | 2.1.9         |
| PHPUnit  | 8.5.21        |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.4.1.0
- GHC 9.0.1
- GHCup 0.1.17.2
- Stack 2.7.3

### Rust Tools
- Cargo 1.55.0
- Rust 1.55.0
- Rustdoc 1.55.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.1
- Cargo audit 0.15.2
- Cargo clippy 0.1.55
- Cargo outdated 0.9.17
- Cbindgen 0.20.0
- Rustfmt 1.4.37

### Browsers and Drivers
- Google Chrome 94.0.4606.81
- ChromeDriver 94.0.4606.61
- Mozilla Firefox 93.0
- Geckodriver 0.30.0
- Chromium 94.0.4606.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.302 2.1.403 2.1.526 2.1.617 2.1.701 2.1.818 3.1.119 3.1.202 3.1.302 3.1.413 5.0.104 5.0.207 5.0.303 5.0.401

### Databases
- MongoDB 5.0.3 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- PostgreSQL 14.0 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- sqlite3 3.31.1

#### MySQL
- MySQL 8.0.26
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.8.0001.1
- SqlPackage 15.0.5282.3

### Cached Tools
#### Go
- 1.14.15
- 1.15.15
- 1.16.9
- 1.17.2

#### Node.js
- 10.24.1
- 12.22.6
- 14.18.0

#### PyPy
- 2.7.18 [PyPy 7.3.5]
- 3.6.12 [PyPy 7.3.3]
- 3.7.10 [PyPy 7.3.5]

#### Python
- 2.7.18
- 3.5.10
- 3.6.15
- 3.7.12
- 3.8.12
- 3.9.7

#### Ruby
- 2.5.9
- 2.6.8
- 2.7.4
- 3.0.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_14_X64 | /opt/hostedtoolcache/go/1.14.15/x64 | x64          |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.15/x64 | x64          |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.9/x64  | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.2/x64  | x64          |

### PowerShell Tools
- PowerShell 7.1.4

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Pester           | 5.3.1   |
| PSScriptAnalyzer | 1.20.0  |

#### Az PowerShell Modules
- 6.4.0 3.1.0.zip 4.4.0.zip 5.9.0.zip

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                |
| Android Emulator           | 30.8.4                                                                                                                             |
| Android SDK Build-tools    | 31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 31.0.3                                                                                                                             |
| Android SDK Platforms      | android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)                         |
| Android SDK Tools          | 26.1.1                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                             |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                   |
| Google Play services       | 49                                                                                                                                 |
| Google Repository          | 58                                                                                                                                 |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.0.7599858                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                  |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/23.0.7599858                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.12             | sha256:a296b4c6f6ee2b88f095b61e95c7ef4f51ba25598835b4978c9256d8c8ace48a  | 2021-08-31 |
| alpine:3.13             | sha256:2582893dec6f12fd499d3a709477f2c0c0c1dfcd28024c93f1f0626b9e3540c8  | 2021-08-31 |
| alpine:3.14             | sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a  | 2021-08-27 |
| buildpack-deps:bullseye | sha256:781dbad21bcc644af42ec465c2adbf6d9470b256755a13b2a2eadadf331cdaf9  | 2021-09-28 |
| buildpack-deps:buster   | sha256:4ab33f2a6712321207d5736d6899841e03d3cc26d50fb7489b0e4a48bf42a1d0  | 2021-09-28 |
| buildpack-deps:stretch  | sha256:57d5d14748554b31c75a2e95e63c51e8cdfb24393e33c1431982123b7d0c2280  | 2021-09-28 |
| debian:10               | sha256:e5cfab8012b17d80f93a7f567797b0c8a2839069d4f50e499152162152518663  | 2021-09-28 |
| debian:11               | sha256:b6a47ddbc1de53e0024d19908f5ef7b3d870686f1234fdb2d19770e097db1575  | 2021-09-28 |
| debian:9                | sha256:c1274c24446b98394e1594ceefac1012e1b39b752586ca993fe3c3bea6f6d20f  | 2021-09-28 |
| moby/buildkit:latest    | sha256:94bc3a93cfa5197064cfdc86e4289cead7b46a2bc95874f142fbf51c67ad2826  | 2021-10-04 |
| node:10                 | sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911  | 2021-04-10 |
| node:10-alpine          | sha256:dc98dac24efd4254f75976c40bce46944697a110d06ce7fa47e7268470cf2e28  | 2021-04-14 |
| node:12                 | sha256:86afd89e91d667a65b37e05659974ccd702b8e3b1aff30416d1f77cf67729e2b  | 2021-09-28 |
| node:12-alpine          | sha256:1ea5900145028957ec0e7b7e590ac677797fa8962ccec4e73188092f7bc14da5  | 2021-08-31 |
| node:14                 | sha256:167d0a4af6b4e0d0769086b871a36c25faed75b72705144cabbda70466cc0d8e  | 2021-09-29 |
| node:14-alpine          | sha256:6e52e0b3bedfb494496488514d18bee7fd503fd4e44289ea012ad02f8f41a312  | 2021-09-29 |
| ubuntu:16.04            | sha256:454054f5bbd571b088db25b662099c6c7b3f0cb78536a2077d54adc48f00cd68  | 2021-08-31 |
| ubuntu:18.04            | sha256:bfb4cabd667790ead5c95d9fe341937f0c21118fa79bc768d51c5da9d1dbe917  | 2021-10-01 |
| ubuntu:20.04            | sha256:a0d9e826ab87bd665cfc640598a871b748b4b70a01a4f3d174d4fb02adad07a9  | 2021-10-01 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| binutils               | 2.34-6ubuntu1.1                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| build-essential        | 12.8ubuntu1.1                     |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.7                 |
| dbus                   | 1.12.16-2ubuntu2.1                |
| dnsutils               | 1:9.16.1-0ubuntu2.8               |
| dpkg                   | 1.19.7ubuntu3                     |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.1                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.2          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libcurl4               | 7.68.0-1ubuntu2.7                 |
| libgbm-dev             | 21.0.3-0ubuntu0.3\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1                  |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.2                 |
| libunwind8             | 1.2.1-9build1                     |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| locales                | 2.31-0ubuntu9.2                   |
| m4                     | 1.4.18-4                          |
| mediainfo              | 19.09-1build1                     |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.3                |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8                           |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.2                 |
| ssh                    | 1:8.2p1-4ubuntu0.3                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3                          |
| sudo                   | 1.8.31-1ubuntu1.2                 |
| swig                   | 4.0.1-5build1                     |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2021a-2ubuntu0.20.04              |
| unzip                  | 6.0-25ubuntu1                     |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu1                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.11-1ubuntu1\~20.04.2       |
| xz-utils               | 5.2.4-1ubuntu1                    |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |


