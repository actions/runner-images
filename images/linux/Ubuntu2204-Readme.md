| Announcements |
|-|
| [python2.7 will be removed from the images on May 15, 2023](https://github.com/actions/runner-images/issues/7401) |
***
# Ubuntu 22.04
- OS Version: 22.04.2 LTS
- Kernel Version: 5.15.0-1037-azure
- Image Version: 20230507.1
- Systemd version: 249.11-0ubuntu3.9

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 12.0.1, 13.0.1, 14.0.0
- Clang-format: 12.0.1, 13.0.1, 14.0.0
- Clang-tidy: 12.0.1, 13.0.1, 14.0.0
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 9.5.0, 10.4.0, 11.3.0, 12.1.0
- GNU Fortran: 9.5.0, 10.4.0, 11.3.0, 12.1.0
- Julia 1.8.5
- Kotlin 1.8.21-release-380
- Mono 6.12.0.182
- MSBuild 16.10.1.31701 (Mono 6.12.0.182)
- Node.js 18.16.0
- Perl 5.34.0
- Python 3.10.6
- Python3 3.10.6
- Ruby 3.0.2p107
- Swift 5.8

### Package Management
- cpan 1.64
- Helm 3.11.3
- Homebrew 4.0.16
- Miniconda 23.3.1
- Npm 9.5.1
- NuGet 6.3.1.1
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.2.0
- RubyGems 3.3.5
- Vcpkg (build from commit 6a3dd0874)
- Yarn 1.22.19

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
- Lerna 6.6.2
- Maven 3.8.8

### Tools
- Ansible 2.14.5
- apt-fast 1.9.12
- AzCopy 10.18.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.1.2
- Bazelisk 1.13.2
- Bicep 0.17.1
- Buildah 1.23.1
- CMake 3.26.3
- CodeQL Action Bundles 2.13.0 2.13.1
- Docker Amazon ECR Credential Helper 0.7.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.17.3+azure-1
- Docker-Buildx 0.10.4
- Docker-Moby Client 20.10.24+azure-1
- Docker-Moby Server 20.10.24+azure-1
- Fastlane 2.212.2
- Git 2.40.1
- Git LFS 3.3.0
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 8.1.3
- jq 1.6
- Kind 0.18.0
- Kubectl 1.27.1
- Kustomize 5.0.2
- Leiningen 2.10.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.30.1
- n 9.1.0
- Newman 5.3.2
- nvm 0.39.3
- OpenSSL 3.0.2-0ubuntu1.9
- Packer 1.8.7
- Parcel 2.8.3
- Podman 3.4.4
- Pulumi 3.66.0
- R 4.3.0
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.4.6
- yamllint 1.31.0
- yq 4.33.3
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.163
- AWS CLI 2.11.18
- AWS CLI Session Manager Plugin 1.2.463.0
- AWS SAM CLI 1.82.0
- Azure CLI 2.48.1
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.28.0
- Google Cloud SDK 429.0.0
- Hub CLI 2.14.2
- Netlify CLI 15.0.0
- OpenShift CLI 4.12.15
- ORAS CLI 1.0.0
- Vercel CLI 29.1.1

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.362+9           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.19+7 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.7+7            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.5.5
- PHPUnit 8.5.33
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.1.0
- GHC 9.6.1
- GHCup 0.1.19.2
- Stack 2.9.3

### Rust Tools
- Cargo 1.69.0
- Rust 1.69.0
- Rustdoc 1.69.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.65.1
- Cargo audit 0.17.5
- Cargo clippy 0.1.69
- Cargo outdated 0.11.2
- Cbindgen 0.24.3
- Rustfmt 1.5.2

### Browsers and Drivers
- Google Chrome 113.0.5672.63
- ChromeDriver 113.0.5672.63
- Chromium 113.0.5672.0
- Microsoft Edge 113.0.1774.35
- Microsoft Edge WebDriver 113.0.1774.35
- Selenium server 4.9.0
- Mozilla Firefox 113.0
- Geckodriver 0.33.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Tools
- .NET Core SDK: 6.0.408, 7.0.105, 7.0.203
- nbgv 3.6.128+518ee610d6

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.7
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.32-0ubuntu0.22.04.2
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 16.1.8089.0

### Cached Tools

#### Go
- 1.18.10
- 1.19.9
- 1.20.4

#### Node.js
- 14.21.3
- 16.20.0
- 18.16.0

#### Python
- 3.7.16
- 3.8.16
- 3.9.16
- 3.10.11
- 3.11.3

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.16 [PyPy 7.3.11]

#### Ruby
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.11

#### PowerShell Modules
- Az: 9.3.0
- MarkdownPS: 1.9
- Microsoft.Graph: 1.27.0
- Pester: 5.4.1
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                      |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 9.0                                                                                                                                                                                                          |
| Android Emulator           | 32.1.12                                                                                                                                                                                                      |
| Android SDK Build-tools    | 33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                         |
| Android SDK Platform-Tools | 34.0.1                                                                                                                                                                                                       |
| Android SDK Platforms      | android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                                                                                       |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                   |
| Google Play services       | 49                                                                                                                                                                                                           |
| Google Repository          | 58                                                                                                                                                                                                           |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)                                                                                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                            |

