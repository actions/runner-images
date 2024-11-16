| Announcements |
|-|
| [[Ubuntu] Breaking Change: runner user will have UID 1001 instead of 1000 for larger runners](https://github.com/actions/runner-images/issues/10936) |
| [[Ubuntu 20 and 22] Node.js version 16 will be removed on November 18,2024.](https://github.com/actions/runner-images/issues/10896) |
| [Ubuntu-latest workflows will use Ubuntu-24.04 image](https://github.com/actions/runner-images/issues/10636) |
***
# Ubuntu 22.04
- OS Version: 22.04.5 LTS
- Kernel Version: 6.5.0-1025-azure
- Image Version: 20241112.1.0
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
- Julia 1.11.1
- Kotlin 2.0.21-release-482
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.5
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 6.0.2

### Package Management
- cpan 1.64
- Helm 3.16.2
- Homebrew 4.4.5
- Miniconda 24.9.2
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.7.1
- RubyGems 3.3.5
- Vcpkg (build from commit 89f00b3b8)
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
- Gradle 8.11
- Lerna 8.1.9
- Maven 3.8.8
- Sbt 1.10.5

### Tools
- Ansible 2.17.6
- apt-fast 1.10.0
- AzCopy 10.26.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 7.4.1
- Bazelisk 1.23.0
- Bicep 0.31.34
- Buildah 1.23.1
- CMake 3.31.0
- CodeQL Action Bundle 2.19.3
- Docker Amazon ECR Credential Helper 0.9.0
- Docker Compose v2 2.27.1
- Docker-Buildx 0.18.0
- Docker Client 26.1.3
- Docker Server 26.1.3
- Fastlane 2.225.0
- Git 2.47.0
- Git LFS 3.5.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 9.4.0
- jq 1.6
- Kind 0.25.0
- Kubectl 1.31.2
- Kustomize 5.5.0
- Leiningen 2.11.2
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.34.0
- n 10.1.0
- Newman 6.2.1
- nvm 0.40.1
- OpenSSL 3.0.2-0ubuntu1.18
- Packer 1.11.2
- Parcel 2.13.0
- Podman 3.4.4
- Pulumi 3.138.0
- R 4.4.2
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.9.8
- yamllint 1.35.1
- yq 4.44.3
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.231
- AWS CLI 2.20.0
- AWS CLI Session Manager Plugin 1.2.688.0
- AWS SAM CLI 1.128.0
- Azure CLI 2.66.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.61.0
- Google Cloud CLI 501.0.0
- Netlify CLI 17.37.2
- OpenShift CLI 4.17.3
- ORAS CLI 1.2.0
- Vercel CLI 38.0.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.432+6           | JAVA_HOME_8_X64      |
| 11.0.25+9 (default) | JAVA_HOME_11_X64     |
| 17.0.13+11          | JAVA_HOME_17_X64     |
| 21.0.5+11           | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.8.2
- PHPUnit 8.5.40
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.12.1.0
- GHC 9.10.1
- GHCup 0.1.30.0
- Stack 3.1.1

### Rust Tools
- Cargo 1.82.0
- Rust 1.82.0
- Rustdoc 1.82.0
- Rustup 1.27.1

#### Packages
- Bindgen 0.70.1
- Cargo audit 0.21.0
- Cargo clippy 0.1.82
- Cargo outdated 0.15.0
- Cbindgen 0.27.0
- Rustfmt 1.7.1

### Browsers and Drivers
- Google Chrome 131.0.6778.69
- ChromeDriver 131.0.6778.69
- Chromium 131.0.6778.0
- Microsoft Edge 130.0.2849.80
- Microsoft Edge WebDriver 130.0.2849.78
- Selenium server 4.26.0
- Mozilla Firefox 132.0.1
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
- nbgv 3.6.146+392592327a

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.13
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.40-0ubuntu0.22.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 162.4.92.3

### Cached Tools

#### Go
- 1.21.13
- 1.22.9
- 1.23.3

#### Node.js
- 16.20.2
- 18.20.4
- 20.18.0
- 22.11.0

#### Python
- 3.7.17
- 3.8.18
- 3.9.20
- 3.10.15
- 3.11.10
- 3.12.7

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.14 [PyPy 7.3.17]

#### Ruby
- 3.1.6
- 3.2.6

### PowerShell Tools
- PowerShell 7.4.6

#### PowerShell Modules
- Az: 12.1.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.24.0
- Pester: 5.6.1
- PSScriptAnalyzer: 1.23.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                         |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                             |
| Android SDK Platforms      | android-35 (rev 1)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                          |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                                      |
| Google Play services       | 49                                                                                                                                                                                                                                                                              |
| Google Repository          | 58                                                                                                                                                                                                                                                                              |
| NDK                        | 26.3.11579264<br>27.2.12479018 (default)                                                                                                                                                                                                                                        |

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
| debian:11            | sha256:01559430c84e6bc864bed554345d1bfbfa94ac108ab68f39915cae34604b15c3  | 2024-11-11 |
| moby/buildkit:latest | sha256:918e92e639651fdfd0bd97f31bab0dd91756edd14e6f73f43a896715617c59a0  | 2024-11-07 |
| node:16              | sha256:f77a1aef2da8d83e45ec990f45df50f1a286c5fe8bbfb8c6e4246c6389705c0b  | 2023-09-07 |
| node:16-alpine       | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18              | sha256:d8bdb5bedbfdb7c941c117b94db88a2250a56fe33c2883f7a3ad62825bf31128  | 2024-07-09 |
| node:18-alpine       | sha256:a25c1e4ecc284985f4cbc449021e9259560c644dd9611e5a72d9c4750f24f6c7  | 2024-07-09 |
| node:20              | sha256:0c73476fa7c1435f0caee56a429fa506e36ec0e0666149eec5ea8e5f60fb5efa  | 2024-10-04 |
| node:20-alpine       | sha256:b1e0880c3af955867bc2f1944b49d20187beb7afa3f30173e15a97149ab7f5f1  | 2024-10-04 |
| node:22              | sha256:db556c2974040f7812c7f39c15afb1e8b1901d6e23f1975ff71b5236a1244e52  | 2024-10-29 |
| node:22-alpine       | sha256:b64ced2e7cd0a4816699fe308ce6e8a08ccba463c757c00c14cd372e3d2c763e  | 2024-10-29 |
| ubuntu:20.04         | sha256:8e5c4f0285ecbb4ead070431d29b576a530d3166df73ec44affc1cd27555141b  | 2024-10-11 |
| ubuntu:22.04         | sha256:0e5e4a57c2499249aafc3b40fcd541e9a456aab7296681a3994d631587203f97  | 2024-09-11 |

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
| curl                   | 7.81.0-1ubuntu1.18                  |
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
| libcurl4               | 7.81.0-1ubuntu1.18                  |
| libgbm-dev             | 23.2.1-1ubuntu3.1\~22.04.2          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2.2                  |
| libmagic-dev           | 1:5.41-3ubuntu0.1                   |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.3                   |
| libssl-dev             | 3.0.2-0ubuntu1.18                   |
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
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.12       |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

