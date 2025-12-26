# Ubuntu 22.04
- OS Version: 22.04.5 LTS
- Kernel Version: 6.8.0-1044-azure
- Image Version: 20251216.185.1
- Systemd version: 249.11-0ubuntu3.17

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 13.0.1, 14.0.0, 15.0.7
- Clang-format: 13.0.1, 14.0.0, 15.0.7
- Clang-tidy: 13.0.1, 14.0.0, 15.0.7
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 10.5.0, 11.4.0, 12.3.0
- GNU Fortran: 10.5.0, 11.4.0, 12.3.0
- Julia 1.12.3
- Kotlin 2.2.21-release-469
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 20.19.6
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 6.2.3

### Package Management
- cpan 1.64
- Helm 3.19.4
- Homebrew 5.0.6
- Miniconda 25.9.1
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.8.0
- RubyGems 3.3.5
- Vcpkg (build from commit 2b6a882f61)
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
- Gradle 9.2.1
- Lerna 9.0.3
- Maven 3.9.11
- Sbt 1.11.7

### Tools
- Ansible 2.17.14
- apt-fast 1.10.0
- AzCopy 10.31.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.5.0
- Bazelisk 1.26.0
- Bicep 0.39.26
- Buildah 1.23.1
- CMake 3.31.6
- CodeQL Action Bundle 2.23.8
- Docker Amazon ECR Credential Helper 0.11.0
- Docker Compose v2 2.38.2
- Docker-Buildx 0.30.1
- Docker Client 28.0.4
- Docker Server 28.0.4
- Fastlane 2.229.1
- Git 2.52.0
- Git LFS 3.7.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 10.16.0
- jq 1.6
- Kind 0.30.0
- Kubectl 1.34.3
- Kustomize 5.8.0
- Leiningen 2.12.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.37.0
- n 10.2.0
- Newman 6.2.1
- nvm 0.40.3
- OpenSSL 3.0.2-0ubuntu1.20
- Packer 1.14.3
- Parcel 2.16.3
- Podman 3.4.4
- Pulumi 3.212.0
- R 4.5.2
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.14.2
- yamllint 1.37.1
- yq 4.50.1
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- Alibaba Cloud CLI 3.2.2
- AWS CLI 2.32.17
- AWS CLI Session Manager Plugin 1.2.764.0
- AWS SAM CLI 1.150.1
- Azure CLI 2.81.0
- Azure CLI (azure-devops) 1.0.2
- GitHub CLI 2.83.2
- Google Cloud CLI 549.0.1
- Netlify CLI 23.12.3
- OpenShift CLI 4.20.6
- ORAS CLI 1.3.0
- Vercel CLI 50.1.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.472+8           | JAVA_HOME_8_X64      |
| 11.0.29+7 (default) | JAVA_HOME_11_X64     |
| 17.0.17+10          | JAVA_HOME_17_X64     |
| 21.0.9+10           | JAVA_HOME_21_X64     |
| 25.0.1+8            | JAVA_HOME_25_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.9.2
- PHPUnit 8.5.50
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.16.0.0
- GHC 9.12.2
- GHCup 0.1.50.2
- Stack 3.7.1

### Rust Tools
- Cargo 1.92.0
- Rust 1.92.0
- Rustdoc 1.92.0
- Rustup 1.28.2

#### Packages
- Bindgen 0.72.1
- Cargo audit 0.22.0
- Cargo clippy 0.1.92
- Cargo outdated 0.17.0
- Cbindgen 0.29.2
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 143.0.7499.109
- ChromeDriver 143.0.7499.42
- Chromium 143.0.7499.0
- Microsoft Edge 143.0.3650.80
- Microsoft Edge WebDriver 143.0.3650.80
- Selenium server 4.39.0
- Mozilla Firefox 146.0
- Geckodriver 0.36.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 8.0.122, 8.0.206, 8.0.319, 8.0.416, 9.0.112, 9.0.205, 9.0.308, 10.0.101
- nbgv 3.9.50+6feeb89450

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.20
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.44-0ubuntu0.22.04.2
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 170.2.70.1

### Cached Tools

#### Go
- 1.22.12
- 1.23.12
- 1.24.11
- 1.25.5

#### Node.js
- 20.19.6
- 22.21.1
- 24.12.0

#### Python
- 3.9.25
- 3.10.19
- 3.11.14
- 3.12.12
- 3.13.11
- 3.14.2

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]
- 3.11.13 [PyPy 7.3.20]

#### Ruby
- 3.2.9
- 3.3.10
- 3.4.7

### PowerShell Tools
- PowerShell 7.4.13

