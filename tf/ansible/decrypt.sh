# ansible-vault decrypt host_vars/usegalaxy.be/vault/*.yml --vault-password-file .vault-password-prod.txt
# ansible-vault decrypt host_vars/test.usegalaxy.be/vault/*.yml --vault-password-file .vault-password-test.txt
# ansible-vault decrypt group_vars/all/vault/*.yml --vault-password-file .vault-password-prod.txt
# ansible-vault decrypt group_vars/galaxyservers/vault.yml --vault-password-file .vault-password-prod.txt
# ansible-vault decrypt group_vars/proxyservers/vault.yml --vault-password-file .vault-password-prod.txt

#!/bin/bash

# Define the vault password file (adjust the path as needed)
VAULT_PASSWORD_FILE=".vault-password-prod.txt"

# Find and decrypt all files in directories named "vault"
find . -type d -name 'vault' | while read -r vault_dir; do
  find "$vault_dir" -type f | while read -r file; do
    echo "Decrypting $file"
    ansible-vault decrypt "$file" --vault-password-file $VAULT_PASSWORD_FILE
  done
done

# Find and decrypt all files named "vault.yml"
find . -type f -name 'vault.yml' | while read -r file; do
  echo "Decrypting $file"
  ansible-vault decrypt "$file" --vault-password-file $VAULT_PASSWORD_FILE
done
