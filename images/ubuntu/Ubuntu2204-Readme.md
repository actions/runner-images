| Announcements |
|-|
| [[Windows ,Ubuntu, MacOs ] Breaking change: Updating  Azure PowerShell Module version as 12.5.x   from  2025-07-04](https://github.com/actions/runner-images/issues/12333) |
| [[Windows & Ubuntu] .NET 6 will be removed from the images on  2025-08-01.](https://github.com/actions/runner-images/issues/12241) |
| [[Ubuntu] Go version 1.21 will be removed from the images on 2025-06-13 and updated to the latest version 1.24 ,setting it as the default.](https://github.com/actions/runner-images/issues/12176) |
***
# Ubuntu 22.04
- OS Version: 22.04.5 LTS
- Kernel Version: 6.8.0-1029-azure
- Image Version: 20250609.1.0
- Systemd version: 249.11-0ubuntu3.15

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 13.0.1, 14.0.0, 15.0.7
- Clang-format: 13.0.1, 14.0.0, 15.0.7
- Clang-tidy: 13.0.1, 14.0.0, 15.0.7
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 10.5.0, 11.4.0, 12.3.0
- GNU Fortran: 10.5.0, 11.4.0, 12.3.0
- Julia 1.11.5
- Kotlin 2.1.10-release-473
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 20.19.2
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 6.1.2

### Package Management
- cpan 1.64
- Helm 3.18.2
- Homebrew 4.5.5
- Miniconda 25.3.1
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.7.1
- RubyGems 3.3.5
- Vcpkg (build from commit 984f9232b2)
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
- Gradle 8.14.2
- Lerna 8.2.2
- Maven 3.9.10
- Sbt 1.11.2

### Tools
- Ansible 2.17.12
- apt-fast 1.10.0
- AzCopy 10.29.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.2.1
- Bazelisk 1.26.0
- Bicep 0.36.1
- Buildah 1.23.1
- CMake 3.31.6
- CodeQL Action Bundle 2.21.4
- Docker Amazon ECR Credential Helper 0.10.0
- Docker Compose v2 2.35.1
- Docker-Buildx 0.24.0
- Docker Client 28.0.4
- Docker Server 28.0.4
- Fastlane 2.227.2
- Git 2.49.0
- Git LFS 3.6.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 10.10.0
- jq 1.6
- Kind 0.29.0
- Kubectl 1.33.1
- Kustomize 5.6.0
- Leiningen 2.11.2
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.34.0
- n 10.2.0
- Newman 6.2.1
- nvm 0.40.3
- OpenSSL 3.0.2-0ubuntu1.19
- Packer 1.13.1
- Parcel 2.15.2
- Podman 3.4.4
- Pulumi 3.175.0
- R 4.5.0
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.12.1
- yamllint 1.37.1
- yq 4.45.4
- zstd 1.5.7
- Ninja 1.12.1

### CLI Tools
- Alibaba Cloud CLI 3.0.282
- AWS CLI 2.27.31
- AWS CLI Session Manager Plugin 1.2.707.0
- AWS SAM CLI 1.140.0
- Azure CLI 2.74.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.74.0
- Google Cloud CLI 525.0.0
- Netlify CLI 22.1.3
- OpenShift CLI 4.18.16
- ORAS CLI 1.2.3
- Vercel CLI 42.3.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.452+9           | JAVA_HOME_8_X64      |
| 11.0.27+6 (default) | JAVA_HOME_11_X64     |
| 17.0.15+6           | JAVA_HOME_17_X64     |
| 21.0.7+6            | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.8.9
- PHPUnit 8.5.42
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.14.2.0
- GHC 9.12.2
- GHCup 0.1.50.2
- Stack 3.5.1

### Rust Tools
- Cargo 1.87.0
- Rust 1.87.0
- Rustdoc 1.87.0
- Rustup 1.28.2

#### Packages
- Bindgen 0.72.0
- Cargo audit 0.21.2
- Cargo clippy 0.1.87
- Cargo outdated 0.17.0
- Cbindgen 0.29.0
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 137.0.7151.68
- ChromeDriver 137.0.7151.68
- Chromium 137.0.7151.0
- Microsoft Edge 137.0.3296.68
- Microsoft Edge WebDriver 137.0.3296.68
- Selenium server 4.33.0
- Mozilla Firefox 136.0.4
- Geckodriver 0.36.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.428, 8.0.410, 9.0.203
- nbgv 3.7.115+d31f50f4d1

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.18
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.42-0ubuntu0.22.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.10.0001.1
- SqlPackage 170.0.94.3

### Cached Tools

#### Go
- 1.22.12
- 1.23.10
- 1.24.4

#### Node.js
- 18.20.8
- 20.19.2
- 22.16.0

#### Python
- 3.9.23
- 3.10.18
- 3.11.13
- 3.12.11
- 3.13.4

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.1.7
- 3.2.8
- 3.3.8

### PowerShell Tools
- PowerShell 7.4.10

#### PowerShell Modules
- Az: 12.1.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.28.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 36.0.0<br>35.0.0 35.0.1<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                                                          |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                        |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                            |
| NDK                        | 26.3.11579264<br>27.2.12479018 (default)                                                                                                                                                                                                                                                                                                                      |

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
| alpine:3.18          | sha256:de0eb0b3f2a47ba1eb89389859a9bd88b28e82f5826b6969ad604979713c2d4f  | 2025-02-14 |
| alpine:3.19          | sha256:e5d0aea7f7d2954678a9a6269ca2d06e06591881161961ea59e974dff3f12377  | 2025-02-14 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:cf48c31af360e1c0a0aedd33aae4d928b68c2cdf093f1612650eb1ff434d1c34  | 2025-05-20 |
| moby/buildkit:latest | sha256:832fa7aa1eb3deb56fa62ae933bfa42dad9a83ff4824dbbaf173b49c722b59d0  | 2025-05-21 |
| node:18              | sha256:c6ae79e38498325db67193d391e6ec1d224d96c693a8a4d943498556716d3783  | 2025-03-27 |
| node:18-alpine       | sha256:8d6421d663b4c28fd3ebc498332f249011d118945588d0a35cb9bc4b8ca09d9e  | 2025-03-27 |
| node:20              | sha256:7c4cd7c6935554b79c6fffb88e7bde3db0ce25b45d4c634d1fb0f1a6e7f5b782  | 2025-05-15 |
| node:20-alpine       | sha256:d3507a213936fe4ef54760a186e113db5188472d9efdf491686bd94580a1c1e8  | 2025-05-30 |
| node:22              | sha256:0b5b940c21ab03353de9042f9166c75bcfc53c4cd0508c7fd88576646adbf875  | 2025-05-21 |
| node:22-alpine       | sha256:41e4389f3d988d2ed55392df4db1420ad048ae53324a8e2b7c6d19508288107e  | 2025-05-30 |
| ubuntu:20.04         | sha256:8feb4d8ca5354def3d8fce243717141ce31e2c428701f6682bd2fafe15388214  | 2025-04-08 |
| ubuntu:22.04         | sha256:01a3ee0b5e413cefaaffc6abe68c9c37879ae3cced56a8e088b1649e5b269eee  | 2025-05-30 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.8                     |
| bison                  | 2:3.8.2+dfsg-1build1                |
| brotli                 | 1.0.9-2build6                       |
| bzip2                  | 1.0.8-5build1                       |
| coreutils              | 8.32-4.1ubuntu1.2                   |
| curl                   | 7.81.0-1ubuntu1.20                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.30-0ubuntu0.22.04.2          |
| dpkg                   | 1.21.1ubuntu2.3                     |
| dpkg-dev               | 1.21.1ubuntu2.3                     |
| fakeroot               | 1.28-1ubuntu1                       |
| file                   | 1:5.41-3ubuntu0.1                   |
| findutils              | 4.8.0-1ubuntu3                      |
| flex                   | 2.6.4-8build2                       |
| fonts-noto-color-emoji | 2.047-0ubuntu0.22.04.1              |
| ftp                    | 20210827-4build1                    |
| g++                    | 4:11.2.0-1ubuntu1                   |
| gcc                    | 4:11.2.0-1ubuntu1                   |
| gnupg2                 | 2.2.27-3ubuntu2.3                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1                        |
| jq                     | 1.6-2.1ubuntu3                      |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libc6-dev              | 2.35-0ubuntu3.10                    |
| libcurl4               | 7.81.0-1ubuntu1.20                  |
| libgbm-dev             | 23.2.1-1ubuntu3.1\~22.04.3          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2.2                  |
| libmagic-dev           | 1:5.41-3ubuntu0.1                   |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.4                   |
| libssl-dev             | 3.0.2-0ubuntu1.19                   |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2.1                     |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.10                    |
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
| sqlite3                | 3.37.2-2ubuntu0.4                   |
| ssh                    | 1:8.9p1-3ubuntu0.13                 |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.4                    |
| swig                   | 4.0.2-1ubuntu1                      |
| systemd-coredump       | 249.11-0ubuntu3.15                  |
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
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.14       |
| xz-utils               | 5.2.5-2ubuntu1                      |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

