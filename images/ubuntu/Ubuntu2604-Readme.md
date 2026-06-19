| Announcements |
|-|
| [Go versions <=1.23  will be removed from tool-cache](https://github.com/actions/runner-images/issues/14237) |
| [[Ubuntu] Ubuntu 26.04 and Ubuntu 26.04 Arm is now available as a public preview](https://github.com/actions/runner-images/issues/14226) |
| [[All OS] PowerShell will be updated from 7.4 to 7.6 LTS on all runner images](https://github.com/actions/runner-images/issues/14150) |
| [[ARM] Arm64 runner images now maintained by GitHub](https://github.com/actions/runner-images/issues/14100) |
***
# Ubuntu 26.04 LTS
- OS Version: 26.04 LTS
- Kernel Version: 7.0.0-1004-azure
- Image Version: 20260615.44.1
- Systemd version: 259.5-0ubuntu3

## Installed Software

### Language and Runtime
- Bash 5.3.9(1)-release
- Clang: 20.1.8, 21.1.8, 22.1.2
- Clang-format: 20.1.8, 21.1.8, 22.1.2
- Clang-tidy: 20.1.8, 21.1.8, 22.1.2
- Dash 0.5.12-12ubuntu3
- GNU C++: 13.4.0, 14.3.0, 15.2.0
- GNU Fortran: 13.4.0, 14.3.0, 15.2.0
- Kotlin 2.4.0-release-281
- Node.js 24.16.0
- Perl 5.40.1
- Python 3.14.4
- Ruby 3.3.8

### Package Management
- cpan 1.64
- Helm 4.2.1
- Homebrew 6.0.2
- Npm 11.13.0
- Pip 25.1.1
- Pip3 25.1.1
- Pipx 1.14.0
- RubyGems 3.6.7
- Vcpkg (build from commit a7acc4f979)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   |                        |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

#### Homebrew note
```
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
```

### Project Management
- Ant 1.10.15
- Gradle 9.5.1
- Maven 3.9.15

### Tools
- Ansible 2.21.0
- AzCopy 10.32.4 - available by `azcopy` and `azcopy10` aliases
- Bazel 9.1.1
- Bazelisk 1.28.1
- Bicep 0.44.1
- Buildah 1.42.1
- CMake 4.3.3
- CodeQL Action Bundle 2.25.6
- Docker Amazon ECR Credential Helper 0.12.0
- Docker Compose 5.1.3
- Docker-Buildx 0.34.1
- Docker Client 29.4.2
- Docker Server 29.4.2
- Git 2.53.0
- Git LFS 3.7.1
- Git-ftp 1.6.0
- jq 1.8.1
- Kind 0.32.0
- Kubectl 1.36.2
- Kustomize 5.8.1
- Minikube 1.38.1
- n 10.2.0
- nvm 0.40.5
- OpenSSL 3.5.5-1ubuntu3.2
- Packer 1.15.4
- Podman 5.7.0
- Skopeo 1.21.0-dev
- yamllint 1.38.0
- yq 4.53.3
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- AWS CLI 2.35.5
- AWS CLI Session Manager Plugin 1.2.814.0
- AWS SAM CLI 1.162.1
- Azure CLI 2.87.0
- Azure CLI (azure-devops) 1.0.4
- GitHub CLI 2.94.0
- Google Cloud CLI 572.0.0

### Java
| Version            | Environment Variable |
| ------------------ | -------------------- |
| 11.0.31+11         | JAVA_HOME_11_X64     |
| 17.0.19+10         | JAVA_HOME_17_X64     |
| 21.0.11+10         | JAVA_HOME_21_X64     |
| 25.0.3+9 (default) | JAVA_HOME_25_X64     |

### PHP Tools
- PHP: 8.5.4
- Composer 2.10.1
- PHPUnit 8.5.52
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Haskell Tools
- Cabal 3.16.1.0
- GHC 9.14.1
- GHCup 0.2.6.1
- Stack 3.11.1

### Rust Tools
- Cargo 1.96.0
- Rust 1.96.0
- Rustdoc 1.96.0
- Rustup 1.29.0

#### Packages
- Rustfmt 1.9.0

### Browsers and Drivers
- Google Chrome 149.0.7827.114
- ChromeDriver 149.0.7827.115
- Chromium 149.0.7827.0
- Microsoft Edge 149.0.4022.69
- Microsoft Edge WebDriver 149.0.4022.69
- Selenium server 4.44.0
- Mozilla Firefox 151.0.4
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
- nbgv 3.9.50+6feeb89450

### Databases
- sqlite3 3.46.1

#### PostgreSQL
- PostgreSQL 18.4
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.4.9-0ubuntu0.26.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

### PowerShell Tools
- PowerShell 7.6.2

#### PowerShell Modules
- Az: 15.6.1
- Microsoft.Graph: 2.37.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.25.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.66  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.28.3  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 20.0                                                                                                                                                                                                                                                                                                                                          |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                                            |
| Android SDK Platform-Tools | 37.0.0                                                                                                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                        |
| CMake                      | 3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                                               |
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
| Name                   | Version                      |
| ---------------------- | ---------------------------- |
| 7zip                   | 26.00+dfsg-1                 |
| 7zip-rar               | 26.00+ds-1                   |
| acl                    | 2.3.2-2                      |
| aria2                  | 1.37.0+debian-4              |
| autoconf               | 2.72-3.1ubuntu2              |
| automake               | 1:1.18.1-3build1             |
| bind9-dnsutils         | 1:9.20.18-1ubuntu2.1         |
| binutils               | 2.46-3ubuntu2                |
| bison                  | 2:3.8.2+dfsg-1build4         |
| brotli                 | 1.2.0-3build1                |
| bzip2                  | 1.0.8-6build2                |
| coreutils              | 9.5-1ubuntu2+0.0.0\~ubuntu25 |
| curl                   | 8.18.0-1ubuntu2.1            |
| dbus                   | 1.16.2-2ubuntu4              |
| dpkg                   | 1.23.7ubuntu1                |
| dpkg-dev               | 1.23.7ubuntu1                |
| fakeroot               | 1.37.2-1                     |
| file                   | 1:5.46-5build2               |
| findutils              | 4.10.0-3build2               |
| flex                   | 2.6.4-8.2build2              |
| fonts-noto-color-emoji | 2.051-1build1                |
| ftp                    | 20260211-1                   |
| g++                    | 4:15.2.0-5ubuntu1            |
| gcc                    | 4:15.2.0-5ubuntu1            |
| gnupg2                 | 2.4.8-4ubuntu3               |
| iproute2               | 6.19.0-1ubuntu1              |
| iputils-ping           | 3:20250605-1ubuntu1          |
| jq                     | 1.8.1-4ubuntu2               |
| libnss3-tools          | 2:3.120-1ubuntu2             |
| libsqlite3-dev         | 3.46.1-9                     |
| libssl-dev             | 3.5.5-1ubuntu3.2             |
| libtool                | 2.5.4-9                      |
| libyaml-dev            | 0.2.5-2build3                |
| locales                | 2.43-2ubuntu2                |
| lz4                    | 1.10.0-8                     |
| m4                     | 1.4.21-1                     |
| make                   | 4.4.1-3                      |
| net-tools              | 2.10-2ubuntu1                |
| netcat                 | 1.234-1                      |
| openssh-client         | 1:10.2p1-2ubuntu3.2          |
| parallel               | 20240222+ds-3                |
| patchelf               | 0.18.0-1.4build1             |
| pigz                   | 2.8-1build1                  |
| pkg-config             | 2.5.1-4                      |
| pollinate              | 4.33-4ubuntu6                |
| python-is-python3      | 3.13.3-1+build1              |
| rpm                    | 6.0.1-1build1                |
| rsync                  | 3.4.1+ds1-7ubuntu0.3         |
| shellcheck             | 0.11.0-2                     |
| sqlite3                | 3.46.1-9                     |
| ssh                    | 1:10.2p1-2ubuntu3.2          |
| sshpass                | 1.10-0.1build1               |
| sudo                   | 1.9.17p2-1ubuntu3            |
| swig                   | 4.4.0-1                      |
| systemd-coredump       | 259.5-0ubuntu3               |
| tar                    | 1.35+dfsg-4                  |
| telnet                 | 0.17+2.7-2ubuntu1.1          |
| texinfo                | 7.2-5ubuntu2                 |
| time                   | 1.9-0.4                      |
| tk                     | 8.6.16build1                 |
| tree                   | 2.3.1-1                      |
| tzdata                 | 2026a-3ubuntu1               |
| unzip                  | 6.0-29ubuntu1                |
| upx                    | 4.2.4-1.1build1              |
| wget                   | 1.25.0-2ubuntu4              |
| xvfb                   | 2:21.1.22-1ubuntu1           |
| xz-utils               | 5.8.3-1                      |
| zip                    | 3.0-15ubuntu3                |
| zsync                  | 0.6.2-9                      |

