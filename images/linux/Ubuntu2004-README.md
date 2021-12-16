# Ubuntu 20.04.3 LTS
- Linux kernel version: 5.11.0-1022-azure
- Image Version: 20211214.2

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.0
- Clang-format 10.0.0, 11.0.0, 12.0.0
- Erlang 24.1.7 (Eshell 12.1.5)
- Erlang rebar3 3.17.0
- GNU C++ 9.3.0, 10.3.0
- GNU Fortran 9.3.0, 10.3.0
- Julia 1.7.0
- Kotlin 1.6.0-release-798
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.13.1
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.5.2

### Package Management
- cpan 1.64
- Helm 3.7.2
- Homebrew 3.3.8
- Miniconda 4.10.3
- Npm 8.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 0.16.4
- RubyGems 3.1.2
- Vcpkg  (build from master \<a9ff505c5>)
- Yarn 1.22.17

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 7.3.1
- Lerna 4.0.0
- Maven 3.8.4
- Sbt 1.5.6

### Tools
- Ansible 2.12.1
- apt-fast 1.9.11
- AzCopy 10.13.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.2.2
- Bazelisk 1.11.0
- Bicep 0.4.1008
- Buildah 1.21.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.22.1
- CodeQL Action Bundle 2.7.3
- Docker Compose v1 1.29.2
- Docker Compose v2 2.2.2+azure-1
- Docker-Buildx 0.7.1
- Docker-Moby Client 20.10.11+azure-3
- Docker-Moby Server 20.10.11+azure-3
- Fastlane 2.199.0
- Git 2.34.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.0.2 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.59.2
- HHVM (HipHop VM) 4.139.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.23.0
- Kustomize 4.4.1
- Leiningen 2.9.8
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.24.0
- n 8.0.1
- Newman 5.3.0
- nvm 0.39.0
- OpenSSL 1.1.1f  31 Mar 2020
- Packer 1.7.8
- PhantomJS 2.1.1
- Podman 3.4.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.19.0
- R 4.1.2
- Skopeo 1.3.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.1.0
- yamllint 1.26.3
- yq 4.16.1
- zstd 1.5.0 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.101
- AWS CLI 2.4.6
- AWS CLI Session manager plugin 1.2.279.0
- AWS SAM CLI 1.36.0
- Azure CLI (azure-cli) 2.31.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.22.0
- GitHub CLI 2.3.0
- Google Cloud SDK 366.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 8.1.1
- OpenShift CLI 4.9.11
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
| CE 21.3.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version             |
| -------- | ------------------- |
| PHP      | 7.4.26 8.0.13 8.1.0 |
| Composer | 2.1.14              |
| PHPUnit  | 8.5.21              |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.1
- GHCup 0.1.17.4
- Stack 2.7.3

### Rust Tools
- Cargo 1.57.0
- Rust 1.57.0
- Rustdoc 1.57.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo audit 0.16.0
- Cargo clippy 0.1.57
- Cargo outdated 0.10.2
- Cbindgen 0.20.0
- Rustfmt 1.4.37

### Browsers and Drivers
- Google Chrome 96.0.4664.110
- ChromeDriver 96.0.4664.45
- Mozilla Firefox 95.0
- Geckodriver 0.30.0
- Chromium 96.0.4664.0
- Selenium server 4.1.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 2.1.302 2.1.403 2.1.526 2.1.617 2.1.701 2.1.818 3.1.120 3.1.202 3.1.302 3.1.415 5.0.104 5.0.209 5.0.303 5.0.403

### Databases
- MongoDB 5.0.5 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- PostgreSQL 14.1 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
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
- 1.15.15
- 1.16.12
- 1.17.5

#### Node.js
- 12.22.7
- 14.18.2
- 16.13.1

#### PyPy
- 2.7.18 [PyPy 7.3.6]
- 3.6.12 [PyPy 7.3.3]
- 3.7.12 [PyPy 7.3.7]
- 3.8.12 [PyPy 7.3.7]

#### Python
- 2.7.18
- 3.5.10
- 3.6.15
- 3.7.12
- 3.8.12
- 3.9.9
- 3.10.1

