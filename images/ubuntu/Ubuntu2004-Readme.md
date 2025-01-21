| Announcements |
|-|
| [[Windows & Ubuntu] Breaking change : Maven 3.8.* version will be updated to  Maven 3.9.*  from January 17,2025](https://github.com/actions/runner-images/issues/11093) |
| [[Ubuntu] Breaking Change: runner user will have UID 1001 instead of 1000 for larger runners](https://github.com/actions/runner-images/issues/10936) |
| [Ubuntu-latest workflows will use Ubuntu-24.04 image](https://github.com/actions/runner-images/issues/10636) |
***
# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1074-azure
- Image Version: 20250105.1.0
- Systemd version: 245.4-4ubuntu3.24

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.3.2 (Eshell 13.2.2)
- Erlang rebar3 3.24.0
- GNU C++: 10.5.0
- GNU Fortran: 10.5.0
- Julia 1.11.2
- Kotlin 2.1.0-release-394
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.5
- Perl 5.30.0
- Python 3.8.10
- Ruby 2.7.0p0
- Swift 6.0.3

### Package Management
- cpan 1.64
- Helm 3.16.4
- Homebrew 4.4.14
- Miniconda 24.11.1
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.7.1
- RubyGems 3.1.2
- Vcpkg (build from commit 65be70199)
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
- Ant 1.10.7
- Gradle 8.12
- Lerna 8.1.9
- Maven 3.8.8
- Sbt 1.10.7

### Tools
- Ansible 2.13.13
- apt-fast 1.10.0
- AzCopy 10.27.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.0.0
- Bazelisk 1.25.0
- Bicep 0.32.4
- Buildah 1.22.3
- CMake 3.31.3
- CodeQL Action Bundle 2.20.0
- Docker Amazon ECR Credential Helper 0.9.0
- Docker Compose v2 2.27.1
- Docker-Buildx 0.19.3
- Docker Client 26.1.3
- Docker Server 26.1.3
- Fastlane 2.226.0
- Git 2.47.1
- Git LFS 3.6.0
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 10.0.0
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.26.0
- Kubectl 1.32.0
- Kustomize 5.5.0
- Leiningen 2.11.2
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.34.0
- n 10.1.0
- Newman 6.2.1
- nvm 0.40.1
- OpenSSL 1.1.1f-1ubuntu2.23
- Packer 1.11.2
- Parcel 2.13.3
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.144.1
- R 4.4.2
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.10.3
- yamllint 1.35.1
- yq 4.44.6
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.174
- AWS CLI 2.22.28
- AWS CLI Session Manager Plugin 1.2.694.0
- AWS SAM CLI 1.132.0
- Azure CLI 2.67.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.64.0
- Google Cloud CLI 504.0.1
- Netlify CLI 17.38.1
- OpenShift CLI 4.15.19
- ORAS CLI 1.2.2
- Vercel CLI 39.2.5

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.432+6           | JAVA_HOME_8_X64      |
| 11.0.25+9 (default) | JAVA_HOME_11_X64     |
| 17.0.13+11          | JAVA_HOME_17_X64     |
| 21.0.5+11           | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 7.4.33, 8.0.30, 8.1.31, 8.2.27, 8.3.15
- Composer 2.8.4
- PHPUnit 8.5.41
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.14.1.1
- GHC 9.12.1
- GHCup 0.1.40.0
- Stack 3.3.1

### Rust Tools
- Cargo 1.83.0
- Rust 1.83.0
- Rustdoc 1.83.0
- Rustup 1.27.1

#### Packages
- Bindgen 0.71.1
- Cargo audit 0.21.0
- Cargo clippy 0.1.83
- Cargo outdated 0.16.0
- Cbindgen 0.27.0
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 131.0.6778.204
- ChromeDriver 131.0.6778.204
- Chromium 131.0.6778.0
- Microsoft Edge 131.0.2903.112
- Microsoft Edge WebDriver 131.0.2903.112
- Selenium server 4.27.0
- Mozilla Firefox 133.0.3
- Geckodriver 0.35.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.428, 7.0.410, 8.0.404
- nbgv 3.7.112+63bbe780b0

### Databases
- MongoDB 5.0.30
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.15
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.40-0ubuntu0.20.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.5.57.1

### Cached Tools

#### Go
- 1.21.13
- 1.22.10
- 1.23.4

#### Node.js
- 18.20.5
- 20.18.1
- 22.12.0

#### Python
- 3.8.18
- 3.9.21
- 3.10.16
- 3.11.11
- 3.12.8

#### PyPy
- 2.7.18 [PyPy 7.3.17]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.14 [PyPy 7.3.17]

#### Ruby
- 3.0.7
- 3.1.6
- 3.2.6

### PowerShell Tools
- PowerShell 7.4.6

#### PowerShell Modules
- Az: 12.1.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.25.0
- Pester: 5.6.1
- PSScriptAnalyzer: 1.23.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                     |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                         |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                         |
| Android SDK Platforms      | android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                      |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                                                                  |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                          |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                          |
| NDK                        | 26.3.11579264<br>27.2.12479018 (default)                                                                                                                                                                                                                                                                    |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag       | Digest                                                                   | Created    |
| -------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16          | sha256:452e7292acee0ee16c332324d7de05fa2c99f9994ecc9f0779c602916a672ae4  | 2024-01-27 |
| alpine:3.17          | sha256:8fc3dacfb6d69da8d44e42390de777e48577085db99aa4e4af35f483eb08b989  | 2024-09-06 |
| alpine:3.18          | sha256:2995c82e8e723d9a5c8585cb8e901d1c50e3c2759031027d3bff577449435157  | 2024-09-06 |
| alpine:3.19          | sha256:7a85bf5dc56c949be827f84f9185161265c58f589bb8b2a6b6bb6d3076c1be21  | 2024-09-06 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:21b74d95871e8676a0cf47df9caebb1021b2af60b9a6e4777ce92f92f98e3a90  | 2024-12-23 |
| debian:9             | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest | sha256:86c0ad9d1137c186e9d455912167df20e530bdf7f7c19de802e892bb8ca16552  | 2024-12-16 |
| node:18              | sha256:7f31a1eb14c61719b8bb0eaa029310cc33851f71d3578cc422b390f8096977c5  | 2024-11-15 |
| node:18-alpine       | sha256:6eb9c3d9bd191bd2cc6ce7ec3d5ec4c2127616140c8586af96a6bec8f28689d1  | 2024-12-05 |
| node:20              | sha256:d17aaa2a2fd82e09bd6a6da7cc4a79741340d2a3e39d172d1b30f295b1a850ff  | 2024-11-20 |
| node:20-alpine       | sha256:426f843809ae05f324883afceebaa2b9cab9cb697097dbb1a2a7a41c5701de72  | 2024-12-05 |
| node:22              | sha256:0e910f435308c36ea60b4cfd7b80208044d77a074d16b768a81901ce938a62dc  | 2024-12-03 |
| node:22-alpine       | sha256:6e80991f69cc7722c561e5d14d5e72ab47c0d6b6cfb3ae50fb9cf9a7b30fdf97  | 2024-12-05 |
| ubuntu:20.04         | sha256:8e5c4f0285ecbb4ead070431d29b576a530d3166df73ec44affc1cd27555141b  | 2024-10-11 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.9                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.25                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.18.28-0ubuntu0.20.04.1        |
| dpkg                   | 1.19.7ubuntu3.2                   |
| dpkg-dev               | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| findutils              | 4.7.0-1ubuntu1                    |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| g++                    | 4:9.3.0-1ubuntu2                  |
| gcc                    | 4:9.3.0-1ubuntu2                  |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3ubuntu1               |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libc6-dev              | 2.31-0ubuntu9.16                  |
| libcurl4               | 7.68.0-1ubuntu2.25                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6+deb10u1build0.20.04.1  |
| libgtk-3-0             | 3.24.20-0ubuntu1.2                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.6                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.16                  |
| m4                     | 1.4.18-4                          |
| make                   | 4.2.1-1.2                         |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.11               |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pigz                   | 2.4-1                             |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8ubuntu0.7                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.6                 |
| ssh                    | 1:8.2p1-4ubuntu0.11               |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.5                 |
| swig                   | 4.0.1-5build1                     |
| systemd-coredump       | 245.4-4ubuntu3.24                 |
| tar                    | 1.30+dfsg-7ubuntu0.20.04.4        |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2024a-0ubuntu0.20.04.1            |
| unzip                  | 6.0-25ubuntu1.2                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2.1                 |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.18      |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

