# Ubuntu 22.04
- OS Version: 22.04.3 LTS
- Kernel Version: 5.15.0-1041-azure
- Image Version: 20230821.1.0
- Systemd version: 249.11-0ubuntu3.9

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 12.0.1, 13.0.1, 14.0.0
- Clang-format: 12.0.1, 13.0.1, 14.0.0
- Clang-tidy: 12.0.1, 13.0.1, 14.0.0
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 9.5.0, 10.5.0, 11.4.0, 12.3.0
- GNU Fortran: 9.5.0, 10.5.0, 11.4.0, 12.3.0
- Julia 1.9.2
- Kotlin 1.9.0-release-358
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.17.1
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 5.8.1

### Package Management
- cpan 1.64
- Helm 3.12.3
- Homebrew 4.1.5
- Miniconda 23.5.2
- Npm 9.6.7
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.2.0
- RubyGems 3.3.5
- Vcpkg (build from commit c95000e1b)
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
- Lerna 7.1.5
- Maven 3.8.8

### Tools
- Ansible 2.15.3
- apt-fast 1.9.12
- AzCopy 10.20.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.3.2
- Bazelisk 1.13.2
- Bicep 0.20.4
- Buildah 1.23.1
- CMake 3.27.3
- CodeQL Action Bundles 2.14.1 2.14.2
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v1 1.29.2
- Docker Compose v2 2.20.3
- Docker-Buildx 0.11.2
- Docker Client 24.0.5
- Docker Server 24.0.5
- Fastlane 2.214.0
- Git 2.41.0
- Git LFS 3.4.0
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 8.3.1
- jq 1.6
- Kind 0.20.0
- Kubectl 1.28.0
- Kustomize 5.1.1
- Leiningen 2.10.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.31.2
- n 9.1.0
- Newman 5.3.2
- nvm 0.39.4
- OpenSSL 3.0.2-0ubuntu1.10
- Packer 1.9.4
- Parcel 2.9.3
- Podman 3.4.4
- Pulumi 3.78.1
- R 4.3.1
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.5.5
- yamllint 1.32.0
- yq 4.35.1
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.177
- AWS CLI 2.13.11
- AWS CLI Session Manager Plugin 1.2.497.0
- AWS SAM CLI 1.95.0
- Azure CLI 2.51.0
- Azure CLI (azure-devops) 0.26.0
- GitHub CLI 2.32.1
- Google Cloud SDK 443.0.0
- Hub CLI 2.14.2
- Netlify CLI 16.1.0
- OpenShift CLI 4.13.9
- ORAS CLI 1.0.1
- Vercel CLI 31.4.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.382+5           | JAVA_HOME_8_X64      |
| 11.0.20+8 (default) | JAVA_HOME_11_X64     |
| 17.0.8+7            | JAVA_HOME_17_X64     |

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
- Cargo 1.71.1
- Rust 1.71.1
- Rustdoc 1.71.1
- Rustup 1.26.0

#### Packages
- Bindgen 0.66.1
- Cargo audit 0.17.6
- Cargo clippy 0.1.71
- Cargo outdated 0.13.1
- Cbindgen 0.24.5
- Rustfmt 1.5.2

### Browsers and Drivers
- Google Chrome 116.0.5845.96
- ChromeDriver 116.0.5845.96
- Chromium 116.0.5845.0
- Microsoft Edge 115.0.1901.203
- Microsoft Edge WebDriver 115.0.1901.203
- Selenium server 4.11.0
- Mozilla Firefox 116.0.3
- Geckodriver 0.33.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 6.0.413, 7.0.110, 7.0.203, 7.0.307, 7.0.400
- nbgv 3.6.133+2d32d93cb1

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.9
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.34-0ubuntu0.22.04.1
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
- 1.19.12
- 1.20.7
- 1.21.0

#### Node.js
- 14.21.3
- 16.20.2
- 18.17.1

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
- 3.10.12 [PyPy 7.3.12]

#### Ruby
- 3.1.4

### PowerShell Tools
- PowerShell 7.2.13

#### PowerShell Modules
- Az: 9.3.0
- MarkdownPS: 1.9
- Microsoft.Graph: 2.3.0
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
| Android SDK Platforms      | android-34 (rev 2)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
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
| alpine:3.16             | sha256:a8cbb8c69ee71561f4b69c066bad07f7e510caaa523da26fbfc606b10bd7934b  | 2023-08-07 |
| alpine:3.17             | sha256:f71a5f071694a785e064f05fed657bf8277f1b2113a8ed70c90ad486d6ee54dc  | 2023-08-07 |
| alpine:3.18             | sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a  | 2023-08-07 |
| buildpack-deps:bullseye | sha256:930a1ea53e70457cde2c9d449b531979475330c50366fef8d22520d676c2bb0d  | 2023-08-16 |
| buildpack-deps:buster   | sha256:c6cfa5c691f91c0760341abf073efe1c4b0437ad05375290b3298b8e1219de5b  | 2023-08-16 |
| debian:10               | sha256:b86bfc1dd2fb1820fea6c1e0b6e23d155198b518b3a506f6edad71bf6e9a8cef  | 2023-08-16 |
| debian:11               | sha256:1beb7cf458bdfe71b5220cb2069eb45e3fc7eb77a1ccfb169eaebf5f6c4809ab  | 2023-08-16 |
| moby/buildkit:latest    | sha256:d91fe5e6dad11f2c2cee6d268d5843ad64bf2e9852365d56b12d02f2315edce5  | 2023-08-02 |
| node:14                 | sha256:a158d3b9b4e3fa813fa6c8c590b8f0a860e015ad4e59bbce5744d2f6fd8461aa  | 2023-04-12 |
| node:14-alpine          | sha256:434215b487a329c9e867202ff89e704d3a75e554822e07f3e0c0f9e606121b33  | 2023-03-29 |
| node:16                 | sha256:818b5adc1ee4a04e8ad5efeb70871571efe414315ad7f16844f24f9962ffdc7e  | 2023-08-17 |
| node:16-alpine          | sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787  | 2023-08-10 |
| node:18                 | sha256:11e9c297fc51f6f65f7d0c7c8a8581e5721f2f16de43ceff1a199fd3ef609f95  | 2023-08-17 |
| node:18-alpine          | sha256:3482a20c97e401b56ac50ba8920cc7b5b2022bfc6aa7d4e4c231755770cf892f  | 2023-08-10 |
| ubuntu:18.04            | sha256:152dc042452c496007f07ca9127571cb9c29697f42acbfad72324b2bb2e43c98  | 2023-05-30 |
| ubuntu:20.04            | sha256:33a5cc25d22c45900796a1aca487ad7a7cb09f09ea00b779e3b2026b4fc2faba  | 2023-08-01 |
| ubuntu:22.04            | sha256:ec050c32e4a6085b423d36ecd025c0d3ff00c38ab93a3d71a460ff1c44fa6d77  | 2023-08-04 |

### Installed apt packages
| Name                   | Version                             |
| ---------------------- | ----------------------------------- |
| acl                    | 2.3.1-1                             |
| aria2                  | 1.36.0-1                            |
| autoconf               | 2.71-2                              |
| automake               | 1:1.16.5-1.3                        |
| binutils               | 2.38-4ubuntu2.3                     |
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
| libgbm-dev             | 23.0.4-0ubuntu1\~22.04.1            |
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
| libunwind8             | 1.3.2-2build2.1                     |
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
