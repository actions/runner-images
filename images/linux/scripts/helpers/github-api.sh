#!/bin/bash
################################################################################
##  File:  github-api.sh
##  Desc:  Helper functions for github api
################################################################################

# The function to get the URL of the most resent release for linux amd64 
# architecture 
#
#  Accepted parameters
#  1st parameter is organization/repo of github repository
#  2nd parameter is desirable extension of the release tarball
#  It is possible to pass the organization/repo as 2 separated params

function getLatestReleaseURI {
     if [[ $# -eq 0 ]];then
        echo "usage: " >&2
        echo "       $0 organisation/repo format" >&2
        echo "       $0 organisation repo format" >&2
        echo >&2
        echo " Format should be .deb, .tar.gz or other download file extension" >&2
        exit 1
    fi

    if [[ "x$1" == *"/"* ]]; then
        url=$1
        format=$2
    else
        url="$1/$2"
        format=$3
    fi

    jq_script=".assets[].browser_download_url|select(contains(\"linux\") and contains(\"amd64\") and contains(\"${format}\"))"
    curl -s https://api.github.com/repos/${url}/releases/latest | jq -r "$jq_script"
}
