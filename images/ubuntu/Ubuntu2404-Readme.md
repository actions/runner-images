# Ubuntu 24.04 LTS
- OS Version: 24.04 LTS
- Kernel Version: 6.8.0-1007-azure
- Image Version: 20240430.1.0
- Systemd version: 255.4-1ubuntu8

## Installed Software

### Language and Runtime
- Bash 5.2.21(1)-release
- Clang: 16.0.6, 17.0.6, 18.1.3
- Clang-format: 16.0.6, 17.0.6, 18.1.3
- Clang-tidy: 16.0.6, 17.0.6, 18.1.3
- Dash 0.5.12-6ubuntu5
- GNU C++: 12.3.0, 13.2.0, 14.0.1
- GNU Fortran: 12.3.0, 13.2.0, 14.0.1
- Julia 1.10.3
- Node.js 20.12.2
- Perl 5.38.2
- Python 3.12.3
- Ruby 3.2.3

### Package Management
- cpan 1.64
- Helm 3.14.4
- Homebrew 4.2.20
- Miniconda 24.3.0
- Npm 10.5.0
- Pip 24.0
- Pip3 24.0
- Pipx 1.4.3
- RubyGems 3.4.20
- Vcpkg (build from commit c591ac646)
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
- Gradle 8.7
- Lerna 8.1.2
- Maven 3.8.8

### Tools
- Ansible 2.16.6
- apt-fast 1.10.0
- AzCopy 10.24.0 - available by `azcopy` and `azcopy10` aliases
- Bicep 0.26.170
- CMake 3.29.2
- CodeQL Action Bundle 2.17.1
- Docker Amazon ECR Credential Helper 0.7.1
- Docker Compose v2 2.27.0
- Docker-Buildx 0.14.0
- Docker Client 26.1.0
- Docker Server 26.1.0
- Git 2.43.2
- Git LFS 3.5.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- jq 1.7
- Kind 0.22.0
- Kubectl 1.30.0
- Kustomize 5.4.1
- MediaInfo 24.01
- Mercurial 6.7.2
- Minikube 1.33.0
- n 9.2.3
- Newman 6.1.2
- OpenSSL 3.0.13-0ubuntu3
- Parcel 2.12.0
- Pulumi 3.114.0
- Sphinx Open Source Search Server 2.2.11
- yamllint 1.35.1
- yq 4.43.1
- zstd 1.5.6

### CLI Tools
- AWS CLI 2.15.42
- AWS CLI Session Manager Plugin 1.2.553.0
- AWS SAM CLI 1.116.0
- Azure CLI 2.60.0
- Azure CLI (azure-devops) 1.0.0
- GitHub CLI 2.49.0

### PHP Tools
- PHP: 8.3.6
- Composer 2.7.4
- PHPUnit 8.5.38
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.10.3.0
- GHC 9.8.2
- GHCup 0.1.22.0
- Stack 2.15.5

### Rust Tools
- Cargo 1.77.2
- Rust 1.77.2
- Rustdoc 1.77.2
- Rustup 1.27.0

#### Packages
- Rustfmt 1.7.0

### Browsers and Drivers
- Google Chrome 124.0.6367.118
- ChromeDriver 124.0.6367.91
- Chromium 124.0.6367.0
- Selenium server 4.20.0

#### Environment variables
| Name              | Value                                 |
| ----------------- | ------------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chromedriver-linux64 |
| EDGEWEBDRIVER     |                                       |
| GECKOWEBDRIVER    |                                       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar   |

### .NET Tools
- .NET Core SDK: 8.0.104
- nbgv 3.6.133+2d32d93cb1

### Databases
- sqlite3 3.45.1

#### PostgreSQL
- PostgreSQL 16.2
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.36-2ubuntu3
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

### PowerShell Tools
- PowerShell 7.4.2

#### PowerShell Modules
- Az: 11.5.0
- Microsoft.Graph: 2.18.0
- Pester: 5.5.0
- PSScriptAnalyzer: 1.22.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.58  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.24.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                         |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 12.0                                                                                                                            |
| Android SDK Build-tools    | 34.0.0                                                                                                                          |
| Android SDK Platforms      | android-34-ext8 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                          |
| Google Play services       | 49                                                                                                                              |
| Google Repository          | 58                                                                                                                              |
| NDK                        | 24.0.8215888<br>25.2.9519653<br>26.3.11579264 (default)                                                                         |

