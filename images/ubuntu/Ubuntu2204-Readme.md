| Announcements |
|-|
| [Old versions of Android SDK & tools will be removed from images on January, 8](https://github.com/actions/runner-images/issues/8952) |
| [Major Refactoring of GitHub Actions Runner Images Repository](https://github.com/actions/runner-images/issues/8706) |
***
# Ubuntu 22.04
- OS Version: 22.04.3 LTS
- Kernel Version: 6.2.0-1018-azure
- Image Version: 20231217.2.0
- Systemd version: 249.11-0ubuntu3.11

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 13.0.1, 14.0.0, 15.0.7
- Clang-format: 13.0.1, 14.0.0, 15.0.7
- Clang-tidy: 13.0.1, 14.0.0, 15.0.7
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 9.5.0, 10.5.0, 11.4.0, 12.3.0, 13.1.0
- GNU Fortran: 9.5.0, 10.5.0, 11.4.0, 12.3.0, 13.1.0
- Julia 1.9.4
- Kotlin 1.9.21-release-633
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.19.0
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 5.9.2

### Package Management
- cpan 1.64
- Helm 3.13.1
- Homebrew 4.1.25
- Miniconda 23.10.0
- Npm 10.2.3
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.3.3
- RubyGems 3.3.5
- Vcpkg (build from commit 0e47c1985)
- Yarn 1.22.21

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
- Lerna 8.0.1
- Maven 3.8.8

### Tools
- Ansible 2.16.2
- apt-fast 1.10.0
- AzCopy 10.21.2 - available by `azcopy` and `azcopy10` aliases
- Bazel 7.0.0
- Bazelisk 1.19.0
- Bicep 0.24.24
- Buildah 1.23.1
- CMake 3.28.1
- CodeQL Action Bundle 2.15.4
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.23.3
- Docker-Buildx 0.11.2
- Docker Client 24.0.7
- Docker Server 24.0.7
- Fastlane 2.217.0
- Git 2.43.0
- Git LFS 3.4.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 8.7.1
- jq 1.6
- Kind 0.20.0
- Kubectl 1.29.0
- Kustomize 5.3.0
- Leiningen 2.10.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.32.0
- n 9.2.0
- Newman 6.0.0
- nvm 0.39.7
- OpenSSL 3.0.2-0ubuntu1.12
- Packer 1.10.0
- Parcel 2.10.3
- Podman 3.4.4
- Pulumi 3.97.0
- R 4.3.2
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.6.6
- yamllint 1.33.0
- yq 4.40.5
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.189
- AWS CLI 2.15.2
- AWS CLI Session Manager Plugin 1.2.536.0
- AWS SAM CLI 1.105.0
- Azure CLI 2.55.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.40.1
- Google Cloud CLI 457.0.0
- Netlify CLI 17.10.1
- OpenShift CLI 4.14.6
- ORAS CLI 1.1.0
- Vercel CLI 32.7.2

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.392+8           | JAVA_HOME_8_X64      |
| 11.0.21+9 (default) | JAVA_HOME_11_X64     |
| 17.0.9+9            | JAVA_HOME_17_X64     |
| 21.0.1+12           | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.6.6
- PHPUnit 8.5.36
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.2.0
- GHC 9.8.1
- GHCup 0.1.20.0
- Stack 2.13.1

### Rust Tools
- Cargo 1.74.1
- Rust 1.74.1
- Rustdoc 1.74.1
- Rustup 1.26.0

#### Packages
- Bindgen 0.69.1
- Cargo audit 0.18.3
- Cargo clippy 0.1.74
- Cargo outdated 0.14.0
- Cbindgen 0.26.0
- Rustfmt 1.6.0

### Browsers and Drivers
- Google Chrome 120.0.6099.109
- ChromeDriver 120.0.6099.71
- Chromium 120.0.6099.0
- Microsoft Edge 120.0.2210.77
- Microsoft Edge WebDriver 120.0.2210.77
- Selenium server 4.16.0
- Mozilla Firefox 121.0
- Geckodriver 0.33.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.417, 7.0.404, 8.0.100
- nbgv 3.6.133+2d32d93cb1

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.10
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.35-0ubuntu0.22.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.1.167.1

### Cached Tools

#### Go
- 1.19.13
- 1.20.12
- 1.21.5

#### Node.js
- 16.20.2
- 18.19.0
- 20.10.0

#### Python
- 3.7.17
- 3.8.18
- 3.9.18
- 3.10.13
- 3.11.7
- 3.12.1

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.18 [PyPy 7.3.13]
- 3.10.13 [PyPy 7.3.13]

#### Ruby
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.17

#### PowerShell Modules
- Az: 9.3.0
- MarkdownPS: 1.9
- Microsoft.Graph: 2.11.1
- Pester: 5.5.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                       |
| Android Emulator           | 33.1.23                                                                                                                                                                                                                                                                                   |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                                                                            |
| Android SDK Platform-Tools | 34.0.5                                                                                                                                                                                                                                                                                    |
| Android SDK Platforms      | android-34-ext8 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 2)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                                    |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                    |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                                                |
| Google Play services       | 49                                                                                                                                                                                                                                                                                        |
| Google Repository          | 58                                                                                                                                                                                                                                                                                        |
| NDK                        | 24.0.8215888<br>25.2.9519653 (default)<br>26.1.10909125                                                                                                                                                                                                                                   |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/26.1.10909125 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.2.9519653  |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16             | sha256:e4cdb7d47b06ba0a062ad2a97a7d154967c8f83934594d9f2bd3efa89292996b  | 2023-11-30 |
| alpine:3.17             | sha256:6e94b5cda2d6fd57d85abf81e81dabaea97a5885f919da676cc19d3551da4061  | 2023-11-30 |
| alpine:3.18             | sha256:34871e7290500828b39e22294660bee86d966bc0017544e848dd9a255cdf59e0  | 2023-11-30 |
| buildpack-deps:bullseye | sha256:257cbe4fba66709d5a536dd5ac13b22411d469eaf61f421f5c2b871f2290e25c  | 2023-11-21 |
| buildpack-deps:buster   | sha256:77c7243f791521c7bf816e786ef46956eabb0c8e73c8479141ba5e92c05497a7  | 2023-11-21 |
| debian:10               | sha256:46ca02d33c65ab188d6e56f26c323bf1aa9a99074f2f54176fdc3884304f58b8  | 2023-11-21 |
| debian:11               | sha256:ab2b95aa8d7d6d54866b92c322cf0693933c1ae8038652f24ddfda1d1763a45a  | 2023-11-21 |
| moby/buildkit:latest    | sha256:5a8f30813a104b86e927ff4695a746f74a5bb921c7be1dbcca6d754dfbe04822  | 2023-12-01 |
| node:16                 | sha256:f77a1aef2da8d83e45ec990f45df50f1a286c5fe8bbfb8c6e4246c6389705c0b  | 2023-09-07 |
| node:16-alpine          | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18                 | sha256:7a4282663db6f22326c03618eef4320fa3cf70c5c3715546f9779858dc0ed3fd  | 2023-12-02 |
| node:18-alpine          | sha256:b1a0356f7d6b86c958a06949d3db3f7fb27f95f627aa6157cb98bc65c801efa2  | 2023-12-11 |
| node:20                 | sha256:445acd9b2ef7e9de665424053bf95652e0b8995ef36500557d48faf29300170a  | 2023-11-23 |
| node:20-alpine          | sha256:9e38d3d4117da74a643f67041c83914480b335c3bd44d37ccf5b5ad86cd715d1  | 2023-12-11 |
| ubuntu:20.04            | sha256:f2034e7195f61334e6caff6ecf2e965f92d11e888309065da85ff50c617732b8  | 2023-12-13 |
| ubuntu:22.04            | sha256:6042500cf4b44023ea1894effe7890666b0c5c7871ed83a97c36c76ae560bb9b  | 2023-12-12 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.4                     |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1                     |
| curl                   | 7.81.0-1ubuntu1.15                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.18-0ubuntu0.22.04.1          |
| dpkg                   | 1.21.1ubuntu2.2                     |
| dpkg-dev               | 1.21.1ubuntu2.2                     |
| fakeroot               | 1.28-1ubuntu1                       |
| file                   | 1:5.41-3ubuntu0.1                   |
| findutils              | 4.8.0-1ubuntu3                      |
| flex                   | 2.6.4-8build2                       |
| fonts-noto-color-emoji | 2.042-0ubuntu0.22.04.1              |
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
| libc6-dev              | 2.35-0ubuntu3.5                     |
| libcurl4               | 7.81.0-1ubuntu1.15                  |
| libgbm-dev             | 23.0.4-0ubuntu1\~22.04.1            |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2                    |
| libmagic-dev           | 1:5.41-3ubuntu0.1                   |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.3 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.1                   |
| libssl-dev             | 3.0.2-0ubuntu1.12                   |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2.1                     |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.5                     |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| make                   | 4.3-4.1build1                       |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5   |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.4                  |
| p7zip-full             | 16.02+dfsg-8                        |
| p7zip-rar              | 16.02-3build1                       |
| parallel               | 20210822+ds-2                       |
| pass                   | 1.7.4-5                             |
| patchelf               | 0.14.3-1                            |
| pigz                   | 2.6-1                               |
| pkg-config             | 0.29.2-1ubuntu3                     |
| pollinate              | 4.33-3ubuntu2                       |
| python-is-python3      | 3.9.2-2                             |
| rpm                    | 4.17.0+dfsg1-4build1                |
| rsync                  | 3.2.7-0ubuntu0.22.04.2              |
| shellcheck             | 0.8.0-2                             |
| sphinxsearch           | 2.2.11-8                            |
| sqlite3                | 3.37.2-2ubuntu0.1                   |
| ssh                    | 1:8.9p1-3ubuntu0.4                  |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.4                    |
| swig                   | 4.0.2-1ubuntu1                      |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.2        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2023c-0ubuntu0.22.04.2              |
| unzip                  | 6.0-26ubuntu3.1                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1                     |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.5        |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

