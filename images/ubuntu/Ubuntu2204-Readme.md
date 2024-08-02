| Announcements |
|-|
| [[All OSes] Android NDK versions <=25 will be removed from images on August 19](https://github.com/actions/runner-images/issues/10342) |
| [Ubuntu 24.04 is now available](https://github.com/actions/runner-images/issues/9848) |
| [[Ubuntu, Windows] Docker Compose v1 will be removed from images on July, 29](https://github.com/actions/runner-images/issues/9692) |
***
# Ubuntu 22.04
- OS Version: 22.04.4 LTS
- Kernel Version: 6.5.0-1025-azure
- Image Version: 20240730.2.0
- Systemd version: 249.11-0ubuntu3.12

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 13.0.1, 14.0.0, 15.0.7
- Clang-format: 13.0.1, 14.0.0, 15.0.7
- Clang-tidy: 13.0.1, 14.0.0, 15.0.7
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 10.5.0, 11.4.0, 12.3.0
- GNU Fortran: 10.5.0, 11.4.0, 12.3.0
- Julia 1.10.4
- Kotlin 2.0.0-release-341
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.4
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 5.10.1

### Package Management
- cpan 1.64
- Helm 3.15.3
- Homebrew 4.3.12
- Miniconda 24.5.0
- Npm 10.7.0
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.6.0
- RubyGems 3.3.5
- Vcpkg (build from commit 136a0d8b8)
- Yarn 1.22.22

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
- Ant 1.10.12
- Gradle 8.9
- Lerna 8.1.7
- Maven 3.8.8
- Sbt 1.10.1

### Tools
- Ansible 2.17.2
- apt-fast 1.10.0
- AzCopy 10.25.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 7.2.1
- Bazelisk 1.19.0
- Bicep 0.29.47
- Buildah 1.23.1
- CMake 3.30.1
- CodeQL Action Bundle 2.18.1
- Docker Amazon ECR Credential Helper 0.8.0
- Docker Compose v2 2.27.1
- Docker-Buildx 0.16.2
- Docker Client 26.1.3
- Docker Server 26.1.3
- Fastlane 2.222.0
- Git 2.46.0
- Git LFS 3.5.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 9.0.0
- jq 1.6
- Kind 0.23.0
- Kubectl 1.30.3
- Kustomize 5.4.3
- Leiningen 2.11.2
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.33.1
- n 9.2.3
- Newman 6.1.3
- nvm 0.39.7
- OpenSSL 3.0.2-0ubuntu1.16
- Packer 1.11.2
- Parcel 2.12.0
- Podman 3.4.4
- Pulumi 3.127.0
- R 4.4.1
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.9.3
- yamllint 1.35.1
- yq 4.44.2
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.216
- AWS CLI 2.17.19
- AWS CLI Session Manager Plugin 1.2.650.0
- AWS SAM CLI 1.121.0
- Azure CLI 2.62.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.53.0
- Google Cloud CLI 486.0.0
- Netlify CLI 17.33.4
- OpenShift CLI 4.16.4
- ORAS CLI 1.2.0
- Vercel CLI 35.2.1

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.422+5           | JAVA_HOME_8_X64      |
| 11.0.24+8 (default) | JAVA_HOME_11_X64     |
| 17.0.12+7           | JAVA_HOME_17_X64     |
| 21.0.4+7            | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.7.7
- PHPUnit 8.5.39
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.12.1.0
- GHC 9.10.1
- GHCup 0.1.30.0
- Stack 3.1.1

### Rust Tools
- Cargo 1.80.0
- Rust 1.80.0
- Rustdoc 1.80.0
- Rustup 1.27.1

#### Packages
- Bindgen 0.69.4
- Cargo audit 0.20.0
- Cargo clippy 0.1.80
- Cargo outdated 0.15.0
- Cbindgen 0.26.0
- Rustfmt 1.7.0

### Browsers and Drivers
- Google Chrome 127.0.6533.72
- ChromeDriver 127.0.6533.72
- Chromium 127.0.6533.0
- Microsoft Edge 127.0.2651.74
- Microsoft Edge WebDriver 127.0.2651.72
- Selenium server 4.23.0
- Mozilla Firefox 128.0.3
- Geckodriver 0.34.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.424, 7.0.410, 8.0.303
- nbgv 3.6.139+a9e8765620

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.12
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.37-0ubuntu0.22.04.3
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.3.566.1

### Cached Tools

#### Go
- 1.20.14
- 1.21.12
- 1.22.5

#### Node.js
- 16.20.2
- 18.20.4
- 20.16.0

#### Python
- 3.7.17
- 3.8.18
- 3.9.19
- 3.10.14
- 3.11.9
- 3.12.4

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.14 [PyPy 7.3.16]

#### Ruby
- 3.1.6
- 3.2.5

### PowerShell Tools
- PowerShell 7.4.4

#### PowerShell Modules
- Az: 11.3.1
- MarkdownPS: 1.10
- Microsoft.Graph: 2.21.0
- Pester: 5.6.1
- PSScriptAnalyzer: 1.22.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                 |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                     |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                     |
| Android SDK Platforms      | android-35 (rev 1)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                  |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                              |
| Google Play services       | 49                                                                                                                                                                                                                      |
| Google Repository          | 58                                                                                                                                                                                                                      |
| NDK                        | 24.0.8215888<br>25.2.9519653<br>26.3.11579264<br>27.0.12077973 (default)                                                                                                                                                |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/27.0.12077973 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/27.0.12077973 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/27.0.12077973 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/27.0.12077973 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag       | Digest                                                                   | Created    |
| -------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16          | sha256:452e7292acee0ee16c332324d7de05fa2c99f9994ecc9f0779c602916a672ae4  | 2024-01-27 |
| alpine:3.17          | sha256:ef813b2faa3dd1a37f9ef6ca98347b72cd0f55e4ab29fb90946f1b853bf032d9  | 2024-07-22 |
| alpine:3.18          | sha256:5292533eb4efd4b5cf35e93b5a2b7d0e07ea193224c49446c7802c19ee4f2da5  | 2024-07-22 |
| alpine:3.19          | sha256:95c16745f100f44cf9a0939fd3f357905f845f8b6fa7d0cde0e88c9764060185  | 2024-07-22 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:7aef2e7d061743fdb57973dac3ddbceb0b0912746ca7e0ee7535016c38286561  | 2024-07-23 |
| moby/buildkit:latest | sha256:0a5641c72659aa246458914fedcf941892aa15b8a49a79a0e8f3a4cc8246d5f9  | 2024-07-25 |
| node:16              | sha256:f77a1aef2da8d83e45ec990f45df50f1a286c5fe8bbfb8c6e4246c6389705c0b  | 2023-09-07 |
| node:16-alpine       | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18              | sha256:11b742eda0142d9ea809fad8c506cbcadb2802c7d4b32e044e6b976691df36b1  | 2024-07-09 |
| node:18-alpine       | sha256:17514b20acef0e79691285e7a59f3ae561f7a1702a9adc72a515aef23f326729  | 2024-07-09 |
| node:20              | sha256:1ae9ba874435551280e95c8a8e74adf8a48d72b564bf9dfe4718231f2144c88f  | 2024-07-24 |
| node:20-alpine       | sha256:eb8101caae9ac02229bd64c024919fe3d4504ff7f329da79ca60a04db08cef52  | 2024-07-24 |
| ubuntu:20.04         | sha256:0b897358ff6624825fb50d20ffb605ab0eaea77ced0adb8c6a4b756513dec6fc  | 2024-06-03 |
| ubuntu:22.04         | sha256:340d9b015b194dc6e2a13938944e0d016e57b9679963fdeb9ce021daac430221  | 2024-06-27 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.6                     |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1.2                   |
| curl                   | 7.81.0-1ubuntu1.16                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.28-0ubuntu0.22.04.1          |
| dpkg                   | 1.21.1ubuntu2.3                     |
| dpkg-dev               | 1.21.1ubuntu2.3                     |
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
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1                        |
| jq                     | 1.6-2.1ubuntu3                      |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libc6-dev              | 2.35-0ubuntu3.8                     |
| libcurl4               | 7.81.0-1ubuntu1.16                  |
| libgbm-dev             | 23.2.1-1ubuntu3.1\~22.04.2          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2.2                  |
| libmagic-dev           | 1:5.41-3ubuntu0.1                   |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.3                   |
| libssl-dev             | 3.0.2-0ubuntu1.16                   |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2.1                     |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.8                     |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| make                   | 4.3-4.1build1                       |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5   |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.10                 |
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
| sqlite3                | 3.37.2-2ubuntu0.3                   |
| ssh                    | 1:8.9p1-3ubuntu0.10                 |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.4                    |
| swig                   | 4.0.2-1ubuntu1                      |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.2        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2024a-0ubuntu0.22.04.1              |
| unzip                  | 6.0-26ubuntu3.2                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1.1                   |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.11       |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

