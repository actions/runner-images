# Ubuntu 24.04
- OS Version: 24.04.4 LTS
- Kernel Version: 6.17.0-1015-azure
- Image Version: 20260531.15.1
- Systemd version: 255.4-1ubuntu8.15

## Installed Software

### Language and Runtime
- Bash 5.2.21(1)-release
- Clang: 16.0.6, 17.0.6, 18.1.3
- Clang-format: 16.0.6, 17.0.6, 18.1.3
- Clang-tidy: 16.0.6, 17.0.6, 18.1.3
- Dash 0.5.12-6ubuntu5
- GNU C++: 12.4.0, 13.3.0, 14.2.0
- GNU Fortran: 12.4.0, 13.3.0, 14.2.0
- Kotlin 2.3.21-release-298
- Node.js 22.22.3
- Perl 5.38.2
- Python 3.12.3
- Ruby 3.2.3
- Swift 6.3.1

### Package Management
- cpan 1.64
- Helm 3.21.0
- Homebrew 5.1.14
- Npm 10.9.8
- Pip 24.0
- Pip3 24.0
- Pipx 1.13.0
- RubyGems 3.4.20
- Vcpkg (build from commit f9ffbaa46a)
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
- Ant 1.10.14
- Gradle 9.5.1
- Lerna 9.0.7
- Maven 3.9.12

### Tools
- Ansible 2.20.6
- AzCopy 10.32.4 - available by `azcopy` and `azcopy10` aliases
- Bazel 9.1.0
- Bazelisk 1.28.1
- Buildah 1.33.7
- CMake 3.31.6
- Docker Amazon ECR Credential Helper 0.12.0
- Docker Compose 2.38.2
- Docker-Buildx 0.34.1
- Docker Client 28.0.4
- Docker Server 28.0.4
- Fastlane 2.235.0
- Git 2.54.0
- Git LFS 3.7.1
- Git-ftp 1.6.0
- Haveged 1.9.14
- jq 1.7
- Kind 0.31.0
- Kubectl 1.36.1
- Kustomize 5.8.1
- MediaInfo 24.01
- Mercurial 6.7.2
- Minikube 1.38.1
- n 10.2.0
- Newman 6.2.2
- nvm 0.40.4
- OpenSSL 3.0.13-0ubuntu3.9
- Packer 1.15.3
- Parcel 2.16.4
- Podman 4.9.3
- Pulumi 3.244.0
- Skopeo 1.13.3
- Sphinx Open Source Search Server 2.2.11
- yamllint 1.38.0
- yq 4.53.2
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- AWS CLI 2.34.57
- AWS CLI Session Manager Plugin 1.2.814.0
- AWS SAM CLI 1.161.1
- Azure CLI 2.86.0
- Azure CLI (azure-devops) 1.0.4
- GitHub CLI 2.93.0
- Google Cloud CLI 570.0.0

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.492+9            | JAVA_HOME_8_X64      |
| 11.0.31+11           | JAVA_HOME_11_X64     |
| 17.0.19+10 (default) | JAVA_HOME_17_X64     |
| 21.0.11+10           | JAVA_HOME_21_X64     |
| 25.0.3+9             | JAVA_HOME_25_X64     |

### PHP Tools
- PHP: 8.3.6
- Composer 2.10.0
- PHPUnit 8.5.52
```
Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```

### Rust Tools
- Cargo 1.96.0
- Rust 1.96.0
- Rustdoc 1.96.0
- Rustup 1.29.0

#### Packages
- Rustfmt 1.9.0

### Browsers and Drivers
- Selenium server 4.44.0
- Mozilla Firefox 151.0.2
- Geckodriver 0.36.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   |                                     |
| EDGEWEBDRIVER     |                                     |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Tools
- .NET Core SDK: 8.0.127, 8.0.206, 8.0.319, 8.0.421, 9.0.117, 9.0.205, 9.0.314, 10.0.108, 10.0.204, 10.0.300
- nbgv 3.9.50+6feeb89450

### Databases
- sqlite3 3.45.1

#### MySQL
- MySQL 8.0.45-0ubuntu0.24.04.1
```
User: root
Password: root
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```

### PowerShell Tools
- PowerShell 7.4.16

