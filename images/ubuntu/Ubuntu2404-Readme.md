| Announcements |
|-|
| [[Ubuntu] `man-db` automatic updates will be disabled on November 10th](https://github.com/actions/runner-images/issues/13213) |
| [[Ubuntu & Windows] Four tools scheduled for deprecation on November 3, 2025](https://github.com/actions/runner-images/issues/12898) |
***
# Ubuntu 24.04
- OS Version: 24.04.3 LTS
- Kernel Version: 6.11.0-1018-azure
- Image Version: 20251112.124.1
- Systemd version: 255.4-1ubuntu8.11

## Installed Software

### Language and Runtime
- Bash 5.2.21(1)-release
- Clang: 16.0.6, 17.0.6, 18.1.3
- Clang-format: 16.0.6, 17.0.6, 18.1.3
- Clang-tidy: 16.0.6, 17.0.6, 18.1.3
- Dash 0.5.12-6ubuntu5
- GNU C++: 12.4.0, 13.3.0, 14.2.0
- GNU Fortran: 12.4.0, 13.3.0, 14.2.0
- Julia 1.12.1
- Kotlin 2.2.21-release-469
- Node.js 20.19.5
- Perl 5.38.2
- Python 3.12.3
- Ruby 3.2.3
- Swift 6.2.1

### Package Management
- cpan 1.64
- Helm 3.19.1
- Homebrew 5.0.0
- Miniconda 25.9.1
- Npm 10.8.2
- Pip 24.0
- Pip3 24.0
- Pipx 1.8.0
- RubyGems 3.4.20
- Vcpkg (build from commit e93bf57963)
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
- Gradle 9.2.0
- Lerna 9.0.0
- Maven 3.9.11

### Tools
- Ansible 2.19.4
- AzCopy 10.31.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.4.2
- Bazelisk 1.26.0
- Bicep 0.38.33
- Buildah 1.33.7
- CMake 3.31.6
- CodeQL Action Bundle 2.23.3
- Docker Amazon ECR Credential Helper 0.11.0
- Docker Compose v2 2.38.2
- Docker-Buildx 0.29.1
- Docker Client 28.0.4
- Docker Server 28.0.4
- Fastlane 2.228.0
- Git 2.51.2
- Git LFS 3.7.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- jq 1.7
- Kind 0.30.0
- Kubectl 1.34.2
- Kustomize 5.8.0
- MediaInfo 24.01
- Mercurial 6.7.2
- Minikube 1.37.0
- n 10.2.0
- Newman 6.2.1
- nvm 0.40.3
- OpenSSL 3.0.13-0ubuntu3.6
- Packer 1.14.2
- Parcel 2.16.1
- Podman 4.9.3
- Pulumi 3.206.0
- Skopeo 1.13.3
- Sphinx Open Source Search Server 2.2.11
- yamllint 1.37.1
- yq 4.48.1
- zstd 1.5.7
- Ninja 1.13.1

### CLI Tools
- AWS CLI 2.31.34
- AWS CLI Session Manager Plugin 1.2.707.0
- AWS SAM CLI 1.146.0
- Azure CLI 2.79.0
- Azure CLI (azure-devops) 1.0.2
- GitHub CLI 2.83.0
- Google Cloud CLI 547.0.0

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.472+8            | JAVA_HOME_8_X64      |
| 11.0.29+7            | JAVA_HOME_11_X64     |
| 17.0.17+10 (default) | JAVA_HOME_17_X64     |
| 21.0.9+10            | JAVA_HOME_21_X64     |
| 25.0.1+8             | JAVA_HOME_25_X64     |

### PHP Tools
- PHP: 8.3.6
- Composer 2.8.12
- PHPUnit 8.5.48
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.16.0.0
- GHC 9.12.2
- GHCup 0.1.50.2
- Stack 3.7.1

### Rust Tools
- Cargo 1.91.1
- Rust 1.91.1
- Rustdoc 1.91.1
- Rustup 1.28.2

#### Packages
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 142.0.7444.162
- ChromeDriver 142.0.7444.162
- Chromium 142.0.7444.0
- Microsoft Edge 142.0.3595.65
- Microsoft Edge WebDriver 142.0.3595.65
- Selenium server 4.38.0
- Mozilla Firefox 145.0
- Geckodriver 0.36.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver         |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 8.0.122, 8.0.206, 8.0.319, 8.0.416, 9.0.112, 9.0.205, 9.0.307, 10.0.100
- nbgv 3.9.50+6feeb89450

### Databases
- sqlite3 3.45.1

#### PostgreSQL
- PostgreSQL 16.10
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.43-0ubuntu0.24.04.2
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

### Cached Tools

#### Go
- 1.22.12
- 1.23.12
- 1.24.10
- 1.25.4

#### Node.js
- 20.19.5
- 22.21.1
- 24.11.1

#### Python
- 3.9.25
- 3.10.19
- 3.11.14
- 3.12.12
- 3.13.9
- 3.14.0

#### PyPy
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
- Microsoft.Graph: 2.32.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.58  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.24.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 12.0                                                                                                                                                                                                                                                                                                                  |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                              |
| Android SDK Platform-Tools | 36.0.0                                                                                                                                                                                                                                                                                                                |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                |
| CMake                      | 3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                       |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                    |
| NDK                        | 26.3.11579264<br>27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                            |

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
| Name                   | Version                      |
| ---------------------- | ---------------------------- |
| acl                    | 2.3.2-1build1.1              |
| aria2                  | 1.37.0+debian-1build3        |
| autoconf               | 2.71-3                       |
| automake               | 1:1.16.5-1.3ubuntu1          |
| binutils               | 2.42-4ubuntu2.6              |
| bison                  | 2:3.8.2+dfsg-1build2         |
| brotli                 | 1.1.0-2build2                |
| bzip2                  | 1.0.8-5.1build0.1            |
| coreutils              | 9.4-3ubuntu6.1               |
| curl                   | 8.5.0-2ubuntu10.6            |
| dbus                   | 1.14.10-4ubuntu4.1           |
| dnsutils               | 1:9.18.39-0ubuntu0.24.04.2   |
| dpkg                   | 1.22.6ubuntu6.5              |
| dpkg-dev               | 1.22.6ubuntu6.5              |
| fakeroot               | 1.33-1                       |
| file                   | 1:5.45-3build1               |
| findutils              | 4.9.0-5build1                |
| flex                   | 2.6.4-8.2build1              |
| fonts-noto-color-emoji | 2.047-0ubuntu0.24.04.1       |
| ftp                    | 20230507-2build3             |
| g++                    | 4:13.2.0-7ubuntu1            |
| gcc                    | 4:13.2.0-7ubuntu1            |
| gnupg2                 | 2.4.4-2ubuntu17.3            |
| haveged                | 1.9.14-1ubuntu2              |
| iproute2               | 6.1.0-1ubuntu6.2             |
| iputils-ping           | 3:20240117-1ubuntu0.1        |
| jq                     | 1.7.1-3ubuntu0.24.04.1       |
| libnss3-tools          | 2:3.98-1build1               |
| libsqlite3-dev         | 3.45.1-1ubuntu2.5            |
| libssl-dev             | 3.0.13-0ubuntu3.6            |
| libtool                | 2.4.7-7build1                |
| libyaml-dev            | 0.2.5-1build1                |
| locales                | 2.39-0ubuntu8.6              |
| lz4                    | 1.9.4-1build1.1              |
| m4                     | 1.4.19-4build1               |
| make                   | 4.3-4.1build2                |
| mediainfo              | 24.01.1-1build2              |
| mercurial              | 6.7.2-1ubuntu2.2             |
| net-tools              | 2.10-0.1ubuntu4.4            |
| netcat                 | 1.226-1ubuntu2               |
| openssh-client         | 1:9.6p1-3ubuntu13.14         |
| p7zip-full             | 16.02+transitional.1         |
| p7zip-rar              | 16.02+transitional.1         |
| parallel               | 20231122+ds-1                |
| patchelf               | 0.18.0-1.1build1             |
| pigz                   | 2.8-1                        |
| pkg-config             | 1.8.1-2build1                |
| pollinate              | 4.33-3.1ubuntu1.1            |
| python-is-python3      | 3.11.4-1                     |
| rpm                    | 4.18.2+dfsg-2.1build2        |
| rsync                  | 3.2.7-1ubuntu1.2             |
| shellcheck             | 0.9.0-1                      |
| sphinxsearch           | 2.2.11-8build1               |
| sqlite3                | 3.45.1-1ubuntu2.5            |
| ssh                    | 1:9.6p1-3ubuntu13.14         |
| sshpass                | 1.09-1                       |
| sudo                   | 1.9.15p5-3ubuntu5.24.04.1    |
| swig                   | 4.2.0-2ubuntu1               |
| systemd-coredump       | 255.4-1ubuntu8.11            |
| tar                    | 1.35+dfsg-3build1            |
| telnet                 | 0.17+2.5-3ubuntu4            |
| texinfo                | 7.1-3build2                  |
| time                   | 1.9-0.2build1                |
| tk                     | 8.6.14build1                 |
| tree                   | 2.1.1-2ubuntu3               |
| tzdata                 | 2025b-0ubuntu0.24.04.1       |
| unzip                  | 6.0-28ubuntu4.1              |
| upx                    | 4.2.2-3                      |
| wget                   | 1.21.4-1ubuntu4.1            |
| xvfb                   | 2:21.1.12-1ubuntu1.5         |
| xz-utils               | 5.6.1+really5.4.5-1ubuntu0.2 |
| zip                    | 3.0-13ubuntu0.2              |
| zsync                  | 0.6.2-5build1                |

