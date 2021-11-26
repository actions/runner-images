| Announcements |
|-|
| [[all OSs] Default Nodejs version will be set to 16 on November, 29](https://github.com/actions/virtual-environments/issues/4446) |
| [[all OSs] Selenium server version will be upgraded from 3 to 4 on November, 15](https://github.com/actions/virtual-environments/issues/4376) |
| [[Ubuntu] Node:10 docker images will be removed on November, 15](https://github.com/actions/virtual-environments/issues/4357) |
| [[All OSs] Node.js version 10 will be removed from the images on November, 15](https://github.com/actions/virtual-environments/issues/4356) |
***
# Ubuntu 20.04.3 LTS
- Linux kernel version: 5.11.0-1021-azure
- Image Version: 20211122.1

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.0
- Clang-format 10.0.0, 11.0.0, 12.0.0
- Erlang 24.1.5 (Eshell 12.1.5)
- Erlang rebar3 3.17.0
- GNU C++ 9.3.0, 10.3.0
- GNU Fortran 9.3.0, 10.3.0
- Julia 1.6.4
- Kotlin 1.6.0-release-798
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 14.18.1
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.5.1

### Package Management
- cpan 1.64
- Helm 3.7.1
- Homebrew 3.3.4
- Miniconda 4.10.3
- Npm 6.14.15
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 0.16.4
- RubyGems 3.1.2
- Vcpkg  (build from master \<653912591>)
- Yarn 1.22.17

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 7.3
- Lerna 4.0.0
- Maven 3.8.4
- Sbt 1.5.5

### Tools
- Ansible 2.11.6
- apt-fast 1.9.11
- AzCopy 10.13.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.2.1
- Bazelisk 1.10.1
- Bicep 0.4.1008
- Buildah 1.21.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.22.0
- CodeQL Action Bundle 2.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.1.1+azure-1
- Docker-Buildx 0.7.0
- Docker-Moby Client 20.10.11+azure-1
- Docker-Moby Server 20.10.11+azure-1
- Fastlane 2.198.1
- Git 2.34.0 (apt source repository: ppa:git-core/ppa)
- Git LFS 2.13.3 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.59.2
- HHVM (HipHop VM) 4.136.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.22.4
- Kustomize 4.4.1
- Leiningen 2.9.8
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.24.0
- n 8.0.0
- Newman 5.3.0
- nvm 0.39.0
- OpenSSL 1.1.1f  31 Mar 2020
- Packer 1.7.8
- PhantomJS 2.1.1
- Podman 3.4.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.18.0
- R 4.1.2
- Skopeo 1.3.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.0.11
- yamllint 1.26.3
- yq 4.14.2
- zstd 1.5.0 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.99
- AWS CLI 2.4.0
- AWS CLI Session manager plugin 1.2.279.0
- AWS SAM CLI 1.35.0
- Azure CLI (azure-cli) 2.30.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.22.0
- GitHub CLI 2.2.0
- Google Cloud SDK 365.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 7.0.2
- OpenShift CLI 4.9.7
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
| Tool     | Version       |
| -------- | ------------- |
| PHP      | 7.4.26 8.0.13 |
| Composer | 2.1.12        |
| PHPUnit  | 8.5.21        |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.1
- GHCup 0.1.17.4
- Stack 2.7.3

### Rust Tools
- Cargo 1.56.0
- Rust 1.56.1
- Rustdoc 1.56.1
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.1
- Cargo audit 0.16.0
- Cargo clippy 0.1.56
- Cargo outdated 0.10.2
- Cbindgen 0.20.0
- Rustfmt 1.4.37

### Browsers and Drivers
- Google Chrome 96.0.4664.45
- ChromeDriver 96.0.4664.45
- Mozilla Firefox 94.0
- Geckodriver 0.30.0
- Chromium 96.0.4664.0
- Selenium server 4.0.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 2.1.302 2.1.403 2.1.526 2.1.617 2.1.701 2.1.818 3.1.120 3.1.202 3.1.302 3.1.415 5.0.104 5.0.209 5.0.303 5.0.403

### Databases
- MongoDB 5.0.4 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- PostgreSQL 14.1 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- sqlite3 3.31.1

#### MySQL
- MySQL 8.0.27
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
- 1.16.10
- 1.17.3

#### Node.js
- 12.22.7
- 14.18.1
- 16.13.0

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
- 3.10.0

#### Ruby
- 2.5.9
- 2.6.8
- 2.7.4
- 3.0.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.15/x64 | x64          |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.10/x64 | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.3/x64  | x64          |

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
| Package Name               | Version                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                |
| Android Emulator           | 30.9.5                                                                                                                             |
| Android SDK Build-tools    | 31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 31.0.3                                                                                                                             |
| Android SDK Platforms      | android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)                         |
| Android SDK Tools          | 26.1.1                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                             |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                   |
| Google Play services       | 49                                                                                                                                 |
| Google Repository          | 58                                                                                                                                 |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.1.7779620                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                  |

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
| buildpack-deps:bullseye | sha256:b83c9c8628517694fc9adea2dc25f70113f511606482c79e1a7689ba4893f7c4  | 2021-11-17 |
| buildpack-deps:buster   | sha256:184194bf02563c474132a6982ed5878ef32b19b9f2a10029422ab304ca88ade1  | 2021-11-17 |
| buildpack-deps:stretch  | sha256:36fba449401e28a20c9fc9ebae94b4071c0a69bab5aade3340539ac9c857375a  | 2021-11-17 |
| debian:10               | sha256:e5333f8697a86fa1be53b2a7e994247083f61885166df0cdda9f812acb514d7c  | 2021-11-17 |
| debian:11               | sha256:e8c184b56a94db0947a9d51ec68f42ef5584442f20547fa3bd8cbd00203b2e7a  | 2021-11-17 |
| debian:9                | sha256:d8ee86bf0afeb901de293c692a540307a670306cbdb7a06e2c840f17b0c35374  | 2021-11-17 |
| moby/buildkit:latest    | sha256:d6c89b7085b106301645ddcc77cf64eb7b705ab507b72d52d130ac33f1300417  | 2021-11-18 |
| node:12                 | sha256:cb615135757e6e2eed4fad6d80f07b13d9f35072700c01da6de26fde5c9e8632  | 2021-11-17 |
| node:12-alpine          | sha256:0eca266c5fe38ba93aebac00e45c9ac1bb7328b0702a6dc10e1a6ea543d49301  | 2021-11-13 |
| node:14                 | sha256:fbd6954d3941ebd1e12cd995dc10a4994535aa44d47271a91a829a2d1f88fc4c  | 2021-11-17 |
| node:14-alpine          | sha256:240e1e6ef6dfba3bb70d6e88cca6cbb0b5a6f3a2b4496ed7edc5474e8ed594bd  | 2021-11-13 |
| node:16                 | sha256:580a0850049c59a48f06090edd48c9f966c5e6572bbbabc369ba3ecbc4855dba  | 2021-11-17 |
| node:16-alpine          | sha256:60ef0bed1dc2ec835cfe3c4226d074fdfaba571fd619c280474cc04e93f0ec5b  | 2021-11-13 |
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
| libgbm-dev             | 21.0.3-0ubuntu0.3\~20.04.4        |
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
| wget                   | 1.20.3-1ubuntu1                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.11-1ubuntu1\~20.04.2       |
| xz-utils               | 5.2.4-1ubuntu1                    |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |


