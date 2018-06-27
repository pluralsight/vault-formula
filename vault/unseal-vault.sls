unseal_vault:
  cmd.run:
    - name: export VAULT_ADDR='http://127.0.0.1:8200' && vault unseal {{ pillar['vault']['Unseal_Key_1'] }} && vault unseal {{ pillar['vault']['Unseal_Key_2'] }}  && vault unseal {{ pillar['vault']['Unseal_Key_3'] }}