#### PowerShell Modules
- Az: 12.5.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.33.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                                                                                                                                   |
| Android SDK Platform-Tools | 36.0.0                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| NDK                        | 26.3.11579264<br>27.3.13750724 (default)                                                                                                                                                                                                                                                                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Cached Docker images
| Repository:Tag       | Digest                                                                   | Created    |
| -------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.16          | sha256:452e7292acee0ee16c332324d7de05fa2c99f9994ecc9f0779c602916a672ae4  | 2024-01-27 |
| alpine:3.17          | sha256:8fc3dacfb6d69da8d44e42390de777e48577085db99aa4e4af35f483eb08b989  | 2024-09-06 |
| alpine:3.18          | sha256:de0eb0b3f2a47ba1eb89389859a9bd88b28e82f5826b6969ad604979713c2d4f  | 2025-02-14 |
| alpine:3.19          | sha256:6baf43584bcb78f2e5847d1de515f23499913ac9f12bdf834811a3145eb11ca1  | 2025-10-08 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:1b1fd1445c1d0ed68123cf76c2d7c7cb47dfdab3df56f7ff9303063110d43291  | 2025-12-08 |
| moby/buildkit:latest | sha256:de10faf919fc71ba4eb1dd7bd6449566d012b0c9436b1c61bfee21d621b009aa  | 2025-11-20 |
| node:18              | sha256:c6ae79e38498325db67193d391e6ec1d224d96c693a8a4d943498556716d3783  | 2025-03-27 |
| node:18-alpine       | sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e  | 2025-03-27 |
| node:20              | sha256:4b4e58e59c5e042928790c6fccd8ad16da6296bcc2e9924c56fba84a8e5ff662  | 2025-12-09 |
| node:20-alpine       | sha256:643e7036aa985317ebfee460005e322aa550c6b6883000d01daefb58689a58e2  | 2025-12-04 |
| node:22              | sha256:c8abd8da9cfddd2dfd2d5aa9ea2e54f9f70d3968ecf81bf5c2422594fa13fa83  | 2025-12-09 |
| node:22-alpine       | sha256:9632533eda8061fc1e9960cfb3f8762781c07a00ee7317f5dc0e13c05e15166f  | 2025-12-04 |
| ubuntu:20.04         | sha256:8feb4d8ca5354def3d8fce243717141ce31e2c428701f6682bd2fafe15388214  | 2025-04-08 |
| ubuntu:22.04         | sha256:104ae83764a5119017b8e8d6218fa0832b09df65aae7d5a6de29a85d813da2fb  | 2025-10-13 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.12                    |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1.2                   |
| curl                   | 7.81.0-1ubuntu1.21                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.39-0ubuntu0.22.04.2          |
| dpkg                   | 1.21.1ubuntu2.6                     |
| dpkg-dev               | 1.21.1ubuntu2.6                     |
| fakeroot               | 1.28-1ubuntu1                       |
| file                   | 1:5.41-3ubuntu0.1                   |
| findutils              | 4.8.0-1ubuntu3                      |
| flex                   | 2.6.4-8build2                       |
| fonts-noto-color-emoji | 2.047-0ubuntu0.22.04.1              |
| ftp                    | 20210827-4build1                    |
| g++                    | 4:11.2.0-1ubuntu1                   |
| gcc                    | 4:11.2.0-1ubuntu1                   |
| gnupg2                 | 2.2.27-3ubuntu2.4                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1ubuntu0.1               |
| jq                     | 1.6-2.1ubuntu3.1                    |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libc6-dev              | 2.35-0ubuntu3.11                    |
| libcurl4               | 7.81.0-1ubuntu1.21                  |
| libgbm-dev             | 23.2.1-1ubuntu3.1\~22.04.3          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2.2                  |
| libmagic-dev           | 1:5.41-3ubuntu0.1                   |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libnss3-tools          | 2:3.98-0ubuntu0.22.04.2             |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.5                   |
| libssl-dev             | 3.0.2-0ubuntu1.20                   |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2.1                     |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.11                    |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| make                   | 4.3-4.1build1                       |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5.4 |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.13                 |
| p7zip-full             | 16.02+dfsg-8                        |
| p7zip-rar              | 16.02-3build1                       |
| parallel               | 20210822+ds-2                       |
| pass                   | 1.7.4-5                             |
| patchelf               | 0.14.3-1                            |
| pigz                   | 2.6-1                               |
| pkg-config             | 0.29.2-1ubuntu3                     |
| pollinate              | 4.33-3ubuntu2.1                     |
| python-is-python3      | 3.9.2-2                             |
| rpm                    | 4.17.0+dfsg1-4build1                |
| rsync                  | 3.2.7-0ubuntu0.22.04.4              |
| shellcheck             | 0.8.0-2                             |
| sphinxsearch           | 2.2.11-8                            |
| sqlite3                | 3.37.2-2ubuntu0.5                   |
| ssh                    | 1:8.9p1-3ubuntu0.13                 |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.5                    |
| swig                   | 4.0.2-1ubuntu1                      |
| systemd-coredump       | 249.11-0ubuntu3.17                  |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.2        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2025b-0ubuntu0.22.04.1              |
| unzip                  | 6.0-26ubuntu3.2                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1.1                   |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.16       |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |
