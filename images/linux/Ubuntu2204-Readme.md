| Announcements |
|-|
| [Ubuntu-latest workflows will use Ubuntu-22.04](https://github.com/actions/runner-images/issues/6399) |
| [[all OSs] The VCPKG_ROOT variable will be removed from runner images](https://github.com/actions/runner-images/issues/6376) |
| [Third party PHP repository will be removed from the Ubuntu 22.04 image](https://github.com/actions/runner-images/issues/6331) |
| [[Ubuntu] homebrew will be removed from PATH variable](https://github.com/actions/runner-images/issues/6283) |
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 8/8/22 and will be fully unsupported by 4/1/2023](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 22.04.1 LTS
- Linux kernel version: 5.15.0-1022-azure
- Image Version: 20221024.1

## Installed Software
### Language and Runtime
- Bash 5.1.16(1)-release
- Clang 12.0.1, 13.0.1, 14.0.0
- Clang-format 12.0.1, 13.0.1, 14.0.0
- Clang-tidy 12.0.1, 13.0.1, 14.0.0
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++ 9.4.0, 10.3.0, 11.2.0
- GNU Fortran 9.4.0, 10.3.0, 11.2.0
- Julia 1.8.2
- Kotlin 1.7.20-release-201
- Mono 6.12.0.182 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.10.1.31701 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.18.0
- Perl 5.34.0
- Python 3.10.6
- Python3 3.10.6
- Ruby 3.0.2p107
- Swift 5.7

### Package Management
- cpan 1.64
- Helm 3.10.1
- Homebrew 3.6.7
- Miniconda 4.12.0
- Npm 8.19.2
- NuGet 6.3.1.1
- Pip 22.0.2
- Pip3 22.0.2
- Pipx 1.1.0
- RubyGems 3.3.5
- Vcpkg  (build from master \<6118e6b13>)
- Yarn 1.22.19

##### Notes:
```
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
```

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |
| VCPKG_ROOT              | /usr/local/share/vcpkg |

### Project Management
- Lerna 6.0.1

### Tools
- Ansible 2.13.5
- apt-fast 1.9.12
- AzCopy 10.16.1 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.3.2
- Bazelisk 1.13.2
- Bicep 0.11.1
- Buildah 1.23.1
- CMake 3.24.2
- CodeQL Action Bundle 2.11.1
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.11.2+azure-1
- Docker-Buildx 0.9.1
- Docker-Moby Client 20.10.18+azure-2
- Docker-Moby Server 20.10.18+azure-2
- Fastlane 2.210.1
- Git 2.38.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.2.0 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.14
- Heroku 7.65.0
- jq 1.6
- Kind 0.16.0
- Kubectl 1.25.3
- Kustomize 4.5.7
- Leiningen 2.9.10
- MediaInfo 21.09
- Mercurial 6.1.1
- Minikube 1.27.1
- n 9.0.0
- Newman 5.3.2
- nvm 0.39.2
- OpenSSL 3.0.2-0ubuntu1.6
- Packer 1.8.3
- Parcel 2.7.0
- Podman 3.4.4
- Pulumi 3.43.1
- R 4.2.1
- Skopeo 1.4.1
- Sphinx Open Source Search Server 2.2.11
- SVN 1.14.1
- Terraform 1.3.3
- yamllint 1.28.0
- yq 4.28.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.132
- AWS CLI 2.8.5
- AWS CLI Session manager plugin 1.2.398.0
- AWS SAM CLI 1.60.0
- Azure CLI (azure-cli) 2.41.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.18.1
- Google Cloud SDK 406.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 12.0.11
- OpenShift CLI 4.11.9
- ORAS CLI 0.15.1
- Vercel CLI 28.4.12

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.345+1           | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.16+1 (default) | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.4+1            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.2.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version |
| -------- | ------- |
| PHP      | 8.1.11  |
| Composer | 2.4.3   |
| PHPUnit  | 8.5.30  |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.4.2
- GHCup 0.1.18.0
- Stack 2.9.1

### Rust Tools
- Cargo 1.64.0
- Rust 1.64.0
- Rustdoc 1.64.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.61.0
- Cargo audit 0.17.2
- Cargo clippy 0.1.64
- Cargo outdated 0.11.1
- Cbindgen 0.24.3
- Rustfmt 1.5.1

### Browsers and Drivers
- Google Chrome 106.0.5249.119
- ChromeDriver 106.0.5249.61
- Chromium 106.0.5235.0
- Microsoft Edge 106.0.1370.52 (apt source repository: https://packages.microsoft.com/repos/edge)
- Microsoft Edge WebDriver 106.0.1370.52
- Selenium server 4.5.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    |                                     |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 6.0.402

### .NET tools
- nbgv 3.5.119+5d25f54fec

### Databases
- sqlite3 3.37.2

#### PostgreSQL
- PostgreSQL 14.5 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 8.0.31-0ubuntu0.22.04.1
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.10.0001.1
- SqlPackage 16.0.6296.0

### Cached Tools
#### Go
- 1.17.13
- 1.18.7
- 1.19.2

#### Node.js
- 14.20.1
- 16.17.1

#### PyPy
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 3.7.15
- 3.8.14
- 3.9.15
- 3.10.8

#### Ruby
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.13/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.7/x64  | x64          |
| GOROOT_1_19_X64 | /opt/hostedtoolcache/go/1.19.2/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.7

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Microsoft.Graph  | 1.13.0  |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.21.0  |

#### Az PowerShell Modules
- 7.5.0

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.52  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.3.12                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 33.0.3                                                                                                                                                 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Tools          | 26.1.1                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.1.8937393 (default)                                                                                                 |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

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
| alpine:3.14             | sha256:1ab24b3b99320975cca71716a7475a65d263d0b6b604d9d14ce08f7a3f67595c  | 2022-08-09 |
| alpine:3.15             | sha256:69463fdff1f025c908939e86d4714b4d5518776954ca627cbeff4c74bcea5b22  | 2022-08-09 |
| alpine:3.16             | sha256:bc41182d7ef5ffc53a40b044e725193bc10142a1243f395ee852a8d9730fc2ad  | 2022-08-09 |
| buildpack-deps:bullseye | sha256:b501b75e9014f6bd3b4cc08e098653ba0b2863b7242f49134f974ebabdf2eb37  | 2022-10-05 |
| buildpack-deps:buster   | sha256:c6f69876293b14c190e89e612826844f4a6f2cd9500d5a26523979b16daa5220  | 2022-10-05 |
| debian:10               | sha256:604db908f7ce93379b1289c0c7ba73b252002087a3fa64fe904b430083ba5f69  | 2022-10-04 |
| debian:11               | sha256:e538a2f0566efc44db21503277c7312a142f4d0dedc5d2886932b92626104bff  | 2022-10-04 |
| moby/buildkit:latest    | sha256:46e7907bf9cdced1af7e45f1f07f69cb30560574d85d636a17ce6f97cc4844b4  | 2022-10-18 |
| node:14                 | sha256:d0634e5cde35cb312571cd007ae2270295bf2000ec489402325953bcee196ae2  | 2022-10-05 |
| node:14-alpine          | sha256:50808db1777e35ca156d06cfd31fa377febe82df6f26b8413a47c12dcbf5e6c5  | 2022-10-06 |
| node:16                 | sha256:6d592fdb89fccdeb880d14f30bf139b8a755f33b376f025b70e50ac5547c8ccf  | 2022-10-13 |
| node:16-alpine          | sha256:2175727cef5cad4020cb77c8c101d56ed41d44fbe9b1157c54f820e3d345eab1  | 2022-10-13 |
| ubuntu:18.04            | sha256:40b84b75884ff39e4cac4bf62cb9678227b1fbf9dbe3f67ef2a6b073aa4bb529  | 2022-10-04 |
| ubuntu:20.04            | sha256:9c2004872a3a9fcec8cc757ad65c042de1dad4da27de4c70739a6e36402213e3  | 2022-10-04 |
| ubuntu:22.04            | sha256:35fb073f9e56eb84041b0745cb714eff0f7b225ea9e024f703cab56aaa5c7720  | 2022-10-04 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.3.1-1                           |
| aria2                  | 1.36.0-1                          |
| autoconf               | 2.71-2                            |
| automake               | 1:1.16.5-1.3                      |
| binutils               | 2.38-3ubuntu1                     |
| bison                  | 2:3.8.2+dfsg-1build1              |
| brotli                 | 1.0.9-2build6                     |
| build-essential        | 12.9ubuntu3                       |
| bzip2                  | 1.0.8-5build1                     |
| coreutils              | 8.32-4.1ubuntu1                   |
| curl                   | 7.81.0-1ubuntu1.4                 |
| dbus                   | 1.12.20-2ubuntu4                  |
| dnsutils               | 1:9.18.1-1ubuntu1.2               |
| dpkg                   | 1.21.1ubuntu2.1                   |
| fakeroot               | 1.28-1ubuntu1                     |
| file                   | 1:5.41-3                          |
| flex                   | 2.6.4-8build2                     |
| fonts-noto-color-emoji | 2.034-1                           |
| ftp                    | 20210827-4build1                  |
| gnupg2                 | 2.2.27-3ubuntu2.1                 |
| haveged                | 1.9.14-1ubuntu1                   |
| imagemagick            | 8:6.9.11.60+dfsg-1.3build2        |
| iproute2               | 5.15.0-1ubuntu2                   |
| iputils-ping           | 3:20211215-1                      |
| jq                     | 1.6-2.1ubuntu3                    |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu9.2          |
| libc++-dev             | 1:14.0-55\~exp2                   |
| libc++abi-dev          | 1:14.0-55\~exp2                   |
| libcurl4               | 7.81.0-1ubuntu1.4                 |
| libgbm-dev             | 22.0.5-0ubuntu0.1                 |
| libgconf-2-4           | 3.2.6-7ubuntu2                    |
| libgsl-dev             | 2.7.1+dfsg-3                      |
| libgtk-3-0             | 3.24.33-1ubuntu2                  |
| libmagic-dev           | 1:5.41-3                          |
| libmagickcore-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libmagickwand-dev      | 8:6.9.11.60+dfsg-1.3build2        |
| libsecret-1-dev        | 0.20.5-2                          |
| libsqlite3-dev         | 3.37.2-2                          |
| libssl-dev             | 3.0.2-0ubuntu1.6                  |
| libtool                | 2.4.6-15build2                    |
| libunwind8             | 1.3.2-2build2                     |
| libxkbfile-dev         | 1:1.1.0-1build3                   |
| libxss1                | 1:1.2.3-1build2                   |
| locales                | 2.35-0ubuntu3.1                   |
| m4                     | 1.4.18-5ubuntu2                   |
| mediainfo              | 22.03-1                           |
| mercurial              | 6.1.1-1ubuntu1                    |
| net-tools              | 1.60+git20181103.0eebece-1ubuntu5 |
| netcat                 | 1.218-4ubuntu1                    |
| openssh-client         | 1:8.9p1-3                         |
| p7zip-full             | 16.02+dfsg-8                      |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20210822+ds-2                     |
| pass                   | 1.7.4-5                           |
| patchelf               | 0.14.3-1                          |
| pkg-config             | 0.29.2-1ubuntu3                   |
| pollinate              | 4.33-3ubuntu2                     |
| python-is-python3      | 3.9.2-2                           |
| rpm                    | 4.17.0+dfsg1-4build1              |
| rsync                  | 3.2.3-8ubuntu3                    |
| shellcheck             | 0.8.0-2                           |
| sphinxsearch           | 2.2.11-8                          |
| sqlite3                | 3.37.2-2                          |
| ssh                    | 1:8.9p1-3                         |
| sshpass                | 1.09-1                            |
| subversion             | 1.14.1-3ubuntu0.22.04.1           |
| sudo                   | 1.9.9-1ubuntu2.1                  |
| swig                   | 4.0.2-1ubuntu1                    |
| tar                    | 1.34+dfsg-1build3                 |
| telnet                 | 0.17-44build1                     |
| texinfo                | 6.8-4build1                       |
| time                   | 1.9-0.1build2                     |
| tk                     | 8.6.11+1build2                    |
| tzdata                 | 2022c-0ubuntu0.22.04.0            |
| unzip                  | 6.0-26ubuntu3.1                   |
| upx                    | 3.96-3                            |
| wget                   | 1.21.2-2ubuntu1                   |
| xorriso                | 1.5.4-2                           |
| xvfb                   | 2:21.1.3-2ubuntu2.1               |
| xz-utils               | 5.2.5-2ubuntu1                    |
| zip                    | 3.0-12build2                      |
| zsync                  | 0.6.2-3ubuntu1                    |