#### Environment variables
| Name                    | Value                                        |
| ----------------------- | -------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                   |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/26.3.11579264 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                   |

### Installed apt packages
| Name                   | Version               |
| ---------------------- | --------------------- |
| acl                    | 2.3.2-1build1         |
| aria2                  | 1.37.0+debian-1build3 |
| autoconf               | 2.71-3                |
| automake               | 1:1.16.5-1.3ubuntu1   |
| binutils               | 2.42-4ubuntu2         |
| bison                  | 2:3.8.2+dfsg-1build2  |
| brotli                 | 1.1.0-2build2         |
| bzip2                  | 1.0.8-5.1             |
| coreutils              | 9.4-3ubuntu6          |
| curl                   | 8.5.0-2ubuntu10.1     |
| dbus                   | 1.14.10-4ubuntu4      |
| dnsutils               | 1:9.18.24-0ubuntu5    |
| dpkg                   | 1.22.6ubuntu6         |
| dpkg-dev               | 1.22.6ubuntu6         |
| fakeroot               | 1.33-1                |
| file                   | 1:5.45-3build1        |
| findutils              | 4.9.0-5build1         |
| flex                   | 2.6.4-8.2build1       |
| fonts-noto-color-emoji | 2.042-1               |
| ftp                    | 20230507-2build3      |
| g++                    | 4:13.2.0-7ubuntu1     |
| gcc                    | 4:13.2.0-7ubuntu1     |
| gnupg2                 | 2.4.4-2ubuntu17       |
| haveged                | 1.9.14-1ubuntu2       |
| iproute2               | 6.1.0-1ubuntu6        |
| iputils-ping           | 3:20240117-1build1    |
| jq                     | 1.7.1-3build1         |
| libssl-dev             | 3.0.13-0ubuntu3       |
| libtool                | 2.4.7-7build1         |
| locales                | 2.39-0ubuntu8.1       |
| lz4                    | 1.9.4-1build1         |
| m4                     | 1.4.19-4build1        |
| make                   | 4.3-4.1build2         |
| mediainfo              | 24.01.1-1build2       |
| mercurial              | 6.7.2-1ubuntu2        |
| net-tools              | 2.10-0.1ubuntu4       |
| netcat                 | 1.226-1ubuntu2        |
| openssh-client         | 1:9.6p1-3ubuntu13     |
| p7zip-full             | 16.02+transitional.1  |
| p7zip-rar              | 16.02+transitional.1  |
| parallel               | 20231122+ds-1         |
| patchelf               | 0.18.0-1.1build1      |
| pigz                   | 2.8-1                 |
| pkg-config             | 1.8.1-2build1         |
| pollinate              | 4.33-3.1ubuntu1       |
| python-is-python3      | 3.11.4-1              |
| rpm                    | 4.18.2+dfsg-2.1build2 |
| rsync                  | 3.2.7-1ubuntu1        |
| shellcheck             | 0.9.0-1               |
| sphinxsearch           | 2.2.11-8build1        |
| sqlite3                | 3.45.1-1ubuntu2       |
| ssh                    | 1:9.6p1-3ubuntu13     |
| sshpass                | 1.09-1                |
| sudo                   | 1.9.15p5-3ubuntu5     |
| swig                   | 4.2.0-2ubuntu1        |
| tar                    | 1.35+dfsg-3build1     |
| telnet                 | 0.17+2.5-3ubuntu4     |
| texinfo                | 7.1-3build2           |
| time                   | 1.9-0.2build1         |
| tk                     | 8.6.14build1          |
| tzdata                 | 2024a-2ubuntu1        |
| unzip                  | 6.0-28ubuntu4         |
| upx                    | 4.2.2-3               |
| wget                   | 1.21.4-1ubuntu4       |
| xvfb                   | 2:21.1.12-1ubuntu1    |
| xz-utils               | 5.6.1+really5.4.5-1   |
| zip                    | 3.0-13build1          |
| zsync                  | 0.6.2-5build1         |
