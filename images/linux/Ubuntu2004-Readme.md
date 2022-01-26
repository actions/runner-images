| Announcements |
|-|
| [[All OSs] .NET 2.1 will be removed from the images on February, 21](https://github.com/actions/virtual-environments/issues/4871) |
| [[All OSs] Az PowerShell Module will be upgraded to 7.1.0 on January, 17](https://github.com/actions/virtual-environments/issues/4841) |
| [[Ubuntu] Issue with libstdc++ cannot allocate memory in static TLS block](https://github.com/actions/virtual-environments/issues/4799) |
| [[All OSs] Python version 3.5 will be removed from the images on January 24, 2022](https://github.com/actions/virtual-environments/issues/4744) |
***
# Ubuntu 20.04.3 LTS
- Linux kernel version: 5.11.0-1027-azure
- Image Version: 20220119.1

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.0
- Clang-format 10.0.0, 11.0.0, 12.0.0
- Erlang 24.2 (Eshell 12.2)
- Erlang rebar3 3.18.0
- GNU C++ 9.3.0, 10.3.0
- GNU Fortran 9.3.0, 10.3.0
- Julia 1.7.1
- Kotlin 1.6.0-release-798
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.13.2
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.5.2

### Package Management
- cpan 1.64
- Helm 3.7.2
- Homebrew 3.3.11
- Miniconda 4.10.3
- Npm 8.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.0.0
- RubyGems 3.1.2
- Vcpkg  (build from master \<5ef52b5b7>)
- Yarn 1.22.17

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 7.3.3
- Lerna 4.0.0
- Maven 3.8.4
- Sbt 1.6.1

### Tools
- Ansible 2.12.1
- apt-fast 1.9.12
- AzCopy 10.13.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.0.0
- Bazelisk 1.11.0
- Bicep 0.4.1124
- Buildah 1.21.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.22.1
- CodeQL Action Bundle 2.7.5
- Docker Compose v1 1.29.2
- Docker Compose v2 2.2.3+azure-1
- Docker-Buildx 0.7.1
- Docker-Moby Client 20.10.11+azure-3
- Docker-Moby Server 20.10.11+azure-3
- Fastlane 2.200.0
- Git 2.34.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.0.2 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.59.2
- HHVM (HipHop VM) 4.144.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.23.2
- Kustomize 4.4.1
- Leiningen 2.9.8
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.24.0
- n 8.0.2
- Newman 5.3.1
- nvm 0.39.1
- OpenSSL 1.1.1f  31 Mar 2020
- Packer 1.7.9
- Parcel 2.2.1
- PhantomJS 2.1.1
- Podman 3.4.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.22.1
- R 4.1.2
- Skopeo 1.3.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.1.4
- yamllint 1.26.3
- [yq](https://github.com/mikefarah/yq) 4.16.2
- zstd 1.5.1 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.104
- AWS CLI 2.4.12
- AWS CLI Session manager plugin 1.2.295.0
- AWS SAM CLI 1.37.0
- Azure CLI (azure-cli) 2.32.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.22.0
- GitHub CLI 2.4.0
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 8.10.2
- OpenShift CLI 4.9.15
- ORAS CLI 0.12.0
- Vercel CLI 23.1.2

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.312+7           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.13+8 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.1+12           | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 21.3.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version             |
| -------- | ------------------- |
| PHP      | 7.4.27 8.0.14 8.1.1 |
| Composer | 2.2.4               |
| PHPUnit  | 8.5.22              |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.1
- GHCup 0.1.17.4
- Stack 2.7.3

### Rust Tools
- Cargo 1.58.0
- Rust 1.58.0
- Rustdoc 1.58.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo audit 0.16.0
- Cargo clippy 0.1.58
- Cargo outdated 0.10.2
- Cbindgen 0.20.0
- Rustfmt 1.4.38

### Browsers and Drivers
- Google Chrome 97.0.4692.71
- ChromeDriver 97.0.4692.71
- Mozilla Firefox 96.0
- Geckodriver 0.30.0
- Chromium 97.0.4692.0
- Selenium server 4.1.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 2.1.302 2.1.403 2.1.526 2.1.617 2.1.701 2.1.818 3.1.120 3.1.202 3.1.302 3.1.416 5.0.104 5.0.210 5.0.303 5.0.404

### .NET tools
- nbgv 3.4.255+06fb9182bf

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
- 1.16.13
- 1.17.6

#### Node.js
- 12.22.9
- 14.18.3
- 16.13.2

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
- 3.9.10
- 3.10.2

#### Ruby
- 2.5.9
- 2.6.9
- 2.7.5
- 3.0.3

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.15/x64 | x64          |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.13/x64 | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.6/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.1

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Pester           | 5.3.1   |
| PSScriptAnalyzer | 1.20.0  |

#### Az PowerShell Modules
- 7.1.0 3.1.0.zip 4.4.0.zip 5.9.0.zip 6.6.0.zip

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
| buildpack-deps:bullseye | sha256:8cca6f729d85d572000a436eac498ff5358eeee5a0fa7b3e2b6668620c6ac06e  | 2021-12-21 |
| buildpack-deps:buster   | sha256:24cf4668129a284b9b960ffaa5e79f9654d7d040708721c8e7708811e362a9d9  | 2021-12-21 |
| buildpack-deps:stretch  | sha256:19610095f7d1718c20d79e5109c42f64dabea9fdf104221394acdf2999170c51  | 2021-12-21 |
| debian:10               | sha256:94ccfd1c5115a6903cbb415f043a0b04e307be3f37b768cf6d6d3edff0021da3  | 2021-12-21 |
| debian:11               | sha256:2906804d2a64e8a13a434a1a127fe3f6a28bf7cf3696be4223b06276f32f1f2d  | 2021-12-21 |
| debian:9                | sha256:54284a7a45383b407c1968657e8f1c50dc25b82d8d56b3812e46ad19f8bcfd83  | 2021-12-21 |
| moby/buildkit:latest    | sha256:d6c89b7085b106301645ddcc77cf64eb7b705ab507b72d52d130ac33f1300417  | 2021-11-18 |
| node:12                 | sha256:04334b2efca8f5f23d246ce8818fe358c2c0116819e5fd043e7929cae6ca7398  | 2022-01-11 |
| node:12-alpine          | sha256:c3e7817c8fd124f1597cd66124d247db8e138e8ef311ba085b7104d900129d0b  | 2022-01-12 |
| node:14                 | sha256:50d4540794db9bdbd423a5823c4d840fc2ba0b9c82d71b059ff34b4aeb3e328f  | 2022-01-11 |
| node:14-alpine          | sha256:a9b200d25469261a4cccde176db08ec9f0b5799fa4220d8edfe57e69684c6dad  | 2022-01-11 |
| node:16                 | sha256:4b0b5c3db44f567d5d25c80a6fe33a981d911cdae20b39d2395be268aea2cb97  | 2022-01-11 |
| node:16-alpine          | sha256:2f50f4a428f8b5280817c9d4d896dbee03f072e93f4e0c70b90cc84bd1fcfe0d  | 2022-01-12 |
| ubuntu:16.04            | sha256:0f71fa8d4d2d4292c3c617fda2b36f6dabe5c8b6e34c3dc5b0d17d4e704bd39c  | 2021-08-31 |
| ubuntu:18.04            | sha256:37b7471c1945a2a12e5a57488ee4e3e216a8369d0b9ee1ec2e41db9c2c1e3d22  | 2022-01-07 |
| ubuntu:20.04            | sha256:b5a61709a9a44284d88fb12e5c48db0409cfad5b69d4ff8224077c57302df9cf  | 2022-01-07 |

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
| openssh-client         | 1:8.2p1-4ubuntu0.4                |
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
| ssh                    | 1:8.2p1-4ubuntu0.4                |
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
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.2       |
| xz-utils               | 5.2.4-1ubuntu1                    |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |


