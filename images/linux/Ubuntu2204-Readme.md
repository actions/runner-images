# Ubuntu 22.04
- OS Version: 22.04.2 LTS
- Kernel Version: 5.15.0-1042-azure
- Image Version: 20230728.3.0
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
- Julia 1.9.2
- Kotlin 1.9.0-release-358
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.17.0
- Perl 5.34.0
- Python 3.10.6
- Python3 3.10.6
- Ruby 3.0.2p107
- Swift 5.8.1

### Package Management
- cpan 1.64
- Helm 3.12.2
- Homebrew 4.1.2
- Miniconda 23.5.2
- Npm 9.6.7
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.2.0
- RubyGems 3.3.5
- Vcpkg (build from commit 8b04a7bd9)
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
- Lerna 7.1.4
- Maven 3.8.8

### Tools
- Ansible 2.15.2
- apt-fast 1.9.12
- AzCopy 10.20.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.3.0
- Bazelisk 1.13.2
- Bicep 0.19.5
- Buildah 1.23.1
- CMake 3.27.1
- CodeQL Action Bundles 2.14.0 2.14.1
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.20.2+azure-1
- Docker-Buildx 0.11.2
- Docker-Moby Client 23.0.6+azure-2
- Docker-Moby Server 23.0.6+azure-2
- Fastlane 2.214.0
- Git 2.41.0
- Git LFS 3.4.0
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 8.1.9
- jq 1.6
- Kind 0.20.0
- Kubectl 1.27.4
- Kustomize 5.1.0
- Leiningen 2.10.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.31.1
- n 9.1.0
- Newman 5.3.2
- nvm 0.39.4
- OpenSSL 3.0.2-0ubuntu1.10
- Packer 1.9.2
- Parcel 2.9.3
- Podman 3.4.4
- Pulumi 3.76.1
- R 4.3.1
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.5.4
- yamllint 1.32.0
- yq 4.34.2
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.170
- AWS CLI 2.13.5
- AWS CLI Session Manager Plugin 1.2.463.0
- AWS SAM CLI 1.94.0
- Azure CLI 2.50.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.32.1
- Google Cloud SDK 440.0.0
- Hub CLI 2.14.2
- Netlify CLI 15.9.1
- OpenShift CLI 4.13.6
- ORAS CLI 1.0.0
- Vercel CLI 31.1.1

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.372+7           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.19+7 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.7+7            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.5.8
- PHPUnit 8.5.33
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.1.0
- GHC 9.6.2
- GHCup 0.1.19.4
- Stack 2.11.1

### Rust Tools
- Cargo 1.71.0
- Rust 1.71.0
- Rustdoc 1.71.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.66.1
- Cargo audit 0.17.6
- Cargo clippy 0.1.71
- Cargo outdated 0.13.1
- Cbindgen 0.24.5
- Rustfmt 1.5.2

### Browsers and Drivers
- Google Chrome 115.0.5790.110
- ChromeDriver 115.0.5790.102
- Chromium 115.0.5790.0
- Microsoft Edge 115.0.1901.188
- Microsoft Edge WebDriver 115.0.1901.188
- Selenium server 4.10.0
- Mozilla Firefox 116.0
- Geckodriver 0.33.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.412, 7.0.109, 7.0.203, 7.0.306
- nbgv 3.6.133+2d32d93cb1

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.8
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.33-0ubuntu0.22.04.4
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
- 1.19.11
- 1.20.6

#### Node.js
- 14.21.3
- 16.20.1
- 18.17.0

#### Python
- 3.7.17
- 3.8.17
- 3.9.17
- 3.10.12
- 3.11.4

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.17 [PyPy 7.3.12]

#### Ruby
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.13

