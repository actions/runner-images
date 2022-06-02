| Announcements |
|-|
| [[all OSs] Android NDK 22 will be replaced in favor of 24, version 23 will be set as the default one on June, 6](https://github.com/actions/virtual-environments/issues/5595) |
| [(Public Beta) Ubuntu 22.04 is now available](https://github.com/actions/virtual-environments/issues/5490) |
***
# Ubuntu 22.04 LTS
- Linux kernel version: 5.15.0-1007-azure
- Image Version: 20220601.2

## Installed Software
### Language and Runtime
- Bash 5.1.16(1)-release
- Clang 12.0.1, 13.0.1, 14.0.0
- Clang-format 12.0.1, 13.0.1, 14.0.0
- Clang-tidy 12.0.1, 13.0.1, 14.0.0
- GNU C++ 9.4.0, 10.3.0, 11.2.0
- GNU Fortran 9.4.0, 10.3.0, 11.2.0
- Julia 1.7.3
- Kotlin 1.6.21-release-334
- Node 16.15.0
- Perl 5.34.0
- Python 3.10.4
- Python3 3.10.4
- Ruby 3.0.2p107

### Package Management
- cpan 1.64
- Helm 3.9.0
- Homebrew 3.4.11
- Miniconda 4.12.0
- Npm 8.5.5
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.1.0
- RubyGems 3.3.5
- Vcpkg  (build from master \<f78f4440d>)
- Yarn 1.22.18

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Lerna 5.0.0

### Tools
- Ansible 2.12.6
- apt-fast 1.9.12
- AzCopy 10.15.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.1.1
- Bazelisk 1.11.0
- Bicep 0.6.18
- Buildah 1.23.1
- CMake 3.23.2
- CodeQL Action Bundle 2.9.2
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.4.1+azure-1
- Docker-Buildx 0.8.2
- Docker-Moby Client 20.10.15+azure-1
- Docker-Moby Server 20.10.16+azure-2
- Fastlane 2.206.2
- Git 2.36.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.2.0 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 7.60.2
- jq 1.6
- Kind 0.14.0
- Kubectl 1.24.1
- Kustomize 4.5.5
- Leiningen 2.9.8
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.25.2
- n 8.2.0
- Newman 5.3.2
- nvm 0.39.1
- OpenSSL 3.0.2-0ubuntu1.2
- Packer 1.8.1
- Parcel 2.6.0
- Podman 3.4.4
- Pulumi 3.33.2
- R 4.2.0
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.2.1
- yamllint 1.26.3
- yq 4.25.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.121
- AWS CLI 2.7.4
- AWS CLI Session manager plugin 1.2.331.0
- AWS SAM CLI 1.51.0
- Azure CLI (azure-cli) 2.37.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.11.3
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 10.4.0
- OpenShift CLI 4.10.15
- ORAS CLI 0.12.0
- Vercel CLI 24.2.5

### Java
| Version              | Vendor          | Environment Variable |
| -------------------- | --------------- | -------------------- |
| 8.0.332+9            | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.15+10 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.3+7             | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.1.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version |
| -------- | ------- |
| PHP      | 8.1.6   |
| Composer | 2.3.5   |
| PHPUnit  | 8.5.26  |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.3
- GHCup 0.1.17.8
- Stack 2.7.5

### Rust Tools
- Cargo 1.61.0
- Rust 1.61.0
- Rustdoc 1.61.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo audit 0.17.0
- Cargo clippy 0.1.61
- Cargo outdated 0.11.1
- Cbindgen 0.23.0
- Rustfmt 1.4.38

### Browsers and Drivers
- Google Chrome 102.0.5005.61
- ChromeDriver 102.0.5005.61
- Chromium 102.0.5005.0
- Selenium server 4.2.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| GECKOWEBDRIVER    |                                     |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 6.0.300

### .NET tools
- nbgv 3.5.107+6463ef6068

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.3 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 8.0.29-0ubuntu0.22.04.2
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
### Cached Tools
#### Go
- 1.17.10
- 1.18.2

#### Node.js
- 14.19.3
- 16.15.0

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 3.7.13
- 3.8.12
- 3.9.13
- 3.10.4

#### Ruby
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.10/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.2/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.4

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Microsoft.Graph  | 1.9.6   |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.20.0  |

#### Az PowerShell Modules
- 7.3.2

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                      |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 7.0                                                                                                                                          |
| Android Emulator           | 31.2.10                                                                                                                                      |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                       |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)             |
| Android SDK Tools          | 26.1.1                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                       |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                           |
| Google Repository          | 58                                                                                                                                           |
| NDK                        | 21.4.7075529<br>23.2.8568313 (default)<br>24.0.8215888                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                            |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/23.2.8568313 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/24.0.8215888                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/23.2.8568313 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.14             | sha256:06b5d462c92fc39303e6363c65e074559f8d6b1363250027ed5053557e3398c5  | 2022-04-05 |
| alpine:3.15             | sha256:4edbd2beb5f78b1014028f4fbb99f3237d9561100b6881aabbf5acce2c4f9454  | 2022-04-05 |
| buildpack-deps:bullseye | sha256:898c2264db514062f89391a9ae58e25bfcaa94d9fed04abf789a4abb53ee2fd6  | 2022-05-28 |
| buildpack-deps:buster   | sha256:3a56627334c11ff56aa16fa7c8922cfc17d506fe41f9155e350b1e02edb0e77d  | 2022-05-28 |
| debian:10               | sha256:e5b41ae2b4cf0d04b80cd2f89724e9cfc09e334ac64f188b9808929c748af526  | 2022-05-28 |
| debian:11               | sha256:3f1d6c17773a45c97bd8f158d665c9709d7b29ed7917ac934086ad96f92e4510  | 2022-05-28 |
| moby/buildkit:latest    | sha256:0dc312b04eac1b44cd2cad566deb1e886c753109208affbbec8384f381ff7f38  | 2022-05-06 |
| node:14                 | sha256:3324c688c0e98888f8938509f35356acf69a3e1f9f385d85f7e6086b137c17e3  | 2022-05-28 |
| node:14-alpine          | sha256:c9b8829068199346e2a9ae46f870bbb82ce44de6580321300bf3945d00dee0f1  | 2022-05-18 |
| node:16                 | sha256:59eb4e9d6a344ae1161e7d6d8af831cb50713cc631889a5a8c2d438d6ec6aa0f  | 2022-05-28 |
| node:16-alpine          | sha256:1a9a71ea86aad332aa7740316d4111ee1bd4e890df47d3b5eff3e5bded3b3d10  | 2022-04-27 |
| ubuntu:18.04            | sha256:d21b6ba9e19feffa328cb3864316e6918e30acfd55e285b5d3df1d8ca3c7fd3f  | 2022-04-29 |
| ubuntu:20.04            | sha256:47f14534bda344d9fe6ffd6effb95eefe579f4be0d508b7445cf77f61a0e5724  | 2022-04-29 |
| ubuntu:22.04            | sha256:26c68657ccce2cb0a31b330cb0be2b5e108d467f641c62e13ab40cbec258c68d  | 2022-04-29 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.3.1-1                           |
| aria2                  | 1.36.0-1                          |
| autoconf               | 2.71-2                            |
| automake               | 1:1.16.5-1.3                      |
| binutils               | 2.38-3ubuntu1                     |
| bison                  | 2:3.8.2+dfsg-1build1              |
| brotli                 | 1.0.9-2build6                     |
| build-essential        | 12.9ubuntu3                       |
| bzip2                  | 1.0.8-5build1                     |
| coreutils              | 8.32-4.1ubuntu1                   |
| curl                   | 7.81.0-1ubuntu1.2                 |
| dbus                   | 1.12.20-2ubuntu4                  |
| dnsutils               | 1:9.18.1-1ubuntu1.1               |
| dpkg                   | 1.21.1ubuntu2.1                   |
| fakeroot               | 1.28-1ubuntu1                     |
| file                   | 1:5.41-3                          |
| flex                   | 2.6.4-8build2                     |
| fonts-noto-color-emoji | 2.034-1                           |
| ftp                    | 20210827-4build1                  |
| gnupg2                 | 2.2.27-3ubuntu2                   |
| haveged                | 1.9.14-1ubuntu1                   |
| imagemagick            | 8:6.9.11.60+dfsg-1.3build2        |
| iproute2               | 5.15.0-1ubuntu2                   |
| iputils-ping           | 3:20211215-1                      |
| jq                     | 1.6-2.1ubuntu3                    |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9            |
| libc++-dev             | 1:14.0-55\~exp2                   |
| libc++abi-dev          | 1:14.0-55\~exp2                   |
| libcurl4               | 7.81.0-1ubuntu1.2                 |
| libgbm-dev             | 22.0.1-1ubuntu2                   |
| libgconf-2-4           | 3.2.6-7ubuntu2                    |
| libgsl-dev             | 2.7.1+dfsg-3                      |
| libgtk-3-0             | 3.24.33-1ubuntu2                  |
| libmagic-dev           | 1:5.41-3                          |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libsecret-1-dev        | 0.20.5-2                          |
| libsqlite3-dev         | 3.37.2-2                          |
| libssl-dev             | 3.0.2-0ubuntu1.2                  |
| libtool                | 2.4.6-15build2                    |
| libunwind8             | 1.3.2-2build2                     |
| libxkbfile-dev         | 1:1.1.0-1build3                   |
| libxss1                | 1:1.2.3-1build2                   |
| locales                | 2.35-0ubuntu3                     |
| m4                     | 1.4.18-5ubuntu2                   |
| mediainfo              | 22.03-1                           |
| mercurial              | 6.1.1-1ubuntu1                    |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5 |
| netcat                 | 1.218-4ubuntu1                    |
| openssh-client         | 1:8.9p1-3                         |
| p7zip-full             | 16.02+dfsg-8                      |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20210822+ds-2                     |
| pass                   | 1.7.4-5                           |
| patchelf               | 0.14.3-1                          |
| pkg-config             | 0.29.2-1ubuntu3                   |
| pollinate              | 4.33-3ubuntu2                     |
| python-is-python3      | 3.9.2-2                           |
| rpm                    | 4.17.0+dfsg1-4build1              |
| rsync                  | 3.2.3-8ubuntu3                    |
| shellcheck             | 0.8.0-2                           |
| sphinxsearch           | 2.2.11-8                          |
| sqlite3                | 3.37.2-2                          |
| ssh                    | 1:8.9p1-3                         |
| sshpass                | 1.09-1                            |
| subversion             | 1.14.1-3ubuntu0.22.04.1           |
| sudo                   | 1.9.9-1ubuntu2                    |
| swig                   | 4.0.2-1ubuntu1                    |
| telnet                 | 0.17-44build1                     |
| texinfo                | 6.8-4build1                       |
| time                   | 1.9-0.1build2                     |
| tk                     | 8.6.11+1build2                    |
| tzdata                 | 2022a-0ubuntu1                    |
| unzip                  | 6.0-26ubuntu3                     |
| upx                    | 3.96-3                            |
| wget                   | 1.21.2-2ubuntu1                   |
| xorriso                | 1.5.4-2                           |
| xvfb                   | 2:21.1.3-2ubuntu2                 |
| xz-utils               | 5.2.5-2ubuntu1                    |
| zip                    | 3.0-12build2                      |
| zsync                  | 0.6.2-3ubuntu1                    |


