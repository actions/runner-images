| Announcements |
|-|
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 2022/08/08 and will be fully unsupported by 2023/04/01](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 18.04
- OS Version: 18.04.6 LTS
- Kernel Version: 5.4.0-1098-azure
- Image Version: 20221220.1

## Installed Software
### Language and Runtime
- Bash 4.4.20(1)-release
- Clang 9.0.0
- Clang-format 9.0.0
- Clang-tidy 9.0.0
- Dash 0.5.8-2.10
- Erlang 25.0.4 (Eshell 13.0.4)
- Erlang rebar3 3.20.0
- GNU C++ 7.5.0, 9.4.0, 10.3.0
- GNU Fortran 7.5.0, 9.4.0, 10.3.0
- Julia 1.8.3
- Kotlin 1.7.22-release-288
- Mono 6.12.0.182
- MSBuild 16.10.1.31701 (Mono 6.12.0.182)
- Node 16.19.0
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.7.2

### Package Management
- cpan 1.64
- Helm 3.10.3
- Homebrew 3.6.15
- Miniconda 4.12.0
- Npm 8.19.3
- NuGet 6.3.1.1
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 1.0.0
- RubyGems 2.7.6
- Vcpkg (build from commit cc288af76)
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
- Ant 1.10.5
- Gradle 7.6
- Maven 3.8.6
- Sbt 1.8.0

### Tools
- Ansible 2.11.12
- apt-fast 1.9.12
- AzCopy 10.16.2 - available by `azcopy` and `azcopy10` aliases
- Bazel 6.0.0
- Bazelisk 1.13.2
- Bicep 0.13.1
- Buildah 1.22.3
- CMake 3.25.1
- CodeQL Action Bundle 2.11.6
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.14.1+azure-1
- Docker-Buildx 0.9.1
- Docker-Moby Client 20.10.22+azure-1
- Docker-Moby Server 20.10.22+azure-1
- Git 2.39.0
- Git LFS 3.2.0
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.67.1
- HHVM (HipHop VM) 4.164.0
- jq 1.5
- Kind 0.17.0
- Kubectl 1.26.0
- Kustomize 4.5.7
- Leiningen 2.10.0
- MediaInfo 17.12
- Mercurial 4.5.3
- Minikube 1.28.0
- n 9.0.1
- Newman 5.3.2
- nvm 0.39.2
- OpenSSL 1.1.1-1ubuntu2.1~18.04.20
- Packer 1.8.5
- Parcel 2.8.2
- PhantomJS 2.1.1
- Podman 3.4.2
- Pulumi 3.50.0
- R 4.2.2
- Skopeo 1.5.0
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 1.3.6
- yamllint 1.28.0
- yq v4.30.6
- zstd 1.5.2 (Homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.140
- AWS CLI 2.9.8
- AWS CLI Session manager plugin 1.2.398.0
- AWS SAM CLI 1.67.0
- Azure CLI 2.43.0
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.20.2
- Google Cloud SDK 412.0.0
- Hub CLI 2.14.2
- Netlify CLI 12.4.0
- OpenShift CLI 4.11.20
- ORAS CLI 0.16.0
- Vercel CLI 28.9.0

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.352+8 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.17+8           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK   | JAVA_HOME_12_X64     |
| 17.0.5+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP Tools
- PHP: 7.2.34, 7.3.33, 7.4.33, 8.0.26, 8.1.13, 8.2.0
- Composer 2.5.0
- PHPUnit 8.5.31

```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.4.3
- GHCup 0.1.18.0
- Stack 2.9.3

### Rust Tools
- Cargo 1.66.0
- Rust 1.66.0
- Rustdoc 1.66.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.63.0
- Cargo audit 0.17.4
- Cargo clippy 0.1.66
- Cargo outdated 0.11.1
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 108.0.5359.124
- ChromeDriver 108.0.5359.71
- Chromium 108.0.5341.0
- Microsoft Edge 108.0.1462.54
- Microsoft Edge WebDriver 108.0.1462.54
- Selenium server 4.7.0
- Mozilla Firefox 108.0.1
- Geckodriver 0.32.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core Tools
- .NET Core SDK: 3.1.120, 3.1.202, 3.1.302, 3.1.426, 5.0.104, 5.0.214, 5.0.303, 5.0.408, 6.0.404
- nbgv 3.5.119+5d25f54fec

### Databases
- MongoDB 5.0.14
- sqlite3 3.22.0

#### PostgreSQL
- PostgreSQL 14.6

```
    User: postgres
    PostgreSQL service is disabled by default.
    Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 5.7.40

```
    User: root
    Password: root
    MySQL service is disabled by default.
    Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.10.0001.1
- SqlPackage 16.1.6374.0

### Cached Tools
#### Go
- 1.16.15
- 1.17.13
- 1.18.9

#### Node.js
- 14.21.2
- 16.19.0
- 18.12.1

#### Python
- 2.7.18
- 3.6.15
- 3.7.15
- 3.8.15
- 3.9.16
- 3.10.9
- 3.11.1

#### PyPy
- 2.7.18 [PyPy 7.3.10]
- 3.6.12 [PyPy 7.3.3]
- 3.9.15 [PyPy 7.3.10]

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.10
- 2.7.7
- 3.0.5
- 3.1.3

### PowerShell Tools
- PowerShell 7.2.8

#### PowerShell Modules
- Az: 9.0.1
- Az (Cached): 3.1.0.zip, 4.4.0.zip, 5.9.0.zip, 6.6.0.zip, 7.5.0.zip
- MarkdownPS: 1.9
- Microsoft.Graph: 1.19.0
- Pester: 5.3.3

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.29  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.14.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                                |
| Android Emulator           | 31.3.14                                                                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 33.0.0 33.0.1<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 33.0.3                                                                                                                                                                                                                                                                             |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                     |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                             |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                                                                                                         |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                           |
| Google Play services       | 49                                                                                                                                                                                                                                                                                 |
| Google Repository          | 58                                                                                                                                                                                                                                                                                 |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.1.8937393 (default)                                                                                                                                                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                  |

#### Environment variables
| Name                    | Value                                       |
| ----------------------- | ------------------------------------------- |
| ANDROID_HOME            | /usr/local/lib/android/sdk                  |
| ANDROID_NDK             | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk/25.1.8937393 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                  |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.12             | sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69  | 2022-04-05 |
| alpine:3.13             | sha256:469b6e04ee185740477efa44ed5bdd64a07bbdd6c7e5f5d169e540889597b911  | 2022-08-09 |
| alpine:3.14             | sha256:4c869a63e1b7c0722fed1e402a6466610327c3b83bdddb94bd94fb71da7f638a  | 2022-08-09 |
| buildpack-deps:bullseye | sha256:ea5e7737f282e76b594669926ee6222beee0c237b9ba19a2055aa8f4feb83ba2  | 2022-12-06 |
| buildpack-deps:buster   | sha256:ecb6bd2c510b37b0bcbfaaa043192c293bfba2d9a0f4402abab6a342f186eebc  | 2022-12-06 |
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:e6fb8b88b411285ac71590459aa8d0a376acc86a3d17adfe45e806f522c54cc3  | 2022-12-06 |
| debian:11               | sha256:a288aa7ad0e4d443e86843972c25a02f99e9ad6ee589dd764895b2c3f5a8340b  | 2022-12-06 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:77abd86c9422aaff294bfde1029f03a6ab18ece0105003637cfda1d7fc22299f  | 2022-11-10 |
| node:14                 | sha256:ee3fd7a2cca7436bf73db2722b388839669b065827829d21213cab4994cc8e11  | 2022-12-13 |
| node:14-alpine          | sha256:80e825b1f5ab859498a2f0f98f8197131a562906e5f8c95977057502e68ca05a  | 2022-12-13 |
| node:16                 | sha256:1bbd8b82f5a78b6461d3285b62293db99ad60cf4eca35c715636d7143abb057c  | 2022-12-13 |
| node:16-alpine          | sha256:58e4dfcf063f67d71e608c3cace5a0bcf39e9dbab3047b41e20c15c7132d1d46  | 2022-12-13 |
| node:18                 | sha256:9ebe9845301ca70e879f22180dfff496b856bb5f2ec52397462a9f5f903ee654  | 2022-12-06 |
| node:18-alpine          | sha256:a136ed7b0df71082cdb171f36d640ea3b392a5c70401c642326acee767b8c540  | 2022-12-12 |
| ubuntu:16.04            | sha256:1f1a2d56de1d604801a9671f301190704c25d604a416f59e03c04f5c6ffee0d6  | 2021-08-31 |
| ubuntu:18.04            | sha256:daf3e62183e8aa9a56878a685ed26f3af3dd8c08c8fd11ef1c167a1aa9bd66a3  | 2022-12-09 |
| ubuntu:20.04            | sha256:0e0402cd13f68137edb0266e1d2c682f217814420f2d43d300ed8f65479b14fb  | 2022-12-09 |

### Installed apt packages
| Name              | Version                           |
| ----------------- | --------------------------------- |
| aria2             | 1.33.1-1                          |
| autoconf          | 2.69-11                           |
| automake          | 1:1.15.1-3ubuntu2                 |
| binutils          | 2.30-21ubuntu1\~18.04.8           |
| bison             | 2:3.0.4.dfsg-1build1              |
| brotli            | 1.0.3-1ubuntu1.3                  |
| build-essential   | 12.4ubuntu1                       |
| bzip2             | 1.0.6-8.1ubuntu0.2                |
| coreutils         | 8.28-1ubuntu1                     |
| curl              | 7.58.0-2ubuntu3.21                |
| dbus              | 1.12.2-1ubuntu1.4                 |
| dnsutils          | 1:9.11.3+dfsg-1ubuntu1.18         |
| dpkg              | 1.19.0.5ubuntu2.4                 |
| fakeroot          | 1.22-2ubuntu1                     |
| file              | 1:5.32-2ubuntu0.4                 |
| flex              | 2.6.4-6                           |
| ftp               | 0.17-34                           |
| gnupg2            | 2.2.4-1ubuntu1.6                  |
| haveged           | 1.9.1-6                           |
| imagemagick       | 8:6.9.7.4+dfsg-16ubuntu6.14       |
| iproute2          | 4.15.0-2ubuntu1.3                 |
| iputils-ping      | 3:20161105-1ubuntu3               |
| jq                | 1.5+dfsg-2                        |
| lib32z1           | 1:1.2.11.dfsg-0ubuntu2.2          |
| libc++-dev        | 6.0-2                             |
| libc++abi-dev     | 6.0-2                             |
| libcurl3          | 7.58.0-2ubuntu3.21                |
| libgbm-dev        | 20.0.8-0ubuntu1\~18.04.1          |
| libgconf-2-4      | 3.2.6-4ubuntu1                    |
| libgsl-dev        | 2.4+dfsg-6                        |
| libgtk-3-0        | 3.22.30-1ubuntu4                  |
| libmagic-dev      | 1:5.32-2ubuntu0.4                 |
| libmagickcore-dev | 8:6.9.7.4+dfsg-16ubuntu6.14       |
| libmagickwand-dev | 8:6.9.7.4+dfsg-16ubuntu6.14       |
| libsecret-1-dev   | 0.18.6-1                          |
| libsqlite3-dev    | 3.22.0-1ubuntu0.7                 |
| libtool           | 2.4.6-2                           |
| libunwind8        | 1.2.1-8                           |
| libxkbfile-dev    | 1:1.0.9-2                         |
| libxss1           | 1:1.2.2-1                         |
| libyaml-dev       | 0.1.7-2ubuntu3                    |
| locales           | 2.27-3ubuntu1.6                   |
| m4                | 1.4.18-1                          |
| mediainfo         | 17.12-1                           |
| mercurial         | 4.5.3-1ubuntu2.2                  |
| net-tools         | 1.60+git20161116.90da8a0-1ubuntu1 |
| netcat            | 1.10-41.1                         |
| openssh-client    | 1:7.6p1-4ubuntu0.7                |
| p7zip-full        | 16.02+dfsg-6                      |
| p7zip-rar         | 16.02-2                           |
| parallel          | 20161222-1                        |
| pass              | 1.7.1-3                           |
| patchelf          | 0.9-1                             |
| pkg-config        | 0.29.1-0ubuntu2                   |
| pollinate         | 4.33-0ubuntu1\~18.04.2            |
| python-setuptools | 39.0.1-2                          |
| rpm               | 4.14.1+dfsg1-2                    |
| rsync             | 3.1.2-2.1ubuntu1.5                |
| shellcheck        | 0.4.6-1                           |
| sphinxsearch      | 2.2.11-2                          |
| sqlite3           | 3.22.0-1ubuntu0.7                 |
| ssh               | 1:7.6p1-4ubuntu0.7                |
| sshpass           | 1.06-1                            |
| subversion        | 1.9.7-4ubuntu1.1                  |
| sudo              | 1.8.21p2-3ubuntu1.4               |
| swig              | 3.0.12-1                          |
| tar               | 1.29b-2ubuntu0.3                  |
| telnet            | 0.17-41                           |
| texinfo           | 6.5.0.dfsg.1-2                    |
| time              | 1.7-25.1build1                    |
| tk                | 8.6.0+9                           |
| tzdata            | 2022g-0ubuntu0.18.04              |
| unzip             | 6.0-21ubuntu1.2                   |
| upx               | 3.94-4                            |
| wget              | 1.19.4-1ubuntu2.2                 |
| xorriso           | 1.4.8-3                           |
| xvfb              | 2:1.19.6-1ubuntu4.13              |
| xz-utils          | 5.2.2-1.3ubuntu0.1                |
| zip               | 3.0-11build1                      |
| zsync             | 0.6.2-3ubuntu1                    |