#### Ruby
- 2.5.9
- 2.6.9
- 2.7.5
- 3.0.3

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.15/x64 | x64          |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.12/x64 | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.5/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.0

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
| Package Name               | Version                                                                                                                                      |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                          |
| Android Emulator           | 31.1.4                                                                                                                                       |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 31.0.3                                                                                                                                       |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)             |
| Android SDK Tools          | 26.1.1                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                       |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                           |
| Google Repository          | 58                                                                                                                                           |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.1.7779620                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                            |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/23.1.7779620                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.12             | sha256:d9459083f962de6bd980ae6a05be2a4cf670df6a1d898157bceb420342bec280  | 2021-11-12 |
| alpine:3.13             | sha256:026f721af4cf2843e07bba648e158fb35ecc876d822130633cc49f707f0fc88c  | 2021-11-12 |
| alpine:3.14             | sha256:635f0aa53d99017b38d1a0aa5b2082f7812b03e3cdb299103fe77b5c8a07f1d2  | 2021-11-12 |
| buildpack-deps:bullseye | sha256:5445b145c8a1a2f7e5a4b233f571c629aed12fce435496f942ad267f21a05ff2  | 2021-12-02 |
| buildpack-deps:buster   | sha256:c11cd0a4c97acd1aa8d2289aee5c126ac78adc48108744c104f6741cbd9a1f6c  | 2021-12-02 |
| buildpack-deps:stretch  | sha256:bb93e2c2858cb20f7f16e433773adb2c583fce38dc9c71976c62bf098f956093  | 2021-12-02 |
| debian:10               | sha256:5b57f8c365c40fde437d53b953c436995525be7c481eb0128b1cbf3b49b0df18  | 2021-12-02 |
| debian:11               | sha256:45ee40a844048c2f6d0105899c1a17733530b56d481612608aab5e2e4048570b  | 2021-12-02 |
| debian:9                | sha256:aa78ddaa7f8a14bad8f940ebff5542377f91843f6dcc168e41a8628c6007e815  | 2021-12-02 |
| moby/buildkit:latest    | sha256:d6c89b7085b106301645ddcc77cf64eb7b705ab507b72d52d130ac33f1300417  | 2021-11-18 |
| node:12                 | sha256:eb92ed2473762b6d11736a4b4345aa3ef68f773999fe633bc4d9c91fa5d8f9d6  | 2021-12-02 |
| node:12-alpine          | sha256:0eca266c5fe38ba93aebac00e45c9ac1bb7328b0702a6dc10e1a6ea543d49301  | 2021-11-13 |
| node:14                 | sha256:52c884d7cf8509c27def168415a1ff23a0bd95d358dd5787ca77b60474dcb3db  | 2021-12-02 |
| node:14-alpine          | sha256:7bcf853eeb97a25465cb385b015606c22e926f548cbd117f85b7196df8aa0d29  | 2021-12-02 |
| node:16                 | sha256:89b59ce49929d8a8e230946bdb1b58c14cdbbb86c9a7397610afcecfce1be035  | 2021-12-02 |
| node:16-alpine          | sha256:a9b9cb880fa429b0bea899cd3b1bc081ab7277cc97e6d2dcd84bd9753b2027e1  | 2021-12-02 |
| ubuntu:16.04            | sha256:0f71fa8d4d2d4292c3c617fda2b36f6dabe5c8b6e34c3dc5b0d17d4e704bd39c  | 2021-08-31 |
| ubuntu:18.04            | sha256:0fedbd5bd9fb72089c7bbca476949e10593cebed9b1fb9edf5b79dbbacddd7d6  | 2021-10-01 |
| ubuntu:20.04            | sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322  | 2021-10-16 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| binutils               | 2.34-6ubuntu1.3                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| build-essential        | 12.8ubuntu1.1                     |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.7                 |
| dbus                   | 1.12.16-2ubuntu2.1                |
| dnsutils               | 1:9.16.1-0ubuntu2.9               |
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
| libgbm-dev             | 21.0.3-0ubuntu0.3\~20.04.5        |
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
| mercurial              | 5.3.1-1ubuntu1                    |
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
| rsync                  | 3.1.3-8ubuntu0.1                  |
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
| tzdata                 | 2021e-0ubuntu0.20.04              |
| unzip                  | 6.0-25ubuntu1                     |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.11-1ubuntu1\~20.04.2       |
| xz-utils               | 5.2.4-1ubuntu1                    |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

