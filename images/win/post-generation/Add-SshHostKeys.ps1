# Add well-known SSH host keys to ssh_known_hosts

ssh-keyscan -t rsa github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"
ssh-keyscan -t dsa github.com >> "C:\Program Files\Git\etc\ssh\ssh_known_hosts"