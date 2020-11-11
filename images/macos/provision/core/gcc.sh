#!/bin/bash -e -o pipefail

echo "Installing GCC@8 using homebrew..."
brew install gcc@8

echo "Installing GCC@9 using homebrew..."
brew install gcc@9

# Known issue with brew that prevent installation of multiple formulas
# https://github.com/Homebrew/brew/issues/9100
echo "Applying workaround for the GCC"
cellarPath=$(brew --cellar gcc@8)
gccVersion=$(ls $cellarPath | head -n1)
fullCellarPath=$cellarPath/$gccVersion
ln -s $fullCellarPath/bin/c++-8 /usr/local/bin/c++-8
ln -s $fullCellarPath/bin/cpp-8 /usr/local/bin/cpp-8
ln -s $fullCellarPath/bin/g++-8 /usr/local/bin/g++-8
ln -s $fullCellarPath/bin/gcc-8 /usr/local/bin/gcc-8
ln -s $fullCellarPath/bin/gfortran-8 /usr/local/bin/gfortran-8