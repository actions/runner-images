| Announcements |
|-|
| [[Ubuntu] The Ubuntu 22 based runner images will begin deprecation on September 17th and will be fully unsupported by April 17th for GitHub Actions and Azure DevOps](https://github.com/actions/runner-images/issues/14254) |
| [Go versions <=1.23  will be removed from tool-cache](https://github.com/actions/runner-images/issues/14237) |
| [[Ubuntu] Ubuntu 26.04 and Ubuntu 26.04 Arm is now available as a public preview](https://github.com/actions/runner-images/issues/14226) |
| [[ARM] Arm64 runner images now maintained by GitHub](https://github.com/actions/runner-images/issues/14100) |
***
# Ubuntu 22.04
- OS Version: 22.04.5 LTS
- Kernel Version: 6.8.0-1059-azure
- Image Version: 20260623.199.1
- Systemd version: 249.11-0ubuntu3.21

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Clang: 13.0.1, 14.0.0, 15.0.7
- Clang-format: 13.0.1, 14.0.0, 15.0.7
- Clang-tidy: 13.0.1, 14.0.0, 15.0.7
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 10.5.0, 11.4.0, 12.3.0
- GNU Fortran: 10.5.0, 11.4.0, 12.3.0
- Julia 1.12.6
- Kotlin 2.4.0-release-281
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 22.23.1
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 6.3.2

### Package Management
- cpan 1.64
- Helm 3.21.2
- Homebrew 6.0.3
- Miniconda 26.3.2
- Npm 10.9.8
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.14.1
- RubyGems 3.3.5
- Vcpkg (build from commit 67b5ee32c6)
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
- Gradle 9.6.0
- Lerna 9.0.7
- Maven 3.9.16
- Sbt 1.12.13

### Tools
- Ansible 2.17.14
- apt-fast 1.10.0
- AzCopy 10.32.4 - available by `azcopy` and `azcopy10` aliases
- Bazel 9.1.1
- Bazelisk 1.28.1
- Bicep 0.44.1
- Buildah 1.23.1
- CMake 3.31.6
- CodeQL Action Bundle 2.25.6
- Docker Amazon ECR Credential Helper 0.12.0
- Docker Compose 2.38.2
- Docker-Buildx 0.35.0
- Docker Client 28.0.4
- Docker Server 28.0.4
- Fastlane 2.236.1
- Git 2.54.0
- Git LFS 3.7.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 11.7.0
- jq 1.6
- Kind 0.32.0
- Kubectl 1.36.2
- Kustomize 5.8.1
- Leiningen 2.12.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.38.1
- n 10.2.0
- Newman 6.2.2
- nvm 0.40.5
- OpenSSL 3.0.2-0ubuntu1.25
- Packer 1.15.4
- Parcel 2.16.4
- Podman 3.4.4
- Pulumi 3.247.0
- R 4.6.0
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.15.6
- yamllint 1.38.0
- yq 4.53.3
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- Alibaba Cloud CLI 3.4.0
- AWS CLI 2.35.11
- AWS CLI Session Manager Plugin 1.2.835.0
- AWS SAM CLI 1.162.1
- Azure CLI 2.87.0
- Azure CLI (azure-devops) 1.0.4
- GitHub CLI 2.95.0
- Google Cloud CLI 574.0.0
- ORAS CLI 1.3.2
- Netlify CLI 26.1.0
- OpenShift CLI 4.22.2
- Vercel CLI 54.15.1

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.492+9            | JAVA_HOME_8_X64      |
| 11.0.31+11 (default) | JAVA_HOME_11_X64     |
| 17.0.19+10           | JAVA_HOME_17_X64     |
| 21.0.11+10           | JAVA_HOME_21_X64     |
| 25.0.3+9             | JAVA_HOME_25_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.10.1
- PHPUnit 8.5.52
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.16.1.0
- GHC 9.14.1
- GHCup 0.2.6.2
- Stack 3.11.1

### Rust Tools
- Cargo 1.96.0
- Rust 1.96.0
- Rustdoc 1.96.0
- Rustup 1.29.0

#### Packages
- Bindgen 0.72.1
- Cargo audit 0.22.2
- Cargo clippy 0.1.96
- Cargo outdated 0.19.0
- Cbindgen 0.29.4
- Rustfmt 1.9.0

### Browsers and Drivers
- Google Chrome 149.0.7827.196
- ChromeDriver 149.0.7827.155
- Chromium 149.0.7827.0
- Microsoft Edge 149.0.4022.80
- Microsoft Edge WebDriver 149.0.4022.80
- Selenium server 4.45.0
- Mozilla Firefox 152.0.1
- Geckodriver 0.37.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 8.0.128, 8.0.206, 8.0.319, 8.0.422, 9.0.118, 9.0.205, 9.0.315, 10.0.109, 10.0.204, 10.0.301
- nbgv 3.10.85+c46e47c69b

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.23
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.46-0ubuntu0.22.04.3
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

#### MS SQL
- sqlcmd 17.11.0001.1
- SqlPackage 170.4.83.3

### Cached Tools

#### Go
- 1.24.13
- 1.25.11
- 1.26.4

#### Node.js
- 22.23.0
- 24.17.0

#### Python
- 3.10.20
- 3.11.15
- 3.12.13
- 3.13.14
- 3.14.6

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]
- 3.11.15 [PyPy 7.3.23]

#### Ruby
- 3.2.11
- 3.3.11
- 3.4.9
- 4.0.5

### PowerShell Tools
- PowerShell 7.6.2

#### PowerShell Modules
- Az: 15.6.1
- MarkdownPS: 1.10
- Microsoft.Graph: 2.38.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.25.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                                            |
| Android SDK Platform-Tools | 37.0.0                                                                                                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                        |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                            |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                                                     |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/29.0.14206865 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/27.3.13750724 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

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
| coreutils              | 8.32-4.1ubuntu1.3                   |
| curl                   | 7.81.0-1ubuntu1.24                  |
| dbus                   | 1.12.20-2ubuntu4.1                  |
| dnsutils               | 1:9.18.39-0ubuntu0.22.04.4          |
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
| gnupg2                 | 2.2.27-3ubuntu2.5                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| iproute2               | 5.15.0-1ubuntu2.1                   |
| iputils-ping           | 3:20211215-1ubuntu0.1               |
| jq                     | 1.6-2.1ubuntu3.2                    |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libc6-dev              | 2.35-0ubuntu3.13                    |
| libcurl4               | 7.81.0-1ubuntu1.24                  |
| libgbm-dev             | 23.2.1-1ubuntu3.1\~22.04.4          |
| libgconf-2-4           | 3.2.6-7ubuntu2                      |
| libgsl-dev             | 2.7.1+dfsg-3                        |
| libgtk-3-0             | 3.24.33-1ubuntu2.2                  |
| libicu-dev             | 70.1-2                              |
| libmagic-dev           | 1:5.41-3ubuntu0.1                   |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| libnss3-tools          | 2:3.98-0ubuntu0.22.04.3             |
| libsecret-1-dev        | 0.20.5-2                            |
| libsqlite3-dev         | 3.37.2-2ubuntu0.5                   |
| libssl-dev             | 3.0.2-0ubuntu1.25                   |
| libtool                | 2.4.6-15build2                      |
| libunwind8             | 1.3.2-2build2.1                     |
| libxkbfile-dev         | 1:1.1.0-1build3                     |
| libxss1                | 1:1.2.3-1build2                     |
| libyaml-dev            | 0.2.2-1build2                       |
| locales                | 2.35-0ubuntu3.13                    |
| lz4                    | 1.9.3-2build2                       |
| m4                     | 1.4.18-5ubuntu2                     |
| make                   | 4.3-4.1build1                       |
| mediainfo              | 22.03-1                             |
| mercurial              | 6.1.1-1ubuntu1                      |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5.4 |
| netcat                 | 1.218-4ubuntu1                      |
| openssh-client         | 1:8.9p1-3ubuntu0.15                 |
| p7zip-full             | 16.02+dfsg-8                        |
| p7zip-rar              | 16.02-3build1                       |
| parallel               | 20210822+ds-2                       |
| pass                   | 1.7.4-5                             |
| patchelf               | 0.14.3-1                            |
| pigz                   | 2.6-1                               |
| pkg-config             | 0.29.2-1ubuntu3                     |
| pollinate              | 4.33-3ubuntu2.3                     |
| python-is-python3      | 3.9.2-2                             |
| rpm                    | 4.17.0+dfsg1-4build1                |
| rsync                  | 3.2.7-0ubuntu0.22.04.7              |
| shellcheck             | 0.8.0-2                             |
| sphinxsearch           | 2.2.11-8                            |
| sqlite3                | 3.37.2-2ubuntu0.5                   |
| ssh                    | 1:8.9p1-3ubuntu0.15                 |
| sshpass                | 1.09-1                              |
| subversion             | 1.14.1-3ubuntu0.22.04.1             |
| sudo                   | 1.9.9-1ubuntu2.6                    |
| swig                   | 4.0.2-1ubuntu1                      |
| systemd-coredump       | 249.11-0ubuntu3.21                  |
| tar                    | 1.34+dfsg-1ubuntu0.1.22.04.2        |
| telnet                 | 0.17-44build1                       |
| texinfo                | 6.8-4build1                         |
| time                   | 1.9-0.1build2                       |
| tk                     | 8.6.11+1build2                      |
| tzdata                 | 2026a-0ubuntu0.22.04.1              |
| unzip                  | 6.0-26ubuntu3.2                     |
| upx                    | 3.96-3                              |
| wget                   | 1.21.2-2ubuntu1.1                   |
| xorriso                | 1.5.4-2                             |
| xvfb                   | 2:21.1.4-2ubuntu1.7\~22.04.16       |
| xz-utils               | 5.2.5-2ubuntu1.1                    |
| zip                    | 3.0-12build2                        |
| zsync                  | 0.6.2-3ubuntu1                      |

