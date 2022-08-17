| Announcements |
|-|
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 8/8/22 and will be fully unsupported by 12/1/22](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 22.04.1 LTS
- Linux kernel version: 5.15.0-1017-azure
- Image Version: 20220815.3

## Installed Software
### Language and Runtime
- Bash 5.1.16(1)-release
- Clang 12.0.1, 13.0.1, 14.0.0
- Clang-format 12.0.1, 13.0.1, 14.0.0
- Clang-tidy 12.0.1, 13.0.1, 14.0.0
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++ 9.4.0, 10.3.0, 11.2.0
- GNU Fortran 9.4.0, 10.3.0, 11.2.0
- Julia 1.7.3
- Kotlin 1.7.10-release-333
- Mono 6.12.0.182 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.10.1.31701 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.17.0
- Perl 5.34.0
- Python 3.10.4
- Python3 3.10.4
- Ruby 3.0.2p107

### Package Management
- cpan 1.64
- Helm 3.9.3
- Homebrew 3.5.9
- Miniconda 4.12.0
- Npm 8.15.0
- NuGet 6.2.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.1.0
- RubyGems 3.3.5
- Vcpkg  (build from master \<acc3bcf76>)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Lerna 5.4.2

### Tools
- Ansible 2.13.3
- apt-fast 1.9.12
- AzCopy 10.16.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.2.0
- Bazelisk 1.12.0
- Bicep 0.9.1
- Buildah 1.23.1
- CMake 3.24.0
- CodeQL Action Bundle 2.10.2
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.9.0+azure-1
- Docker-Buildx 0.8.2
- Docker-Moby Client 20.10.17+azure-1
- Docker-Moby Server 20.10.17+azure-1
- Fastlane 2.209.0
- Git 2.37.2 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.2.0 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 7.62.0
- jq 1.6
- Kind 0.14.0
- Kubectl 1.24.3
- Kustomize 4.5.7
- Leiningen 2.9.10
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.26.1
- n 9.0.0
- Newman 5.3.2
- nvm 0.39.1
- OpenSSL 3.0.2-0ubuntu1.6
- Packer 1.8.3
- Parcel 2.7.0
- Podman 3.4.4
- Pulumi 3.37.2
- R 4.2.1
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.2.7
- yamllint 1.27.1
- yq 4.27.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.124
- AWS CLI 2.7.23
- AWS CLI Session manager plugin 1.2.339.0
- AWS SAM CLI 1.54.0
- Azure CLI (azure-cli) 2.39.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.14.4
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 10.17.7
- OpenShift CLI 4.11.0
- ORAS CLI 0.13.0
- Vercel CLI 28.0.2

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.345+1           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.16+8 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.4+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.2.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version |
| -------- | ------- |
| PHP      | 8.1.9   |
| Composer | 2.3.10  |
| PHPUnit  | 8.5.28  |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.4.1
- GHCup 0.1.18.0
- Stack 2.7.5

### Rust Tools
- Cargo 1.63.0
- Rust 1.63.0
- Rustdoc 1.63.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.60.1
- Cargo audit 0.17.0
- Cargo clippy 0.1.63
- Cargo outdated 0.11.1
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 104.0.5112.79
- ChromeDriver 104.0.5112.79
- Chromium 104.0.5112.0
- Microsoft Edge 104.0.1293.54 (apt source repository: https://packages.microsoft.com/repos/edge)
- Microsoft Edge WebDriver 104.0.1293.54
- Selenium server 4.4.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    |                                     |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 6.0.400

### .NET tools
- nbgv 3.5.109+bdfbd7dea6

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.5 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 8.0.30-0ubuntu0.22.04.1
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
### Cached Tools
#### Go
- 1.17.13
- 1.18.5
- 1.19.0

#### Node.js
- 14.20.0
- 16.16.0

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 3.7.13
- 3.8.13
- 3.9.13
- 3.10.6

#### Ruby
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.13/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.5/x64  | x64          |
| GOROOT_1_19_X64 | /opt/hostedtoolcache/go/1.19.0/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.6

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Microsoft.Graph  | 1.11.0  |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.20.0  |

#### Az PowerShell Modules
- 7.5.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.3.10                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.0.8775105 (default)                                                                                                 |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                       |
| ----------------------- | ------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                  |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.0.8775105 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.0.8775105 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/25.0.8775105 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.0.8775105 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                  |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.14             | sha256:1ab24b3b99320975cca71716a7475a65d263d0b6b604d9d14ce08f7a3f67595c  | 2022-08-09 |
| alpine:3.15             | sha256:69463fdff1f025c908939e86d4714b4d5518776954ca627cbeff4c74bcea5b22  | 2022-08-09 |
| buildpack-deps:bullseye | sha256:d6974da710854c9c38d49666bd682abd99ef7aacdb92344d42a00f723e63cdb1  | 2022-08-02 |
| buildpack-deps:buster   | sha256:9d806f4d80f19e3fd315bbe2ca1aa59a6c1ad18aff7b3d9696b407572608d61e  | 2022-08-02 |
| debian:10               | sha256:fb9654aac57319592f1d51497c62001e7033eddf059355408a0b53f7c71f8d5f  | 2022-08-02 |
| debian:11               | sha256:82bab30ed448b8e2509aabe21f40f0607d905b7fd0dec72802627a20274eba55  | 2022-08-02 |
| moby/buildkit:latest    | sha256:0dc312b04eac1b44cd2cad566deb1e886c753109208affbbec8384f381ff7f38  | 2022-05-06 |
| node:14                 | sha256:7e1eabbcd7cbd0fdc296bc00fb2c80943ed0499c4ca3a148c83944708574dcf6  | 2022-08-02 |
| node:14-alpine          | sha256:4aff4ba0da347e51561587eba037a38db4eaa70e1a6c8334d66779fe963d5be7  | 2022-08-09 |
| node:16                 | sha256:1ed1e17ccabb09038cfb8a965337ebcda51ef9e9d32082164c502d44d9731a02  | 2022-08-02 |
| node:16-alpine          | sha256:1c8769a8c9ed57817ef07162744a3722421333a438185c560aa42a9a1fc6ea23  | 2022-08-09 |
| ubuntu:18.04            | sha256:eb1392bbdde63147bc2b4ff1a4053dcfe6d15e4dfd3cce29e9b9f52a4f88bc74  | 2022-08-02 |
| ubuntu:20.04            | sha256:af5efa9c28de78b754777af9b4d850112cad01899a5d37d2617bb94dc63a49aa  | 2022-08-02 |
| ubuntu:22.04            | sha256:34fea4f31bf187bc915536831fd0afc9d214755bf700b5cdb1336c82516d154e  | 2022-08-02 |

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
| curl                   | 7.81.0-1ubuntu1.3                 |
| dbus                   | 1.12.20-2ubuntu4                  |
| dnsutils               | 1:9.18.1-1ubuntu1.1               |
| dpkg                   | 1.21.1ubuntu2.1                   |
| fakeroot               | 1.28-1ubuntu1                     |
| file                   | 1:5.41-3                          |
| flex                   | 2.6.4-8build2                     |
| fonts-noto-color-emoji | 2.034-1                           |
| ftp                    | 20210827-4build1                  |
| gnupg2                 | 2.2.27-3ubuntu2.1                 |
| haveged                | 1.9.14-1ubuntu1                   |
| imagemagick            | 8:6.9.11.60+dfsg-1.3build2        |
| iproute2               | 5.15.0-1ubuntu2                   |
| iputils-ping           | 3:20211215-1                      |
| jq                     | 1.6-2.1ubuntu3                    |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9            |
| libc++-dev             | 1:14.0-55\~exp2                   |
| libc++abi-dev          | 1:14.0-55\~exp2                   |
| libcurl4               | 7.81.0-1ubuntu1.3                 |
| libgbm-dev             | 22.0.5-0ubuntu0.1                 |
| libgconf-2-4           | 3.2.6-7ubuntu2                    |
| libgsl-dev             | 2.7.1+dfsg-3                      |
| libgtk-3-0             | 3.24.33-1ubuntu2                  |
| libmagic-dev           | 1:5.41-3                          |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libsecret-1-dev        | 0.20.5-2                          |
| libsqlite3-dev         | 3.37.2-2                          |
| libssl-dev             | 3.0.2-0ubuntu1.6                  |
| libtool                | 2.4.6-15build2                    |
| libunwind8             | 1.3.2-2build2                     |
| libxkbfile-dev         | 1:1.1.0-1build3                   |
| libxss1                | 1:1.2.3-1build2                   |
| locales                | 2.35-0ubuntu3.1                   |
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
| xvfb                   | 2:21.1.3-2ubuntu2.1               |
| xz-utils               | 5.2.5-2ubuntu1                    |
| zip                    | 3.0-12build2                      |
| zsync                  | 0.6.2-3ubuntu1                    |


