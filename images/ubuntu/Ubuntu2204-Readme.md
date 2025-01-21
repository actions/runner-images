| Announcements |
|-|
| [[Windows & Ubuntu] Breaking change : Maven 3.8.* version will be updated to  Maven 3.9.*  from January 17,2025](https://github.com/actions/runner-images/issues/11093) |
***
# Ubuntu 22.04
- OS Version: 22.04.5 LTS
- Kernel Version: 6.5.0-1025-azure
- Image Version: 20250120.2.0
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
- Julia 1.11.2
- Kotlin 2.1.0-release-394
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.5
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 6.0.3

### Package Management
- cpan 1.64
- Helm 3.17.0
- Homebrew 4.4.17
- Miniconda 24.11.1
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.7.1
- RubyGems 3.3.5
- Vcpkg (build from commit cf035d991)
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
- Gradle 8.12
- Lerna 8.1.9
- Maven 3.9.9
- Sbt 1.10.7

### Tools
- Ansible 2.17.7
- apt-fast 1.10.0
- AzCopy 10.27.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.0.1
- Bazelisk 1.25.0
- Bicep 0.32.4
- Buildah 1.23.1
- CMake 3.31.4
- CodeQL Action Bundle 2.20.1
- Docker Amazon ECR Credential Helper 0.9.0
- Docker Compose v2 2.27.1
- Docker-Buildx 0.20.0
- Docker Client 26.1.3
- Docker Server 26.1.3
- Fastlane 2.226.0
- Git 2.48.1
- Git LFS 3.6.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 10.0.2
- jq 1.6
- Kind 0.26.0
- Kubectl 1.32.1
- Kustomize 5.6.0
- Leiningen 2.11.2
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.34.0
- n 10.1.0
- Newman 6.2.1
- nvm 0.40.1
- OpenSSL 3.0.2-0ubuntu1.18
- Packer 1.11.2
- Parcel 2.13.3
- Podman 3.4.4
- Pulumi 3.146.0
- R 4.4.2
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.10.4
- yamllint 1.35.1
- yq 4.45.1
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.248
- AWS CLI 2.23.2
- AWS CLI Session Manager Plugin 1.2.694.0
- AWS SAM CLI 1.132.0
- Azure CLI 2.68.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.65.0
- Google Cloud CLI 506.0.0
- Netlify CLI 18.0.1
- OpenShift CLI 4.17.12
- ORAS CLI 1.2.2
- Vercel CLI 39.3.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.432+6           | JAVA_HOME_8_X64      |
| 11.0.25+9 (default) | JAVA_HOME_11_X64     |
| 17.0.13+11          | JAVA_HOME_17_X64     |
| 21.0.5+11           | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 8.1.2
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
- Cargo 1.84.0
- Rust 1.84.0
- Rustdoc 1.84.0
- Rustup 1.27.1

#### Packages
- Bindgen 0.71.1
- Cargo audit 0.21.1
- Cargo clippy 0.1.84
- Cargo outdated 0.16.0
- Cbindgen 0.28.0
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 132.0.6834.83
- ChromeDriver 132.0.6834.83
- Chromium 132.0.6834.0
- Microsoft Edge 132.0.2957.115
- Microsoft Edge WebDriver 132.0.2957.115
- Selenium server 4.28.0
- Mozilla Firefox 134.0.1
- Geckodriver 0.35.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.428, 8.0.405
- nbgv 3.7.115+d31f50f4d1

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.15
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
- SqlPackage 162.5.57.1

### Cached Tools

#### Go
- 1.21.13
- 1.22.10
- 1.23.4

#### Node.js
- 18.20.5
- 20.18.1
- 22.13.0

#### Python
- 3.8.18
- 3.9.21
- 3.10.16
- 3.11.11
- 3.12.8

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
- Microsoft.Graph: 2.25.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.23.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                     |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                         |
| Android SDK Build-tools    | 35.0.0 35.0.1<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                  |
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
| alpine:3.18          | sha256:dd60c75fba961ecc5e918961c713f3c42dd5665171c58f9b2ef5aafe081ad5a0  | 2025-01-08 |
| alpine:3.19          | sha256:6380aa6b04faa579332d4c9d1f65bd7093012ba6e01d9bbcd5e2d8a4f9fae38f  | 2025-01-08 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:e5bfb7364038fd100c2faebdd674145bd1bc758a57f3c67023cced99d0eff0f7  | 2025-01-13 |
| moby/buildkit:latest | sha256:14aa1b4dd92ea0a4cd03a54d0c6079046ea98cd0c0ae6176bdd7036ba370cbbe  | 2025-01-20 |
| node:18              | sha256:8b7f2b36c945174b27fe833689fcc47b78dd47de0eda2d6e868e6e4ec2c63ae0  | 2024-11-15 |
| node:18-alpine       | sha256:a24108da7089c2d293ceaa61fb8969ec10821e8efe25572e5abb10b1841eb70b  | 2024-12-05 |
| node:20              | sha256:968ca0550acc7589a8b1324401ec6e39ace53b2c82d2aed3a278e9ff491c2b1c  | 2024-11-20 |
| node:20-alpine       | sha256:24fb6aa7020d9a20b00d6da6d1714187c45ed00d1eb4adb01395843c338b9372  | 2024-12-05 |
| node:22              | sha256:fa54405993eaa6bab6b6e460f5f3e945a2e2f07942ba31c0e297a7d9c2041f62  | 2025-01-07 |
| node:22-alpine       | sha256:f2dc6eea95f787e25f173ba9904c9d0647ab2506178c7b5b7c5a3d02bc4af145  | 2025-01-07 |
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
| curl                   | 7.81.0-1ubuntu1.20                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.30-0ubuntu0.22.04.1          |
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
| libcurl4               | 7.81.0-1ubuntu1.20                  |
| libgbm-dev             | 23.2.1-1ubuntu3.1\~22.04.3          |
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
| rsync                  | 3.2.7-0ubuntu0.22.04.4              |
| shellcheck             | 0.8.0-2                             |
| sphinxsearch           | 2.2.11-8                            |
| sqlite3                | 3.37.2-2ubuntu0.3                   |
| ssh                    | 1:8.9p1-3ubuntu0.10                 |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.4                    |
| swig                   | 4.0.2-1ubuntu1                      |
| systemd-coredump       | 249.11-0ubuntu3.12                  |
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