#### PowerShell Modules
- Az: 14.6.0
- Microsoft.Graph: 2.37.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.25.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.58  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.24.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Installed apt packages
| Name                   | Version                      |
| ---------------------- | ---------------------------- |
| acl                    | 2.3.2-1build1.1              |
| aria2                  | 1.37.0+debian-1build3        |
| autoconf               | 2.71-3                       |
| automake               | 1:1.16.5-1.3ubuntu1          |
| binutils               | 2.42-4ubuntu2.10             |
| bison                  | 2:3.8.2+dfsg-1build2         |
| brotli                 | 1.1.0-2build2                |
| bzip2                  | 1.0.8-5.1build0.1            |
| coreutils              | 9.4-3ubuntu6.2               |
| curl                   | 8.5.0-2ubuntu10.9            |
| dbus                   | 1.14.10-4ubuntu4.1           |
| dnsutils               | 1:9.18.39-0ubuntu0.24.04.5   |
| dpkg                   | 1.22.6ubuntu6.6              |
| dpkg-dev               | 1.22.6ubuntu6.6              |
| fakeroot               | 1.33-1                       |
| file                   | 1:5.45-3build1               |
| findutils              | 4.9.0-5build1                |
| flex                   | 2.6.4-8.2build1              |
| fonts-noto-color-emoji | 2.047-0ubuntu0.24.04.1       |
| ftp                    | 20230507-2build3             |
| g++                    | 4:13.2.0-7ubuntu1            |
| gcc                    | 4:13.2.0-7ubuntu1            |
| gnupg2                 | 2.4.4-2ubuntu17.4            |
| haveged                | 1.9.14-1ubuntu2              |
| iproute2               | 6.1.0-1ubuntu6.3             |
| iputils-ping           | 3:20240117-1ubuntu0.1        |
| jq                     | 1.7.1-3ubuntu0.24.04.2       |
| libgbm-dev             | 25.2.8-0ubuntu0.24.04.1      |
| libnss3-tools          | 2:3.98-1ubuntu0.1            |
| libsqlite3-dev         | 3.45.1-1ubuntu2.5            |
| libssl-dev             | 3.0.13-0ubuntu3.9            |
| libtool                | 2.4.7-7build1                |
| libyaml-dev            | 0.2.5-1build1                |
| locales                | 2.39-0ubuntu8.7              |
| lz4                    | 1.9.4-1build1.1              |
| m4                     | 1.4.19-4build1               |
| make                   | 4.3-4.1build2                |
| mediainfo              | 24.01.1-1build2              |
| mercurial              | 6.7.2-1ubuntu2.2             |
| net-tools              | 2.10-0.1ubuntu4.4            |
| netcat                 | 1.226-1ubuntu2               |
| openssh-client         | 1:9.6p1-3ubuntu13.16         |
| p7zip-full             | 16.02+transitional.1         |
| p7zip-rar              | 16.02+transitional.1         |
| parallel               | 20231122+ds-1                |
| patchelf               | 0.18.0-1.1build1             |
| pigz                   | 2.8-1                        |
| pkg-config             | 1.8.1-2build1                |
| pollinate              | 4.33-3.1ubuntu1.3            |
| python-is-python3      | 3.11.4-1                     |
| rpm                    | 4.18.2+dfsg-2.1build2        |
| rsync                  | 3.2.7-1ubuntu1.4             |
| shellcheck             | 0.9.0-1                      |
| sphinxsearch           | 2.2.11-8build1               |
| sqlite3                | 3.45.1-1ubuntu2.5            |
| ssh                    | 1:9.6p1-3ubuntu13.16         |
| sshpass                | 1.09-1                       |
| sudo                   | 1.9.15p5-3ubuntu5.24.04.2    |
| swig                   | 4.2.0-2ubuntu1               |
| systemd-coredump       | 255.4-1ubuntu8.15            |
| tar                    | 1.35+dfsg-3build1            |
| telnet                 | 0.17+2.5-3ubuntu4.1          |
| texinfo                | 7.1-3build2                  |
| time                   | 1.9-0.2build1                |
| tk                     | 8.6.14build1                 |
| tree                   | 2.1.1-2ubuntu3.24.04.2       |
| tzdata                 | 2026a-0ubuntu0.24.04.1       |
| unzip                  | 6.0-28ubuntu4.1              |
| upx                    | 4.2.2-3                      |
| wget                   | 1.21.4-1ubuntu4.1            |
| xvfb                   | 2:21.1.12-1ubuntu1.5         |
| xz-utils               | 5.6.1+really5.4.5-1ubuntu0.2 |
| zip                    | 3.0-13ubuntu0.2              |
| zsync                  | 0.6.2-5build1                |
