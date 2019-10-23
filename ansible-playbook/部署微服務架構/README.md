# 動機:
1. 標準化: 制定ansible角色分割，來達到執行固定腳本完成工作項目
2. 自動化: 透過Jenkins等UI介面，操作ansible執行單向指令，同時做權限切割
3. 可測試性: 嚴謹定義元件，保證元件執行結果如人員預期

### 執行步驟
1. 下載此專案
2. 到專案位置${pwd}/ansible-playbook
3. 執行指令ansible-playbook -i inventories/env/inventory demo.yml -v

# refer:
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html
- https://docs.ansible.com/ansible/latest/reference_appendices/config.html
- https://docs.ansible.com/ansible/latest/user_guide/intro_getting_started.html#host-key-checking

# refer _ configuration:
- https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html