# Define the vault password file (adjust the path as needed)
VAULT_PASSWORD_FILE=".vault-password-prod.txt"

# Find and encrypt all files in directories named "vault"
find . -type d -name 'vault' | while read -r vault_dir; do
  find "$vault_dir" -type f | while read -r file; do
    echo "Encrypting $file"
    ansible-vault encrypt "$file" --vault-password-file $VAULT_PASSWORD_FILE
  done
done

# Find and encrypt all files named "vault.yml"
find . -type f -name 'vault.yml' | while read -r file; do
  echo "Encrypting $file"
  ansible-vault encrypt "$file" --vault-password-file $VAULT_PASSWORD_FILE
done