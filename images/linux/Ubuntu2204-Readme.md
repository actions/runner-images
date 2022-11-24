| Announcements |
|-|
| [[all OSs] Nodejs 12.x will be removed from the images on November, 14](https://github.com/actions/runner-images/issues/6482) |
| [Ubuntu-latest workflows will use Ubuntu-22.04](https://github.com/actions/runner-images/issues/6399) |
| [[all OSs] The VCPKG_ROOT variable will be removed from runner images](https://github.com/actions/runner-images/issues/6376) |
| [Third party PHP repository will be removed from the Ubuntu 22.04 image](https://github.com/actions/runner-images/issues/6331) |
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 2022/08/08 and will be fully unsupported by 2023/04/01](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 22.04.1 LTS
- Linux kernel version: 5.15.0-1023-azure
- Image Version: 20221119.2

## Installed Software
### Language and Runtime
- Bash 5.1.16(1)-release
- Clang 12.0.1, 13.0.1, 14.0.0
- Clang-format 12.0.1, 13.0.1, 14.0.0
- Clang-tidy 12.0.1, 13.0.1, 14.0.0
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++ 9.5.0, 10.4.0, 11.3.0, 12.1.0
- GNU Fortran 9.5.0, 10.4.0, 11.3.0
- Julia 1.8.3
- Kotlin 1.7.21-release-272
- Mono 6.12.0.182 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.10.1.31701 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.18.1
- Perl 5.34.0
- Python 3.10.6
- Python3 3.10.6
- Ruby 3.0.2p107
- Swift 5.7.1

### Package Management
- cpan 1.64
- Helm 3.10.2
- Homebrew 3.6.11
- Miniconda 4.12.0
- Npm 8.19.2
- NuGet 6.3.1.1
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.1.0
- RubyGems 3.3.5
- Vcpkg  (build from master \<4cb4a5c5d>)
- Yarn 1.22.19

##### Notes:
```
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
```

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Lerna 6.0.3

### Tools
- Ansible 2.13.6
- apt-fast 1.9.12
- AzCopy 10.16.2 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.3.2
- Bazelisk 1.13.2
- Bicep 0.12.40
- Buildah 1.23.1
- CMake 3.25.0
- CodeQL Action Bundle 2.11.3
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.12.2+azure-1
- Docker-Buildx 0.9.1
- Docker-Moby Client 20.10.21+azure-1
- Docker-Moby Server 20.10.21+azure-1
- Fastlane 2.211.0
- Git 2.38.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.2.0 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 7.66.4
- jq 1.6
- Kind 0.17.0
- Kubectl 1.25.4
- Kustomize 4.5.7
- Leiningen 2.9.10
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.28.0
- n 9.0.1
- Newman 5.3.2
- nvm 0.39.2
- OpenSSL 3.0.2-0ubuntu1.7
- Packer 1.8.4
- Parcel 2.8.0
- Podman 3.4.4
- Pulumi 3.47.1
- R 4.2.2
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.3.5
- yamllint 1.28.0
- yq v4.30.4
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.135
- AWS CLI 2.9.0
- AWS CLI Session manager plugin 1.2.398.0
- AWS SAM CLI 1.65.0
- Azure CLI (azure-cli) 2.42.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.20.2
- Google Cloud SDK 410.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 12.2.4
- OpenShift CLI 4.11.13
- ORAS CLI 0.16.0
- Vercel CLI 28.5.5

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.352+8           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.17+8 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.5+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.3.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version |
| -------- | ------- |
| PHP      | 8.1.2   |
| Composer | 2.4.4   |
| PHPUnit  | 8.5.31  |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.4.3
- GHCup 0.1.18.0
- Stack 2.9.1

### Rust Tools
- Cargo 1.65.0
- Rust 1.65.0
- Rustdoc 1.65.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.62.0
- Cargo audit 0.17.4
- Cargo clippy 0.1.65
- Cargo outdated 0.11.1
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 107.0.5304.110
- ChromeDriver 107.0.5304.62
- Chromium 107.0.5288.0
- Microsoft Edge 107.0.1418.52 (apt source repository: https://packages.microsoft.com/repos/edge)
- Microsoft Edge WebDriver 107.0.1418.52
- Selenium server 4.6.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    |                                     |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 6.0.403 7.0.100

### .NET tools
- nbgv 3.5.119+5d25f54fec

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.6 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 8.0.31-0ubuntu0.22.04.1
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.10.0001.1
- SqlPackage 16.1.6374.0

### Cached Tools
#### Go
- 1.17.13
- 1.18.8
- 1.19.3

#### Node.js
- 14.21.1
- 16.18.1
- 18.12.1

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 3.7.15
- 3.8.14
- 3.9.15
- 3.10.8
- 3.11.0

#### Ruby
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.13/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.8/x64  | x64          |
| GOROOT_1_19_X64 | /opt/hostedtoolcache/go/1.19.3/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.7

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Microsoft.Graph  | 1.17.0  |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.21.0  |

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
| Android Command Line Tools | 8.0                                                                                                                                                    |
| Android Emulator           | 31.3.13                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 33.0.3                                                                                                                                                 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.1.8937393 (default)                                                                                                 |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                       |
| ----------------------- | ------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                  |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                  |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.14             | sha256:4c869a63e1b7c0722fed1e402a6466610327c3b83bdddb94bd94fb71da7f638a  | 2022-08-09 |
| alpine:3.15             | sha256:cf34c62ee8eb3fe8aa24c1fab45d7e9d12768d945c3f5a6fd6a63d901e898479  | 2022-08-09 |
| alpine:3.16             | sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b  | 2022-11-12 |
| buildpack-deps:bullseye | sha256:1a263e69ebf256b5f27165d2eb4e667dadad37f42003d53f5ce699b7e7f1b6dc  | 2022-11-15 |
| buildpack-deps:buster   | sha256:c0804e4d81620d4fdb4965cc462dbca7d901d68968780ff6c6aeed062309ad50  | 2022-11-15 |
| debian:10               | sha256:6c153b6c1b042fb70140a465e6d7c9c4a6112062afdc843c6a4d9c5bbfe5d0d5  | 2022-11-15 |
| debian:11               | sha256:3066ef83131c678999ce82e8473e8d017345a30f5573ad3e44f62e5c9c46442b  | 2022-11-15 |
| moby/buildkit:latest    | sha256:77abd86c9422aaff294bfde1029f03a6ab18ece0105003637cfda1d7fc22299f  | 2022-11-10 |
| node:14                 | sha256:d82d512aec5de4fac53b92b2aa148948c2e72264d650de9e1570283d4f503dbe  | 2022-11-15 |
| node:14-alpine          | sha256:12b14bdfa8c89a1a060c53b5714157085700660b12ab7c50a907a4e19d95b6bf  | 2022-11-12 |
| node:16                 | sha256:68fc9f749931453d5c8545521b021dd97267e0692471ce15bdec0814ed1f8fc3  | 2022-11-15 |
| node:16-alpine          | sha256:15dd66f723aab8b367abc7ac6ed25594ca4653f2ce49ad1505bfbe740ad5190e  | 2022-11-12 |
| node:18                 | sha256:c47a2c61e635eb4938fcd56a1139b552300624b53e3eca06b5554a577f1842cf  | 2022-11-15 |
| node:18-alpine          | sha256:9eff44230b2fdcca57a73b8f908c8029e72d24dd05cac5339c79d3dedf6b208b  | 2022-11-12 |
| ubuntu:18.04            | sha256:ca70a834041dd1bf16cc38dfcd24f0888ec4fa431e09f3344f354cf8d1724499  | 2022-10-25 |
| ubuntu:20.04            | sha256:450e066588f42ebe1551f3b1a535034b6aa46cd936fe7f2c6b0d72997ec61dbd  | 2022-10-25 |
| ubuntu:22.04            | sha256:4b1d0c4a2d2aaf63b37111f34eb9fa89fa1bf53dd6e4ca954d47caebca4005c2  | 2022-11-02 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.3.1-1                           |
| aria2                  | 1.36.0-1                          |
| autoconf               | 2.71-2                            |
| automake               | 1:1.16.5-1.3                      |
| binutils               | 2.38-4ubuntu2                     |
| bison                  | 2:3.8.2+dfsg-1build1              |
| brotli                 | 1.0.9-2build6                     |
| build-essential        | 12.9ubuntu3                       |
| bzip2                  | 1.0.8-5build1                     |
| coreutils              | 8.32-4.1ubuntu1                   |
| curl                   | 7.81.0-1ubuntu1.6                 |
| dbus                   | 1.12.20-2ubuntu4.1                |
| dnsutils               | 1:9.18.1-1ubuntu1.2               |
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
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2          |
| libc++-dev             | 1:14.0-55\~exp2                   |
| libc++abi-dev          | 1:14.0-55\~exp2                   |
| libcurl4               | 7.81.0-1ubuntu1.6                 |
| libgbm-dev             | 22.0.5-0ubuntu0.1                 |
| libgconf-2-4           | 3.2.6-7ubuntu2                    |
| libgsl-dev             | 2.7.1+dfsg-3                      |
| libgtk-3-0             | 3.24.33-1ubuntu2                  |
| libmagic-dev           | 1:5.41-3                          |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libsecret-1-dev        | 0.20.5-2                          |
| libsqlite3-dev         | 3.37.2-2ubuntu0.1                 |
| libssl-dev             | 3.0.2-0ubuntu1.7                  |
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
| sqlite3                | 3.37.2-2ubuntu0.1                 |
| ssh                    | 1:8.9p1-3                         |
| sshpass                | 1.09-1                            |
| subversion             | 1.14.1-3ubuntu0.22.04.1           |
| sudo                   | 1.9.9-1ubuntu2.1                  |
| swig                   | 4.0.2-1ubuntu1                    |
| tar                    | 1.34+dfsg-1build3                 |
| telnet                 | 0.17-44build1                     |
| texinfo                | 6.8-4build1                       |
| time                   | 1.9-0.1build2                     |
| tk                     | 8.6.11+1build2                    |
| tzdata                 | 2022f-0ubuntu0.22.04.1            |
| unzip                  | 6.0-26ubuntu3.1                   |
| upx                    | 3.96-3                            |
| wget                   | 1.21.2-2ubuntu1                   |
| xorriso                | 1.5.4-2                           |
| xvfb                   | 2:21.1.3-2ubuntu2.2               |
| xz-utils               | 5.2.5-2ubuntu1                    |
| zip                    | 3.0-12build2                      |
| zsync                  | 0.6.2-3ubuntu1                    |


