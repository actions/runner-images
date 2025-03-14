| Announcements |
|-|
| [[Ubuntu] Breaking change : PostgreSQL version 14.* for Ubuntu 22.04, PostgreSQL version 16.* for Ubuntu 24.04 will be updated to version 17.* from 2025-05-09](https://github.com/actions/runner-images/issues/11723) |
***
# Ubuntu 20.04
- OS Version: 20.04.6 LTS
- Kernel Version: 5.15.0-1079-azure
- Image Version: 20250309.1.0
- Systemd version: 245.4-4ubuntu3.24

## Installed Software

### Language and Runtime
- Bash 5.0.17(1)-release
- Clang: 10.0.0, 11.0.0, 12.0.0
- Clang-format: 10.0.0, 11.0.0, 12.0.0
- Clang-tidy: 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.3.2 (Eshell 13.2.2)
- Erlang rebar3 3.24.0
- GNU C++: 10.5.0
- GNU Fortran: 10.5.0
- Julia 1.11.3
- Kotlin 2.1.10-release-473
- Mono 6.12.0.200
- MSBuild 16.10.1.31701 (Mono 6.12.0.200)
- Node.js 18.20.7
- Perl 5.30.0
- Python 3.8.10
- Ruby 2.7.0p0
- Swift 6.0.3

### Package Management
- cpan 1.64
- Helm 3.17.1
- Homebrew 4.4.23
- Miniconda 25.1.1
- Npm 10.8.2
- NuGet 6.6.1.2
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.7.1
- RubyGems 3.1.2
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
- Ant 1.10.7
- Gradle 8.13
- Lerna 8.2.1
- Maven 3.9.9
- Sbt 1.10.10

### Tools
- Ansible 2.13.13
- apt-fast 1.10.0
- AzCopy 10.28.0 - available by `azcopy` and `azcopy10` aliases
- Bazel 8.1.1
- Bazelisk 1.25.0
- Bicep 0.33.93
- Buildah 1.22.3
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
- Haveged 1.9.1
- Heroku 10.2.0
- HHVM (HipHop VM) 4.172.1
- jq 1.6
- Kind 0.27.0
- Kubectl 1.32.2
- Kustomize 5.6.0
- Leiningen 2.11.2
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.34.0
- n 10.1.0
- Newman 6.2.1
- nvm 0.40.1
- OpenSSL 1.1.1f-1ubuntu2.24
- Packer 1.12.0
- Parcel 2.13.3
- PhantomJS 2.1.1 2.1.1
- Podman 3.4.2
- Pulumi 3.154.0
- R 4.4.3
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.11.1
- yamllint 1.35.1
- yq 4.45.1
- zstd 1.5.7
- Ninja 1.12.1

### CLI Tools
- Alibaba Cloud CLI 3.0.174
- AWS CLI 2.24.20
- AWS CLI Session Manager Plugin 1.2.707.0
- AWS SAM CLI 1.134.0
- Azure CLI 2.70.0
- Azure CLI (azure-devops) 1.0.1
- GitHub CLI 2.68.1
- Google Cloud CLI 513.0.0
- Netlify CLI 19.0.2
- OpenShift CLI 4.15.19
- ORAS CLI 1.2.2
- Vercel CLI 41.3.2

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.442+6           | JAVA_HOME_8_X64      |
| 11.0.26+4 (default) | JAVA_HOME_11_X64     |
| 17.0.14+7           | JAVA_HOME_17_X64     |
| 21.0.6+7            | JAVA_HOME_21_X64     |

### PHP Tools
- PHP: 7.4.33, 8.0.30, 8.1.31, 8.2.27, 8.3.17
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
- Bindgen 0.71.1
- Cargo audit 0.21.2
- Cargo clippy 0.1.85
- Cargo outdated 0.16.0
- Cbindgen 0.28.0
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
- .NET Core SDK: 6.0.428, 8.0.406, 9.0.200
- nbgv 3.7.115+d31f50f4d1

### Databases
- MongoDB 5.0.31
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.17
```
User: postgres
PostgreSQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```

#### MySQL
- MySQL 8.0.41-0ubuntu0.20.04.1
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
- 1.22.12
- 1.23.7

#### Node.js
- 18.20.7
- 20.18.3
- 22.14.0

#### Python
- 3.8.18
- 3.9.21
- 3.10.16
- 3.11.11
- 3.12.9
- 3.13.2

#### PyPy
- 2.7.18 [PyPy 7.3.19]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.0.7
- 3.1.6
- 3.2.7
- 3.3.7

### PowerShell Tools
- PowerShell 7.4.7

#### PowerShell Modules
- Az: 12.1.0
- MarkdownPS: 1.10
- Microsoft.Graph: 2.26.1
- Pester: 5.7.1
- PSScriptAnalyzer: 1.23.0

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                     |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 9.0                                                                                                                                                                                                                                                                                                         |
| Android SDK Build-tools    | 35.0.0 35.0.1<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                  |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                                                      |
| Android SDK Platforms      | android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                      |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                  |
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
| alpine:3.18          | sha256:de0eb0b3f2a47ba1eb89389859a9bd88b28e82f5826b6969ad604979713c2d4f  | 2025-02-14 |
| alpine:3.19          | sha256:e5d0aea7f7d2954678a9a6269ca2d06e06591881161961ea59e974dff3f12377  | 2025-02-14 |
| debian:10            | sha256:58ce6f1271ae1c8a2006ff7d3e54e9874d839f573d8009c20154ad0f2fb0a225  | 2024-06-13 |
| debian:11            | sha256:a6cec654bb08bdc6a563cd7507b62f57c916290e195142e79a0d41a70ebb26fa  | 2025-02-24 |
| debian:9             | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest | sha256:c5137fdd77377ea102a2622714df55459fe42e5867ba180bda07291aa7952d9b  | 2025-03-05 |
| node:18              | sha256:ba756f198b4b1e0114b53b23121c8ae27f7ae4d5d95ca4a0554b0649cc9c7dcf  | 2025-02-20 |
| node:18-alpine       | sha256:e0340f26173b41066d68e3fe9bfbdb6571ab3cad0a4272919a52e36f4ae56925  | 2025-02-20 |
| node:20              | sha256:bcf90f85634194bc51e92f8add1221c7fdeeff94b7f1ff360aeaa7498086d641  | 2025-02-10 |
| node:20-alpine       | sha256:053c1d99e608fe9fa0db6821edd84276277c0a663cd181f4a3e59ee20f5f07ea  | 2025-02-10 |
| node:22              | sha256:f6b9c31ace05502dd98ef777aaa20464362435dcc5e312b0e213121dcf7d8b95  | 2025-02-13 |
| node:22-alpine       | sha256:9bef0ef1e268f60627da9ba7d7605e8831d5b56ad07487d24d1aa386336d1944  | 2025-02-13 |
| ubuntu:20.04         | sha256:8e5c4f0285ecbb4ead070431d29b576a530d3166df73ec44affc1cd27555141b  | 2024-10-11 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.10                  |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.25                |
| dbus                   | 1.12.16-2ubuntu2.3                |
| dnsutils               | 1:9.18.30-0ubuntu0.20.04.2        |
| dpkg                   | 1.19.7ubuntu3.2                   |
| dpkg-dev               | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| findutils              | 4.7.0-1ubuntu1                    |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| g++                    | 4:9.3.0-1ubuntu2                  |
| gcc                    | 4:9.3.0-1ubuntu2                  |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3ubuntu1               |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libc6-dev              | 2.31-0ubuntu9.17                  |
| libcurl4               | 7.68.0-1ubuntu2.25                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6+deb10u1build0.20.04.1  |
| libgtk-3-0             | 3.24.20-0ubuntu1.2                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.10   |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.6                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9ubuntu0.1                  |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| libyaml-dev            | 0.2.2-1                           |
| locales                | 2.31-0ubuntu9.17                  |
| m4                     | 1.4.18-4                          |
| make                   | 4.2.1-1.2                         |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.12               |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pigz                   | 2.4-1                             |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.2             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8ubuntu0.9                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.6                 |
| ssh                    | 1:8.2p1-4ubuntu0.12               |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.5                 |
| swig                   | 4.0.1-5build1                     |
| systemd-coredump       | 245.4-4ubuntu3.24                 |
| tar                    | 1.30+dfsg-7ubuntu0.20.04.4        |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2024b-0ubuntu0.20.04.1            |
| unzip                  | 6.0-25ubuntu1.2                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2.1                 |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.19      |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |

