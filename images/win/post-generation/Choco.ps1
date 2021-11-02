# Step to avoid initial delay for choco scripts.
# On calling the first choco command
# Chocolatey spends 2 minutes cleaning up and removing unneeded packages in the environment.
$ChocoVersion = choco --version
choco upgrade chocolatey --version=$ChocoVersion
