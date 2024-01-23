#!/bin/bash -e
################################################################################
##  File:  install-octocat-greetings.sh
##  Desc:  Script which greets hubbers behalf octocat.
################################################################################

# Install lolcat-c
sudo snap install lolcat-c

# Form the octocat script
cat <<EOF > octocat 
#!/bin/bash
curl -L https://api.github.com/octocat | lolcat-c
echo " "
echo "Greetengs from Octocat, hubbers!" | lolcat-c
echo " "
echo "A speaker is nervous and needs some hugs, feel free to hug him!" | lolcat-c
echo " "
echo "                       Cheers & Octocats " | lolcat-c
EOF

# Move the script to /usr/local/bin and make it executable
sudo mv octocat /usr/local/bin
sudo chmod +x /usr/local/bin/octocat