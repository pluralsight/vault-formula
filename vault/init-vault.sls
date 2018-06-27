unseal_vault:
  cmd.run:
    - name: export VAULT_ADDR='http://127.0.0.1:8200' && vault operator init
