| Announcements |
|-|
| [Ubuntu-latest workflows will use Ubuntu-22.04](https://github.com/actions/runner-images/issues/6399) |
| [[all OSs] The VCPKG_ROOT variable will be removed from runner images](https://github.com/actions/runner-images/issues/6376) |
| [Third party PHP repository will be removed from the Ubuntu 22.04 image](https://github.com/actions/runner-images/issues/6331) |
| [[Ubuntu] homebrew will be removed from PATH variable](https://github.com/actions/runner-images/issues/6283) |
| [The Ubuntu 18.04 Actions runner image will begin deprecation on 8/8/22 and will be fully unsupported by 4/1/2023](https://github.com/actions/runner-images/issues/6002) |
***
# Ubuntu 20.04.5 LTS
- Linux kernel version: 5.15.0-1022-azure
- Image Version: 20221018.2

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.0
- Clang-format 10.0.0, 11.0.0, 12.0.0
- Clang-tidy 10.0.0, 11.0.0, 12.0.0
- Dash 0.5.10.2-6
- Erlang 25.0.4 (Eshell 13.0.4)
- Erlang rebar3 3.20.0
- GNU C++ 9.4.0, 10.3.0
- GNU Fortran 9.4.0, 10.3.0
- Julia 1.8.2
- Kotlin 1.7.20-release-201
- Mono 6.12.0.182 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.10.1.31701 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.18.0
- Perl 5.30.0
- Python 3.8.10
- Python3 3.8.10
- Ruby 2.7.0p0
- Swift 5.7

### Package Management
- cpan 1.64
- Helm 3.10.1
- Homebrew 3.6.6
- Miniconda 4.12.0
- Npm 8.19.2
- NuGet 6.3.1.1
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 1.1.0
- RubyGems 3.1.2
- Vcpkg  (build from master \<ce99c947b>)
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
- Ant 1.10.7
- Gradle 7.5.1
- Lerna 6.0.1
- Maven 3.8.6
- Sbt 1.7.2

### Tools
- Ansible 2.13.5
- apt-fast 1.9.12
- AzCopy 10.16.1 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.3.1
- Bazelisk 1.13.2
- Bicep 0.11.1
- Buildah 1.22.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
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
- Haveged 1.9.1
- Heroku 7.65.0
- HHVM (HipHop VM) 4.170.0
- jq 1.6
- Kind 0.16.0
- Kubectl 1.25.3
- Kustomize 4.5.7
- Leiningen 2.9.10
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.27.1
- n 9.0.0
- Newman 5.3.2
- nvm 0.39.2
- OpenSSL 1.1.1f-1ubuntu2.16
- Packer 1.8.3
- Parcel 2.7.0
- PhantomJS 2.1.1
- Podman 3.4.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.43.1
- R 4.2.1
- Skopeo 1.5.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 1.3.2
- yamllint 1.28.0
- yq 4.28.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.132
- AWS CLI 2.8.3
- AWS CLI Session manager plugin 1.2.398.0
- AWS SAM CLI 1.60.0
- Azure CLI (azure-cli) 2.41.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.18.0
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
| Tool     | Version              |
| -------- | -------------------- |
| PHP      | 7.4.32 8.0.24 8.1.11 |
| Composer | 2.4.3                |
| PHPUnit  | 8.5.30               |
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
- Microsoft Edge 106.0.1370.47 (apt source repository: https://packages.microsoft.com/repos/edge)
- Microsoft Edge WebDriver 106.0.1370.47
- Selenium server 4.5.0
- Mozilla Firefox 105.0
- Geckodriver 0.32.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| EDGEWEBDRIVER     | /usr/local/share/edge_driver        |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 3.1.120 3.1.202 3.1.302 3.1.424 5.0.104 5.0.214 5.0.303 5.0.408 6.0.402

### .NET tools
- nbgv 3.5.113+a908c6d9d2

### Databases
- MongoDB 5.0.13 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- sqlite3 3.31.1

#### PostgreSQL
- PostgreSQL 14.5 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 8.0.30-0ubuntu0.20.04.2
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
- 12.22.12
- 14.20.1
- 16.17.1

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 2.7.18
- 3.6.15
- 3.7.15
- 3.8.14
- 3.9.15
- 3.10.8

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.6
- 3.0.4
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.13/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.7/x64  | x64          |
| GOROOT_1_19_X64 | /opt/hostedtoolcache/go/1.19.2/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.6

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Microsoft.Graph  | 1.13.0  |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.21.0  |

#### Az PowerShell Modules
- 7.5.0 3.1.0.zip 4.4.0.zip 5.9.0.zip 6.6.0.zip

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

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
| buildpack-deps:stretch  | sha256:78e995165a5788c2f55aed6e548d8f6c1534830d4310c870408fccb2da8c5b2e  | 2022-06-23 |
| debian:10               | sha256:604db908f7ce93379b1289c0c7ba73b252002087a3fa64fe904b430083ba5f69  | 2022-10-04 |
| debian:11               | sha256:e538a2f0566efc44db21503277c7312a142f4d0dedc5d2886932b92626104bff  | 2022-10-04 |
| debian:9                | sha256:c5c5200ff1e9c73ffbf188b4a67eb1c91531b644856b4aefe86a58d2f0cb05be  | 2022-06-23 |
| moby/buildkit:latest    | sha256:46e7907bf9cdced1af7e45f1f07f69cb30560574d85d636a17ce6f97cc4844b4  | 2022-10-18 |
| node:12                 | sha256:01627afeb110b3054ba4a1405541ca095c8bfca1cb6f2be9479c767a2711879e  | 2022-04-20 |
| node:12-alpine          | sha256:d4b15b3d48f42059a15bd659be60afe21762aae9d6cbea6f124440895c27db68  | 2022-04-11 |
| node:14                 | sha256:d0634e5cde35cb312571cd007ae2270295bf2000ec489402325953bcee196ae2  | 2022-10-05 |
| node:14-alpine          | sha256:50808db1777e35ca156d06cfd31fa377febe82df6f26b8413a47c12dcbf5e6c5  | 2022-10-06 |
| node:16                 | sha256:6d592fdb89fccdeb880d14f30bf139b8a755f33b376f025b70e50ac5547c8ccf  | 2022-10-13 |
| node:16-alpine          | sha256:2175727cef5cad4020cb77c8c101d56ed41d44fbe9b1157c54f820e3d345eab1  | 2022-10-13 |
| ubuntu:16.04            | sha256:91bd29a464fdabfcf44e29e1f2a5f213c6dfa750b6290e40dd6998ac79da3c41  | 2021-08-31 |
| ubuntu:18.04            | sha256:40b84b75884ff39e4cac4bf62cb9678227b1fbf9dbe3f67ef2a6b073aa4bb529  | 2022-10-04 |
| ubuntu:20.04            | sha256:9c2004872a3a9fcec8cc757ad65c042de1dad4da27de4c70739a6e36402213e3  | 2022-10-04 |

### Installed apt packages
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| aria2                  | 1.35.0-1build1                    |
| autoconf               | 2.69-11.1                         |
| automake               | 1:1.16.1-4ubuntu6                 |
| binutils               | 2.34-6ubuntu1.3                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| build-essential        | 12.8ubuntu1.1                     |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.13                |
| dbus                   | 1.12.16-2ubuntu2.2                |
| dnsutils               | 1:9.16.1-0ubuntu2.11              |
| dpkg                   | 1.19.7ubuntu3.2                   |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0\~20200916-1\~ubuntu20.04.1      |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.2                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.5          |
| libc++-dev             | 1:10.0-50\~exp1                   |
| libc++abi-dev          | 1:10.0-50\~exp1                   |
| libcurl4               | 7.68.0-1ubuntu2.13                |
| libgbm-dev             | 21.2.6-0ubuntu0.1\~20.04.2        |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1.1                |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.4    |
| libsecret-1-dev        | 0.20.4-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.4                 |
| libtool                | 2.4.6-14                          |
| libunwind8             | 1.2.1-9build1                     |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| locales                | 2.31-0ubuntu9.9                   |
| m4                     | 1.4.18-4                          |
| mediainfo              | 19.09-1build1                     |
| mercurial              | 5.3.1-1ubuntu1                    |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.5                |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8ubuntu0.4                  |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.4                 |
| ssh                    | 1:8.2p1-4ubuntu0.5                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3ubuntu0.2                 |
| sudo                   | 1.8.31-1ubuntu1.2                 |
| swig                   | 4.0.1-5build1                     |
| tar                    | 1.30+dfsg-7ubuntu0.20.04.2        |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2022c-0ubuntu0.20.04.0            |
| unzip                  | 6.0-25ubuntu1.1                   |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu2                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.13-1ubuntu1\~20.04.3       |
| xz-utils               | 5.2.4-1ubuntu1.1                  |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |


