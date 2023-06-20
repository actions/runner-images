| Announcements |
|-|
| [[All OSs] .NET 3.1 will be removed from the images on July, 3](https://github.com/actions/runner-images/issues/7667) |
| [Actions runner image scheduled maintenance (June 2 2023 through June 16 2023)](https://github.com/actions/runner-images/issues/7660) |
***
# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1040-azure
- Image Version: 20230619.1.0
- Systemd version: 245.4-4ubuntu3.22

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.3 (Eshell 13.2)
- Erlang rebar3 3.22.0
- GNU C++: 9.4.0, 10.3.0
- GNU Fortran: 9.4.0, 10.3.0
- Julia 1.9.1
- Kotlin 1.8.22-release-407
- Mono 6.12.0.182
- MSBuild 16.10.1.31701 (Mono 6.12.0.182)
- Node.js 18.16.0
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.8.1

### Package Management
- cpan 1.64
- Helm 3.12.1
- Homebrew 4.0.24
- Miniconda 23.3.1
- Npm 9.5.1
- NuGet 6.3.1.1
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.2.0
- RubyGems 3.1.2
- Vcpkg (build from commit 223b8d569)
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
- Ant 1.10.7
- Gradle 8.1.1
- Lerna 7.0.2
- Maven 3.8.8
- Sbt 1.9.0

### Tools
- Ansible 2.13.10
- apt-fast 1.9.12
- AzCopy 10.19.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.2.1
- Bazelisk 1.13.2
- Bicep 0.18.4
- Buildah 1.22.3
- CMake 3.26.4
- CodeQL Action Bundles 2.13.1 2.13.3
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.18.1+azure-2
- Docker-Buildx 0.11.0
- Docker-Moby Client 20.10.25+azure-2
- Docker-Moby Server 20.10.25+azure-2
- Fastlane 2.213.0
- Git 2.41.0
- Git LFS 3.3.0
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 8.1.8
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.20.0
- Kubectl 1.27.3
- Kustomize 5.1.0
- Leiningen 2.10.0
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.30.1
- n 9.1.0
- Newman 5.3.2
- nvm 0.39.3
- OpenSSL 1.1.1f-1ubuntu2.19
- Packer 1.9.1
- Parcel 2.9.2
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.72.2
- R 4.3.0
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.5.0
- yamllint 1.32.0
- yq 4.34.1
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.167
- AWS CLI 2.12.1
- AWS CLI Session Manager Plugin 1.2.463.0
- AWS SAM CLI 1.86.1
- Azure CLI 2.49.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.30.0
- Google Cloud SDK 435.0.1
- Hub CLI 2.14.2
- Netlify CLI 15.6.0
- OpenShift CLI 4.13.3
- ORAS CLI 1.0.0
- Vercel CLI 30.2.2

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.372+7           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.19+7 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.7+7            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP Tools
- PHP: 7.4.33, 8.0.29, 8.1.20, 8.2.7
- Composer 2.5.8
- PHPUnit 8.5.33
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.1.0
- GHC 9.6.2
- GHCup 0.1.19.2
- Stack 2.11.1

### Rust Tools
- Cargo 1.70.0
- Rust 1.70.0
- Rustdoc 1.70.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.66.1
- Cargo audit 0.17.6
- Cargo clippy 0.1.70
- Cargo outdated 0.13.0
- Cbindgen 0.24.5
- Rustfmt 1.5.2

### Browsers and Drivers
- Google Chrome 114.0.5735.133
- ChromeDriver 114.0.5735.90
- Chromium 114.0.5733.0
- Microsoft Edge 114.0.1823.55
- Microsoft Edge WebDriver 114.0.1823.51
- Selenium server 4.10.0
- Mozilla Firefox 114.0.1
- Geckodriver 0.33.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Tools
- .NET Core SDK: 3.1.120, 3.1.202, 3.1.302, 3.1.426, 6.0.410, 7.0.107, 7.0.203, 7.0.304
- nbgv 3.6.133+2d32d93cb1

### Databases
- MongoDB 5.0.18
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.8
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.33-0ubuntu0.20.04.2
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.0.52.1

### Cached Tools

#### Go
- 1.18.10
- 1.19.10
- 1.20.5

#### Node.js
- 14.21.3
- 16.20.0
- 18.16.0

#### Python
- 3.6.15
- 3.7.17
- 3.8.17
- 3.9.17
- 3.10.12
- 3.11.4

#### PyPy
- 2.7.18 [PyPy 7.3.12]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.17 [PyPy 7.3.12]

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.8
- 3.0.6
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.11

#### PowerShell Modules
- Az: 9.3.0
- Az (Cached): 3.1.0.zip, 4.4.0.zip, 5.9.0.zip, 6.6.0.zip, 7.5.0.zip
- MarkdownPS: 1.9
- Microsoft.Graph: 1.28.0
- Pester: 5.4.1
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                |
| Android Emulator           | 32.1.13                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                     |
| Android SDK Platform-Tools | 34.0.3                                                                                                                                                                                                                             |
| Android SDK Platforms      | android-34 (rev 1)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                             |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                         |
| Google Play services       | 49                                                                                                                                                                                                                                 |
| Google Repository          | 58                                                                                                                                                                                                                                 |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)                                                                                                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                  |

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
| alpine:3.15             | sha256:3362f865019db5f14ac5154cb0db2c3741ad1cce0416045be422ad4de441b081  | 2023-06-14 |
| alpine:3.16             | sha256:cbe5d5973103a2d03408d1689a6efde4ea4920bde9f4b51fe7872e60ce2d8e56  | 2023-06-14 |
| alpine:3.17             | sha256:e95676db9e4a4f16f6cc01a8915368f82b018cc07aba951c1bd1db586c081388  | 2023-06-14 |
| buildpack-deps:bullseye | sha256:2987a7a81a0eb17086c6498afedb19002689587038fdef7f5880c2cca973bf13  | 2023-06-13 |
| buildpack-deps:buster   | sha256:0da9fe74d5f9bac9754a912b61cf81c62af1247ff3eed0b4f6df00da924f7f21  | 2023-06-13 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:28842e4895d36e67c49015c0b41089fa3248e865c76994b19f706ab91e800b95  | 2023-06-12 |
| debian:11               | sha256:1e5f2d70c9441c971607727f56d0776fb9eecf23cd37b595b26db7a974b2301d  | 2023-06-12 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:d6fa89830c26919acba23c5cafa09df0c3ec1fbde20bb2a15ff349e0795241f4  | 2023-04-20 |
| node:14                 | sha256:a158d3b9b4e3fa813fa6c8c590b8f0a860e015ad4e59bbce5744d2f6fd8461aa  | 2023-04-12 |
| node:14-alpine          | sha256:434215b487a329c9e867202ff89e704d3a75e554822e07f3e0c0f9e606121b33  | 2023-03-29 |
| node:16                 | sha256:07ac708c46cc7136db9d54749c541ba1dc516dc316e126a94136083b842c2db9  | 2023-06-13 |
| node:16-alpine          | sha256:296f32946d2fb5227e43fa51e608bbb11a208d648a833e9b264934fb0c7f404b  | 2023-06-15 |
| node:18                 | sha256:4a55308cc855cba1a925d19ae4e45838741dad2fd7bb8949a93b2a0f2ae339e3  | 2023-06-13 |
| node:18-alpine          | sha256:9036ddb8252ba7089c2c83eb2b0dcaf74ff1069e8ddf86fe2bd6dc5fecc9492d  | 2023-06-15 |
| ubuntu:16.04            | sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6  | 2021-08-31 |
| ubuntu:18.04            | sha256:152dc042452c496007f07ca9127571cb9c29697f42acbfad72324b2bb2e43c98  | 2023-05-30 |
| ubuntu:20.04            | sha256:f8f658407c35733471596f25fdb4ed748b80e545ab57e84efbdb1dbbb01bd70e  | 2023-06-05 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.6                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| coreutils              | 8.30-3ubuntu2                     |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.16.1-0ubuntu2.14              |
| dpkg                   | 1.19.7ubuntu3.2                   |
| dpkg-dev               | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.7    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libc6-dev              | 2.31-0ubuntu9.9                   |
| libcurl4               | 7.68.0-1ubuntu2.18                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.7    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.7    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.5                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.9                   |
| m4                     | 1.4.18-4                          |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.7                |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8ubuntu0.5                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.5                 |
| ssh                    | 1:8.2p1-4ubuntu0.7                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.5                 |
| swig                   | 4.0.1-5build1                     |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2023c-0ubuntu0.20.04.2            |
| upx                    | 3.95-2build1                      |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.8       |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

