#!/bin/bash -e -o pipefail

RUNNER_USER='runner'
RUNNER_PASS='runner'

# Create a new user with the $RUNNER_USER 
sudo dscl . -create /Users/$RUNNER_USER
# Add the display name of the User as runner   
sudo dscl . -create /Users/$RUNNER_USER RealName "runner"  
# Replace $RUNNER_PASS with your desired password to set the password for this user  
sudo dscl . -passwd /Users/$RUNNER_USER $RUNNER_PASS  
# Set the Unique ID for the New user. Replace with a number that is not already taken.   
sudo dscl . -create /Users/$RUNNER_USER UniqueID 502
# Set the group ID for the user  
sudo dscl . -create /Users/$RUNNER_USER PrimaryGroupID 20  
# Set the shell interpreter to Bash for New\ user   
sudo dscl . -create /Users/$RUNNER_USER UserShell /bin/bash  
# Create a Home folder for the user  
sudo dscl . -create /Users/$RUNNER_USER NFSHomeDirectory /Users/$RUNNER_USER  
# Append the User with admin privilege. If this line is not included the user will be set as standard user. 
sudo dscl . -append /Groups/admin GroupMembership $RUNNER_USER  

echo "A user $RUNNER_USER will be created to run the agent."

echo "Getting current group"
curr_group=$(id -gn)
echo "Current group: $curr_group"

echo "Getting current user"
curr_user=$(id -un)
echo "Current user: $curr_user"

echo "Copying $curr_user home directory to $RUNNER_USER"
sudo cp -R /Users/$curr_user/ /Users/$RUNNER_USER/
echo "Changing ownership of $RUNNER_USER home directory to $RUNNER_USER"
sudo chown -R $RUNNER_USER:$curr_group /Users/$RUNNER_USER

echo "Enabling passwordless sudo for $RUNNER_USER"
echo "$RUNNER_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$RUNNER_USER

# Enable SSH (Remote Login)
sudo systemsetup -setremotelogin on
