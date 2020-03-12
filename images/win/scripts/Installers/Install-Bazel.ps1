################################################################################
##  File:  Install-Bazel.ps1
##  Desc:  Install Bazel and Bazelisk (A user-friendly launcher for Bazel)
################################################################################

choco install bazel -y

npm install -g @bazel/bazelisk