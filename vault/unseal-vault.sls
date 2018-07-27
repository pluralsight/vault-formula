unseal_vault:
  cmd.run:
    - name: export VAULT_ADDR='https://localhost:8200' && vault operator unseal -tls-skip-verify {{ pillar['vault']['Unseal_Key_1'] }} && vault operator unseal -tls-skip-verify {{ pillar['vault']['Unseal_Key_2'] }} && vault operator unseal -tls-skip-verify {{ pillar['vault']['Unseal_Key_3'] }}