#### PowerShell Modules
- Az: 9.3.0
- MarkdownPS: 1.9
- Microsoft.Graph: 2.2.0
- Pester: 5.5.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                |
| Android Emulator           | 32.1.14                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                     |
| Android SDK Platform-Tools | 34.0.4                                                                                                                                                                                                                             |
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
| alpine:3.16             | sha256:cbe5d5973103a2d03408d1689a6efde4ea4920bde9f4b51fe7872e60ce2d8e56  | 2023-06-14 |
| alpine:3.17             | sha256:e95676db9e4a4f16f6cc01a8915368f82b018cc07aba951c1bd1db586c081388  | 2023-06-14 |
| alpine:3.18             | sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1  | 2023-06-14 |
| buildpack-deps:bullseye | sha256:593db75ce93184b16d45021566ed2d77f5009a8ce88da8254919a2e9e6ec14bf  | 2023-07-28 |
| buildpack-deps:buster   | sha256:b2c2267e1944a42dcdd448b66e8c8c889a3f5d1ab9705421326077a40a8aa0bc  | 2023-07-28 |
| debian:10               | sha256:7cd85d3d51a435062010581f14c5e3f9428388ac7234cc9a1e23dd14d7e4e914  | 2023-07-27 |
| debian:11               | sha256:630454da4c59041a2bca987a0d54c68962f1d6ea37a3641bd61db42b753234f2  | 2023-07-27 |
| moby/buildkit:latest    | sha256:e70e7a9bfaeafd2cb101b050ca78e1f73032473fc0aac5b10f35c5d26df1e2c6  | 2023-07-12 |
| node:14                 | sha256:a158d3b9b4e3fa813fa6c8c590b8f0a860e015ad4e59bbce5744d2f6fd8461aa  | 2023-04-12 |
| node:14-alpine          | sha256:434215b487a329c9e867202ff89e704d3a75e554822e07f3e0c0f9e606121b33  | 2023-03-29 |
| node:16                 | sha256:c83c7fa87b7449675b422877f547233f3d05ac75a4363ed030fc3635dd9cc395  | 2023-07-04 |
| node:16-alpine          | sha256:6c381d5dc2a11dcdb693f0301e8587e43f440c90cdb8933eaaaabb905d44cdb9  | 2023-06-21 |
| node:18                 | sha256:5b0596963c8653bac197457d0da388ac603658011f13cb15d303a54bb83679fa  | 2023-07-19 |
| node:18-alpine          | sha256:93d91deea65c9a0475507e8bc8b1917d6278522322f00c00b3ab09cab6830060  | 2023-07-19 |
| ubuntu:18.04            | sha256:152dc042452c496007f07ca9127571cb9c29697f42acbfad72324b2bb2e43c98  | 2023-05-30 |
| ubuntu:20.04            | sha256:c9820a44b950956a790c354700c1166a7ec648bc0d215fa438d3a339812f1d01  | 2023-06-28 |
| ubuntu:22.04            | sha256:0bced47fffa3361afa981854fcabcd4577cd43cebbb808cea2b1f33a3dd7f508  | 2023-06-28 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.2                     |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1                     |
| curl                   | 7.81.0-1ubuntu1.13                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.12-0ubuntu0.22.04.2          |
| dpkg                   | 1.21.1ubuntu2.2                     |
| dpkg-dev               | 1.21.1ubuntu2.2                     |
| fakeroot               | 1.28-1ubuntu1                       |
| file                   | 1:5.41-3                            |
| flex                   | 2.6.4-8build2                       |
| fonts-noto-color-emoji | 2.038-0ubuntu1                      |
| ftp                    | 20210827-4build1                    |
| g++                    | 4:11.2.0-1ubuntu1                   |
| gcc                    | 4:11.2.0-1ubuntu1                   |
| gnupg2                 | 2.2.27-3ubuntu2.1                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1                        |
| jq                     | 1.6-2.1ubuntu3                      |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libc6-dev              | 2.35-0ubuntu3.1                     |
| libcurl4               | 7.81.0-1ubuntu1.13                  |
| libgbm-dev             | 22.2.5-0ubuntu0.1\~22.04.3          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2                    |
| libmagic-dev           | 1:5.41-3                            |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.1                   |
| libssl-dev             | 3.0.2-0ubuntu1.10                   |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2                       |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.1                     |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| make                   | 4.3-4.1build1                       |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5   |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.3                  |
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
| ssh                    | 1:8.9p1-3ubuntu0.3                  |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.4                    |
| swig                   | 4.0.2-1ubuntu1                      |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.1        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2023c-0ubuntu0.22.04.2              |
| unzip                  | 6.0-26ubuntu3.1                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1                     |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.1        |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |
