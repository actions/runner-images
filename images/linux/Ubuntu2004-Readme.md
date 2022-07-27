| Announcements |
|-|
| [[all OSs] Android NDK 21 will be replaced in favor of 25 on August, 1st](https://github.com/actions/virtual-environments/issues/5930) |
| [[all OSs] Android ndk-bundle along with old NDK versions will be deprecated on July, 24](https://github.com/actions/virtual-environments/issues/5879) |
| [(Public Beta) Ubuntu 22.04 is now available](https://github.com/actions/virtual-environments/issues/5490) |
***
# Ubuntu 20.04.4 LTS
- Linux kernel version: 5.15.0-1014-azure
- Image Version: 20220724.1

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.0
- Clang-format 10.0.0, 11.0.0, 12.0.0
- Clang-tidy 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.0.3 (Eshell 13.0.3)
- Erlang rebar3 3.19.0
- GNU C++ 9.4.0, 10.3.0
- GNU Fortran 9.4.0, 10.3.0
- Julia 1.7.3
- Kotlin 1.7.10-release-333
- Mono 6.12.0.182 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.10.1.31701 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.16.0
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.6.2

### Package Management
- cpan 1.64
- Helm 3.9.2
- Homebrew 3.5.6
- Miniconda 4.12.0
- Npm 8.11.0
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.1.0
- RubyGems 3.1.2
- Vcpkg  (build from master \<f93ba152d>)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 7.5
- Lerna 5.2.0
- Maven 3.8.6
- Sbt 1.7.1

### Tools
- Ansible 2.13.2
- apt-fast 1.9.12
- AzCopy 10.16.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.2.0
- Bazelisk 1.12.0
- Bicep 0.8.9
- Buildah 1.22.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.23.2
- CodeQL Action Bundle 2.10.0
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.6.1+azure-1
- Docker-Buildx 0.8.2
- Docker-Moby Client 20.10.17+azure-1
- Docker-Moby Server 20.10.17+azure-1
- Fastlane 2.208.0
- Git 2.37.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.2.0 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.60.2
- HHVM (HipHop VM) 4.164.0
- jq 1.6
- Kind 0.14.0
- Kubectl 1.24.3
- Kustomize 4.5.5
- Leiningen 2.9.8
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.26.0
- n 9.0.0
- Newman 5.3.2
- nvm 0.39.1
- OpenSSL 1.1.1f-1ubuntu2.16
- Packer 1.8.2
- Parcel 2.6.2
- PhantomJS 2.1.1
- Podman 3.4.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.36.0
- R 4.2.1
- Skopeo 1.5.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.2.5
- yamllint 1.27.1
- yq 4.26.1
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.124
- AWS CLI 2.7.18
- AWS CLI Session manager plugin 1.2.339.0
- AWS SAM CLI 1.53.0
- Azure CLI (azure-cli) 2.38.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.14.2
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 10.11.1
- OpenShift CLI 4.10.23
- ORAS CLI 0.13.0
- Vercel CLI 27.2.0

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
| Tool     | Version             |
| -------- | ------------------- |
| PHP      | 7.4.30 8.0.21 8.1.8 |
| Composer | 2.3.10              |
| PHPUnit  | 8.5.27              |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.3
- GHCup 0.1.17.8
- Stack 2.7.5

### Rust Tools
- Cargo 1.62.1
- Rust 1.62.1
- Rustdoc 1.62.1
- Rustup 1.25.1

#### Packages
- Bindgen 0.60.1
- Cargo audit 0.17.0
- Cargo clippy 0.1.62
- Cargo outdated 0.11.1
- Cbindgen 0.24.3
- Rustfmt 1.4.38

### Browsers and Drivers
- Google Chrome 103.0.5060.134
- ChromeDriver 103.0.5060.134
- Chromium 103.0.5060.0
- Microsoft Edge 103.0.1264.71 (apt source repository: https://packages.microsoft.com/repos/edge)
- Microsoft Edge WebDriver 103.0.1264.71
- Selenium server 4.3.0
- Mozilla Firefox 102.0
- Geckodriver 0.31.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 3.1.120 3.1.202 3.1.302 3.1.421 5.0.104 5.0.214 5.0.303 5.0.408 6.0.302

### .NET tools
- nbgv 3.5.108+6e793d63d3

### Databases
- MongoDB 5.0.9 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.4 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 8.0.29-0ubuntu0.20.04.3
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.10.0001.1
- SqlPackage 16.0.6161.0

### Cached Tools
#### Go
- 1.16.15
- 1.17.12
- 1.18.4

#### Node.js
- 12.22.12
- 14.20.0
- 16.16.0

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 2.7.18
- 3.6.15
- 3.7.13
- 3.8.13
- 3.9.13
- 3.10.5

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.6
- 3.0.4
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.15/x64 | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.12/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.4/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.5

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Microsoft.Graph  | 1.10.0  |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.20.0  |

#### Az PowerShell Modules
- 7.5.0 3.1.0.zip 4.4.0.zip 5.9.0.zip 6.6.0.zip

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.2.10                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                       |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 21.4.7075529<br>23.2.8568313<br>24.0.8215888                                                                                                           |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                       |
| ----------------------- | ------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                  |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/24.0.8215888 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                  |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.12             | sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69  | 2022-04-05 |
| alpine:3.13             | sha256:7769c38ce671534a0ddbf98633f17edbbd4a4e99cbc77ef42f9f7b78b6a1c6c2  | 2022-07-19 |
| alpine:3.14             | sha256:43eb8f0d8215d8661f745f3d88563c026614d843b668b233bbe1666b6d026f61  | 2022-07-19 |
| buildpack-deps:bullseye | sha256:4cbb6d56f192ea1868bdbc441269d0343c90b201c973931aaa6722300118d463  | 2022-07-12 |
| buildpack-deps:buster   | sha256:3ab2863d37b2d037440b4a153a8fb3c79e935030fd47cef21b698688ce72f66e  | 2022-07-12 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:0685c900f6e691bdda6980c0ed0779d20183bc58770059b64adb56cb8a3129f0  | 2022-07-12 |
| debian:11               | sha256:2ce44bbc00a79113c296d9d25524e15d423b23303fdbbe20190d2f96e0aeb251  | 2022-07-12 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:0dc312b04eac1b44cd2cad566deb1e886c753109208affbbec8384f381ff7f38  | 2022-05-06 |
| node:12                 | sha256:01627afeb110b3054ba4a1405541ca095c8bfca1cb6f2be9479c767a2711879e  | 2022-04-20 |
| node:12-alpine          | sha256:d4b15b3d48f42059a15bd659be60afe21762aae9d6cbea6f124440895c27db68  | 2022-04-11 |
| node:14                 | sha256:a086a11f7780399837ea0465ac8a8e8f14f2b66fe5a110fe0c24644d53a103c5  | 2022-07-12 |
| node:14-alpine          | sha256:06bc5a651beb7db09a66ceb99a1d19275810d5c9dca8fb9e1ad6d69355a2f42e  | 2022-07-18 |
| node:16                 | sha256:2e1b4542d4a06e0e0442dc38af1f4828760aecc9db2b95e7df87f573640d98cd  | 2022-07-12 |
| node:16-alpine          | sha256:da32af0cf608622b1550678b2552b7d997def7d0ada00e0eca0166ed2ea42186  | 2022-07-18 |
| ubuntu:16.04            | sha256:20858ebbc96215d6c3c574f781133ebffdc7c18d98af4f294cc4c04871a6fe61  | 2021-08-31 |
| ubuntu:18.04            | sha256:478caf1bec1afd54a58435ec681c8755883b7eb843a8630091890130b15a79af  | 2022-06-06 |
| ubuntu:20.04            | sha256:fd92c36d3cb9b1d027c4d2a72c6bf0125da82425fc2ca37c414d4f010180dc19  | 2022-06-06 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.3                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| build-essential        | 12.8ubuntu1.1                     |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.12                |
| dbus                   | 1.12.16-2ubuntu2.2                |
| dnsutils               | 1:9.16.1-0ubuntu2.10              |
| dpkg                   | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.3          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libcurl4               | 7.68.0-1ubuntu2.12                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.3                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9build1                     |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
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
| rsync                  | 3.1.3-8ubuntu0.3                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.3                 |
| ssh                    | 1:8.2p1-4ubuntu0.5                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.2                 |
| swig                   | 4.0.1-5build1                     |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2022a-0ubuntu0.20.04              |
| unzip                  | 6.0-25ubuntu1                     |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.3       |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |


