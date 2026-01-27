| Announcements |
|-|
| [[Windows/Ubuntu] Docker Server and Client will be updated to version 29.1.*, Docker Compose will be updated to version 2.40.3 on February 9th, 2026](https://github.com/actions/runner-images/issues/13474) |
| [[all OSs] Updating Azure PowerShell Module version to 14.6.0 on January 26th, 2026.](https://github.com/actions/runner-images/issues/13473) |
***
# Ubuntu 22.04
- OS Version: 22.04.5 LTS
- Kernel Version: 6.8.0-1044-azure
- Image Version: 20260126.19.1
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
- Julia 1.12.4
- Kotlin 2.3.0-release-356
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 20.20.0
- Perl 5.34.0
- Python 3.10.12
- Ruby 3.0.2p107
- Swift 6.2.3

### Package Management
- cpan 1.64
- Helm 3.20.0
- Homebrew 5.0.12
- Miniconda 25.11.1
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.8.0
- RubyGems 3.3.5
- Vcpkg (build from commit 425d0412a2)
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
- Gradle 9.3.0
- Lerna 9.0.3
- Maven 3.9.12
- Sbt 1.12.1

### Tools
- Ansible 2.17.14
- apt-fast 1.10.0
- AzCopy 10.31.1 - available by `azcopy` and `azcopy10` aliases
- Bazel 9.0.0
- Bazelisk 1.28.1
- Bicep 0.40.2
- Buildah 1.23.1
- CMake 3.31.6
- CodeQL Action Bundle 2.24.0
- Docker Amazon ECR Credential Helper 0.11.0
- Docker Compose v2 2.38.2
- Docker-Buildx 0.31.0
- Docker Client 28.0.4
- Docker Server 28.0.4
- Fastlane 2.231.1
- Git 2.52.0
- Git LFS 3.7.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 10.16.0
- jq 1.6
- Kind 0.31.0
- Kubectl 1.35.0
- Kustomize 5.8.0
- Leiningen 2.12.0
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.37.0
- n 10.2.0
- Newman 6.2.2
- nvm 0.40.3
- OpenSSL 3.0.2-0ubuntu1.20
- Packer 1.14.3
- Parcel 2.16.3
- Podman 3.4.4
- Pulumi 3.217.0
- R 4.5.2
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.14.3
- yamllint 1.38.0
- yq 4.50.1
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- Alibaba Cloud CLI 3.2.7
- AWS CLI 2.33.7
- AWS CLI Session Manager Plugin 1.2.764.0
- AWS SAM CLI 1.152.0
- Azure CLI 2.82.0
- Azure CLI (azure-devops) 1.0.2
- GitHub CLI 2.86.0
- Google Cloud CLI 553.0.0
- Netlify CLI 23.13.5
- OpenShift CLI 4.20.11
- ORAS CLI 1.3.0
- Vercel CLI 50.5.2

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.472+8           | JAVA_HOME_8_X64      |
| 11.0.29+7 (default) | JAVA_HOME_11_X64     |
| 17.0.18+8           | JAVA_HOME_17_X64     |
| 21.0.10+7           | JAVA_HOME_21_X64     |
| 25.0.2+10           | JAVA_HOME_25_X64     |

### PHP Tools
- PHP: 8.1.2
- Composer 2.9.4
- PHPUnit 8.5.51
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.16.1.0
- GHC 9.14.1
- GHCup 0.1.50.2
- Stack 3.9.1

### Rust Tools
- Cargo 1.93.0
- Rust 1.93.0
- Rustdoc 1.93.0
- Rustup 1.28.2

#### Packages
- Bindgen 0.72.1
- Cargo audit 0.22.0
- Cargo clippy 0.1.93
- Cargo outdated 0.17.0
- Cbindgen 0.29.2
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 144.0.7559.96
- ChromeDriver 144.0.7559.96
- Chromium 144.0.7559.0
- Microsoft Edge 144.0.3719.92
- Microsoft Edge WebDriver 144.0.3719.92
- Selenium server 4.40.0
- Mozilla Firefox 147.0.1
- Geckodriver 0.36.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 8.0.123, 8.0.206, 8.0.319, 8.0.417, 9.0.113, 9.0.205, 9.0.310, 10.0.102
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
- 1.24.12
- 1.25.6

#### Node.js
- 20.20.0
- 22.22.0
- 24.13.0

#### Python
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
- 3.2.10
- 3.3.10
- 3.4.8
- 4.0.1

### PowerShell Tools
- PowerShell 7.4.13

#### PowerShell Modules
- Az: 14.6.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.34.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                                   |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                              |
| Android SDK Platform-Tools | 36.0.2                                                                                                                                                                                                                                                                                                                |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                            |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                    |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                             |

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
| gnupg2                 | 2.2.27-3ubuntu2.5                   |
| haveged                | 1.9.14-1ubuntu1                     |
| imagemagick            | 8:6.9.11.60+dfsg-1.3ubuntu0.22.04.5 |
| iproute2               | 5.15.0-1ubuntu2                     |
| iputils-ping           | 3:20211215-1ubuntu0.1               |
| jq                     | 1.6-2.1ubuntu3.1                    |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2            |
| libc++-dev             | 1:14.0-55\~exp2                     |
| libc++abi-dev          | 1:14.0-55\~exp2                     |
| libc6-dev              | 2.35-0ubuntu3.12                    |
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
| locales                | 2.35-0ubuntu3.12                    |
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

