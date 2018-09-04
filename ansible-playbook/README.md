# 練習使用ansible在gcp環境上做部署
1. 建置gcp instance
- deploygcpinstance.yml
```yml
# 使用name定義名稱
- name: Create instance(s)
  hosts: localhost

# 可以藉由是先宣告變數取代下方變數空格
  vars:
    service_account_email: 704960288977-compute@developer.gserviceaccount.com
    credentials_file: gcptestansible.json
    project_id: crack-will-209815
    machine_type: n1-standard-1
    image: debian-7
    gcp_instance_name: dev1,dev2,dev3

# 定義即將執行的任務
  tasks:
   - 
     name: Launch instances
     gce:
         instance_names: "{{ gcp_instance_name }}"
         machine_type: "{{ machine_type }}"
         image: "{{ image }}"
         service_account_email: "{{ service_account_email }}"
         credentials_file: "{{ credentials_file }}"
         project_id: "{{ project_id }}"
         # 使用metadata讓gcp執行某些指令
         metadata : '{ "startup-script" : "ping -c 3 127.0.0.1" }'
```
2. 


to be continue ...