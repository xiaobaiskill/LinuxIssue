# mysql 做持久化
1. 在deployment文件中加入`volumes`，提供給containers做使用


```yml
spec:
  # replicas: 3 # number of pods need to create
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      hostNetwork: false 
      containers:
        ...

        volumeMounts:
         - name: mysql-persistent-storage
           mountPath: /var/lib/mysql

      volumes:
        - name: mysql-persistent-storage
          persistentVolumeClaim:
            claimName: mysql-volumeclaim
```

2. 新增一個`pvc.yml`，給deployment.yml參照
```yml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql-volumeclaim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 200Gi
```

# refer:
- https://github.com/GoogleCloudPlatform/kubernetes-engine-samples/tree/master/wordpress-persistent-disks