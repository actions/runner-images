#!/bin/bash -e -o pipefail
: <<-LICENSE_BLOCK
setAutoLogin (20210911) - Copyright (c) 2021 Joel Bruner (https://github.com/brunerd)
Licensed under the MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
LICENSE_BLOCK

USERNAME="${1}"
PW="${2}"

function kcpasswordEncode {
    #ascii string
    local thisString="${1}"
    local i

    #macOS cipher hex ascii representation array
    local cipherHex_array=( 7D 89 52 23 D2 BC DD EA A3 B9 1F )

    #converted to hex representation with spaces
    local thisStringHex_array=( $(echo -n "${thisString}" | xxd -p -u | sed 's/../& /g') )

    #get padding by subtraction if under 11
    local r=$(( ${#thisStringHex_array[@]} % 11 ))
    local padding=0
    if [ ${#thisStringHex_array[@]} -eq 11 ]; then
        local padding=1
    elif [ $r -gt 0 ]; then
        local padding=$(( 11 - $r ))
    fi

    #cycle through each element of the array + padding
    for ((i=0; i < $(( ${#thisStringHex_array[@]} + ${padding})); i++)); do
        #use modulus to loop through the cipher array elements
        local charHex_cipher=${cipherHex_array[$(( $i % 11 ))]}

        #get the current hex representation element
        local charHex=${thisStringHex_array[$i]}

        #use $(( shell Aritmethic )) to ^ XOR the two 0x## values (extra padding is 0x00) 
        #take decimal value and printf convert to two char hex value
        #use xxd to convert hex to actual value and append to the encodedString variable
        local encodedString+=$(printf "%02X" "$(( 0x${charHex_cipher} ^ 0x${charHex:-00} ))")
    done

    #return the string without a newline
    echo -n "${encodedString}"
}

#encode password and write file
kcpasswordEncode "${PW}" | xxd -r -p > /etc/kcpassword

#ensure ownership and permissions (600)
chown root:wheel /etc/kcpassword
chmod u=rw,go= /etc/kcpassword

#turn on auto login
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser -string "${USERNAME}"
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow autoLoginUserScreenLocked -bool false
echo "Auto login enabled for '${USERNAME}'"
