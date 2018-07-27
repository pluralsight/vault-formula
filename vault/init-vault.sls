unseal_vault:
  cmd.run:
    - name: export VAULT_ADDR='https://localhost:8200' && vault operator init -tls-skip-verify 
