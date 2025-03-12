| Announcements |
|-|
| [[Ubuntu] Breaking change : PostgreSQL version 14.* for Ubuntu 22.04, PostgreSQL version 16.* for Ubuntu 24.04 will be updated to version 17.* from 2025-05-09](https://github.com/actions/runner-images/issues/11723) |
***
# Ubuntu 24.04
- OS Version: 24.04.2 LTS
- Kernel Version: 6.8.0-1021-azure
- Image Version: 20250309.1.0
- Systemd version: 255.4-1ubuntu8.5

## Installed Software

### Language and Runtime
- Bash 5.2.21(1)-release
- Clang: 16.0.6, 17.0.6, 18.1.3
- Clang-format: 16.0.6, 17.0.6, 18.1.3
- Clang-tidy: 16.0.6, 17.0.6, 18.1.3
- Dash 0.5.12-6ubuntu5
- GNU C++: 12.3.0, 13.3.0, 14.2.0
- GNU Fortran: 12.3.0, 13.3.0, 14.2.0
- Julia 1.11.3
- Kotlin 2.1.10-release-473
- Node.js 20.18.3
- Perl 5.38.2
- Python 3.12.3
- Ruby 3.2.3
- Swift 6.0.3

### Package Management
- cpan 1.64
- Helm 3.17.1
- Homebrew 4.4.23
- Miniconda 25.1.1
- Npm 10.8.2
- Pip 24.0
- Pip3 24.0
- Pipx 1.7.1
- RubyGems 3.4.20
- Vcpkg (build from commit 300239058e)
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
- Ant 1.10.14
- Gradle 8.13
- Lerna 8.2.1
- Maven 3.9.9

### Tools
- Ansible 2.18.3
- AzCopy 10.28.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.1.1
- Bazelisk 1.25.0
- Bicep 0.33.93
- Buildah 1.33.7
- CMake 3.31.6
- CodeQL Action Bundle 2.20.1
- Docker Amazon ECR Credential Helper 0.9.1
- Docker Compose v2 2.27.1
- Docker-Buildx 0.21.2
- Docker Client 26.1.3
- Docker Server 26.1.3
- Fastlane 2.226.0
- Git 2.48.1
- Git LFS 3.6.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- jq 1.7
- Kind 0.27.0
- Kubectl 1.32.2
- Kustomize 5.6.0
- MediaInfo 24.01
- Mercurial 6.7.2
- Minikube 1.34.0
- n 10.1.0
- Newman 6.2.1
- nvm 0.40.1
- OpenSSL 3.0.13-0ubuntu3.5
- Packer 1.12.0
- Parcel 2.13.3
- Podman 4.9.3
- Pulumi 3.154.0
- Skopeo 1.13.3
- Sphinx Open Source Search Server 2.2.11
- yamllint 1.35.1
- yq 4.45.1
- zstd 1.5.7
- Ninja 1.12.1

### CLI Tools
- AWS CLI 2.24.20
- AWS CLI Session Manager Plugin 1.2.707.0
- AWS SAM CLI 1.134.0
- Azure CLI 2.70.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.68.1
- Google Cloud CLI 513.0.0

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.442+6           | JAVA_HOME_8_X64      |
| 11.0.26+4           | JAVA_HOME_11_X64     |
| 17.0.14+7 (default) | JAVA_HOME_17_X64     |
| 21.0.6+7            | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 8.3.6
- Composer 2.8.6
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
- Cargo 1.85.0
- Rust 1.85.0
- Rustdoc 1.85.0
- Rustup 1.28.1

#### Packages
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 134.0.6998.35
- ChromeDriver 134.0.6998.35
- Chromium 134.0.6998.0
- Microsoft Edge 134.0.3124.51
- Microsoft Edge WebDriver 134.0.3124.51
- Selenium server 4.29.0
- Mozilla Firefox 136.0
- Geckodriver 0.36.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 8.0.112
- nbgv 3.7.115+d31f50f4d1

### Databases
- sqlite3 3.45.1

#### PostgreSQL
- PostgreSQL 16.8
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.41-0ubuntu0.24.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

### Cached Tools

#### Go
- 1.21.13
- 1.22.12
- 1.23.7

#### Node.js
- 18.20.7
- 20.18.3
- 22.14.0

#### Python
- 3.9.21
- 3.10.16
- 3.11.11
- 3.12.9
- 3.13.2

#### PyPy
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.2.7
- 3.3.7

### PowerShell Tools
- PowerShell 7.4.7

#### PowerShell Modules
- Az: 12.1.0
- Microsoft.Graph: 2.26.1
- Pester: 5.7.1
- PSScriptAnalyzer: 1.23.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.58  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.24.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                   |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 12.0                                                                                                                                                                                                                                      |
| Android SDK Build-tools    | 35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                   |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                    |
| Android SDK Platforms      | android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                    |
| CMake                      | 3.31.5                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                        |
| Google Repository          | 58                                                                                                                                                                                                                                        |
| NDK                        | 26.3.11579264<br>27.2.12479018 (default)<br>28.0.13004108                                                                                                                                                                                 |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/28.0.13004108 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/27.2.12479018 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Installed apt packages
| Name                   | Version                     |
| ---------------------- | --------------------------- |
| acl                    | 2.3.2-1build1.1             |
| aria2                  | 1.37.0+debian-1build3       |
| autoconf               | 2.71-3                      |
| automake               | 1:1.16.5-1.3ubuntu1         |
| binutils               | 2.42-4ubuntu2.4             |
| bison                  | 2:3.8.2+dfsg-1build2        |
| brotli                 | 1.1.0-2build2               |
| bzip2                  | 1.0.8-5.1build0.1           |
| coreutils              | 9.4-3ubuntu6                |
| curl                   | 8.5.0-2ubuntu10.6           |
| dbus                   | 1.14.10-4ubuntu4.1          |
| dnsutils               | 1:9.18.30-0ubuntu0.24.04.2  |
| dpkg                   | 1.22.6ubuntu6.1             |
| dpkg-dev               | 1.22.6ubuntu6.1             |
| fakeroot               | 1.33-1                      |
| file                   | 1:5.45-3build1              |
| findutils              | 4.9.0-5build1               |
| flex                   | 2.6.4-8.2build1             |
| fonts-noto-color-emoji | 2.047-0ubuntu0.24.04.1      |
| ftp                    | 20230507-2build3            |
| g++                    | 4:13.2.0-7ubuntu1           |
| gcc                    | 4:13.2.0-7ubuntu1           |
| gnupg2                 | 2.4.4-2ubuntu17             |
| haveged                | 1.9.14-1ubuntu2             |
| iproute2               | 6.1.0-1ubuntu6              |
| iputils-ping           | 3:20240117-1build1          |
| jq                     | 1.7.1-3build1               |
| libsqlite3-dev         | 3.45.1-1ubuntu2.1           |
| libssl-dev             | 3.0.13-0ubuntu3.5           |
| libtool                | 2.4.7-7build1               |
| libyaml-dev            | 0.2.5-1build1               |
| locales                | 2.39-0ubuntu8.4             |
| lz4                    | 1.9.4-1build1.1             |
| m4                     | 1.4.19-4build1              |
| make                   | 4.3-4.1build2               |
| mediainfo              | 24.01.1-1build2             |
| mercurial              | 6.7.2-1ubuntu2.2            |
| net-tools              | 2.10-0.1ubuntu4             |
| netcat                 | 1.226-1ubuntu2              |
| openssh-client         | 1:9.6p1-3ubuntu13.8         |
| p7zip-full             | 16.02+transitional.1        |
| p7zip-rar              | 16.02+transitional.1        |
| parallel               | 20231122+ds-1               |
| patchelf               | 0.18.0-1.1build1            |
| pigz                   | 2.8-1                       |
| pkg-config             | 1.8.1-2build1               |
| pollinate              | 4.33-3.1ubuntu1.1           |
| python-is-python3      | 3.11.4-1                    |
| rpm                    | 4.18.2+dfsg-2.1build2       |
| rsync                  | 3.2.7-1ubuntu1.2            |
| shellcheck             | 0.9.0-1                     |
| sphinxsearch           | 2.2.11-8build1              |
| sqlite3                | 3.45.1-1ubuntu2.1           |
| ssh                    | 1:9.6p1-3ubuntu13.8         |
| sshpass                | 1.09-1                      |
| sudo                   | 1.9.15p5-3ubuntu5           |
| swig                   | 4.2.0-2ubuntu1              |
| systemd-coredump       | 255.4-1ubuntu8.5            |
| tar                    | 1.35+dfsg-3build1           |
| telnet                 | 0.17+2.5-3ubuntu4           |
| texinfo                | 7.1-3build2                 |
| time                   | 1.9-0.2build1               |
| tk                     | 8.6.14build1                |
| tree                   | 2.1.1-2ubuntu3              |
| tzdata                 | 2024b-0ubuntu0.24.04.1      |
| unzip                  | 6.0-28ubuntu4.1             |
| upx                    | 4.2.2-3                     |
| wget                   | 1.21.4-1ubuntu4.1           |
| xvfb                   | 2:21.1.12-1ubuntu1.2        |
| xz-utils               | 5.6.1+really5.4.5-1build0.1 |
| zip                    | 3.0-13ubuntu0.2             |
| zsync                  | 0.6.2-5build1               |