#### Environment variables
| Name                    | Value                                       |
| ----------------------- | ------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                  |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.2.9519653 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                  |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.14             | sha256:0f2d5c38dd7a4f4f733e688e3a6733cb5ab1ac6e3cb4603a5dd564e5bfb80eed  | 2023-03-29 |
| alpine:3.15             | sha256:ecbdce53b2c2f43ab1b19418bcbd3f120a23547d9497030c8d978114512b883e  | 2023-03-29 |
| alpine:3.16             | sha256:c2b622f6e510a0d25bccaffa9e67b75a6860cb09b74bb58cfc36a9ef4331109f  | 2023-03-29 |
| alpine:3.17             | sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126  | 2023-03-29 |
| buildpack-deps:bullseye | sha256:373587e78550f0918d16b793d1ead24c3f489a14c3af85da1096e2a683908e0c  | 2023-05-03 |
| buildpack-deps:buster   | sha256:bfefe2afb02a82c76d955f2c158b3b5aa96e7afcf262727e8f37ccdea60a39c5  | 2023-05-03 |
| debian:10               | sha256:cca6bcced970f7634197ff1821aabb452024eb437958ab98bfc146ece96969c6  | 2023-05-02 |
| debian:11               | sha256:63d62ae233b588d6b426b7b072d79d1306bfd02a72bff1fc045b8511cc89ee09  | 2023-05-02 |
| moby/buildkit:latest    | sha256:d6fa89830c26919acba23c5cafa09df0c3ec1fbde20bb2a15ff349e0795241f4  | 2023-04-20 |
| node:14                 | sha256:a158d3b9b4e3fa813fa6c8c590b8f0a860e015ad4e59bbce5744d2f6fd8461aa  | 2023-04-12 |
| node:14-alpine          | sha256:434215b487a329c9e867202ff89e704d3a75e554822e07f3e0c0f9e606121b33  | 2023-03-29 |
| node:16                 | sha256:550f484fc5f314b575f5e397c9e2c71d7f218e59729fcda9ffa7ea1fc825dce7  | 2023-05-04 |
| node:16-alpine          | sha256:f1657204d3463bce763cefa5b25e48c28af6fe0cdb0f68b354f0f8225ef61be7  | 2023-03-29 |
| node:18                 | sha256:3f567a26b6b6d601fb2b168d4f987b50697617ead15bfc0e0152e600ac48d0fe  | 2023-05-04 |
| node:18-alpine          | sha256:1ccc70acda680aa4ba47f53e7c40b2d4d6892de74817128e0662d32647dd7f4d  | 2023-04-13 |
| ubuntu:18.04            | sha256:8aa9c2798215f99544d1ce7439ea9c3a6dfd82de607da1cec3a8a2fae005931b  | 2023-03-08 |
| ubuntu:20.04            | sha256:db8bf6f4fb351aa7a26e27ba2686cf35a6a409f65603e59d4c203e58387dc6b3  | 2023-04-13 |
| ubuntu:22.04            | sha256:dfd64a3b4296d8c9b62aa3309984f8620b98d87e47492599ee20739e8eb54fbf  | 2023-04-25 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.1                     |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| build-essential        | 12.9ubuntu3                         |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1                     |
| curl                   | 7.81.0-1ubuntu1.10                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.12-0ubuntu0.22.04.1          |
| dpkg                   | 1.21.1ubuntu2.1                     |
| fakeroot               | 1.28-1ubuntu1                       |
| file                   | 1:5.41-3                            |
| flex                   | 2.6.4-8build2                       |
| fonts-noto-color-emoji | 2.038-0ubuntu1                      |
| ftp                    | 20210827-4build1                    |
| gnupg2                 | 2.2.27-3ubuntu2.1                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1                        |
| jq                     | 1.6-2.1ubuntu3                      |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libcurl4               | 7.81.0-1ubuntu1.10                  |
| libgbm-dev             | 22.2.5-0ubuntu0.1\~22.04.1          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2                    |
| libmagic-dev           | 1:5.41-3                            |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.1                   |
| libssl-dev             | 3.0.2-0ubuntu1.9                    |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2                       |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.1                     |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5   |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.1                  |
| p7zip-full             | 16.02+dfsg-8                        |
| p7zip-rar              | 16.02-3build1                       |
| parallel               | 20210822+ds-2                       |
| pass                   | 1.7.4-5                             |
| patchelf               | 0.14.3-1                            |
| pkg-config             | 0.29.2-1ubuntu3                     |
| pollinate              | 4.33-3ubuntu2                       |
| python-is-python3      | 3.9.2-2                             |
| rpm                    | 4.17.0+dfsg1-4build1                |
| rsync                  | 3.2.7-0ubuntu0.22.04.2              |
| shellcheck             | 0.8.0-2                             |
| sphinxsearch           | 2.2.11-8                            |
| sqlite3                | 3.37.2-2ubuntu0.1                   |
| ssh                    | 1:8.9p1-3ubuntu0.1                  |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.4                    |
| swig                   | 4.0.2-1ubuntu1                      |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.1        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2023c-0ubuntu0.22.04.1              |
| unzip                  | 6.0-26ubuntu3.1                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1                     |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.1        |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

