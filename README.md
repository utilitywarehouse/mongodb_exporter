# MongoDB Exporter 

`quay.io/utilitywarehouse/mongodb_exporter`

[![Docker Repository on Quay](https://quay.io/repository/utilitywarehouse/mongodb_exporter/status "Docker Repository on Quay")](https://quay.io/repository/utilitywarehouse/mongodb_exporter)

## About
Builds a docker image for [Percona mongodb_exporter](https://github.com/percona/mongodb_exporter), docs can be found at the source GitHub repo

## Usage K8s sidecar

example with exporter collecting table top metrics
```
- name: mongodb-exporter
  env:
  - name: MONGODB_URI
    valueFrom:
      secretKeyRef:
        key: exporter.mongo.servers
        name: telecom-exceptions-api-mongo-secrets
    image: quay.io/utilitywarehouse/mongodb_exporter:latest
    imagePullPolicy: Always
    livenessProbe:
      failureThreshold: 3
      initialDelaySeconds: 60
      periodSeconds: 10
      successThreshold: 1
      tcpSocket:
        port: 9216
      timeoutSeconds: 1
    ports:
    - containerPort: 9216
      protocol: TCP
    resources:
      requests:
        memory: 50Mi
      limits:
        memory: 100Mi
    command:
    - /app/mongodb_exporter
    - --collect.topmetrics
```