# sshkey-permission-checker
`.ssh`のパーミッションを間違えてしまう人の為の簡易的なチェックスクリプト。

# 使い方
```bash
# ruby sshkey-permission-checker.rb tsumugi
Checking ~/.ssh permission and owner...
>>> is .ssh owned by user tsumugi => [OK]
>>> is .ssh permission is 700 => [OK]

Checking ~/.ssh/authorized_keys permission and owner...
>>> is .ssh owned by user tsumugi => [OK]
>>> is .ssh permission is 600 => [OK]

Checking for ~/.ssh/id_* files...
>>Checking /home/tsumugi/.ssh/id_ecdsa permission and owner...
>>> is /home/tsumugi/.ssh/id_ecdsa owned by user tsumugi => [OK]
>>> is /home/tsumugi/.ssh/id_ecdsa permission is 600 => [OK]

>>Checking /home/tsumugi/.ssh/id_ed25519 permission and owner...
>>> is /home/tsumugi/.ssh/id_ed25519 owned by user tsumugi => [OK]
>>> is /home/tsumugi/.ssh/id_ed25519 permission is 600 => [OK]

>>Checking /home/tsumugi/.ssh/id_rsa permission and owner...
>>> is /home/tsumugi/.ssh/id_rsa owned by user tsumugi => [OK]
>>> is /home/tsumugi/.ssh/id_rsa permission is 600 => [OK]
```