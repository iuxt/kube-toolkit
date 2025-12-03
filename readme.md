这个是在k8s里面调试用的容器，安装了常用的工具。

## 可以做什么

1. 在pod里使用 `mysql` 、`redis-cli` 命令连接数据库
2. 在pod里进行网络调试，如 `ping` `telnet` `nmap` `ncat` `tracepath` `dig`  等网络调试命令
3. 运行一个`python3`程序或脚本
4. 验证或测试从ingress到pod的延迟、以及多个pod的负载调度情况（基于echoserver，访问会将pod信息和http信息输出）
5. 在pod里执行`kubectl`命令，比如k8s你只有个管理平台的情况
6. 通过k8s跳转登录到宿主机(基于`kube-node-shell`，在pod里使用 `kubectl node-shell <nodename>`)

## 一条命令直接运行

```bash
docker run -it --rm --name network-test --network iuxt registry.cn-hangzhou.aliyuncs.com/iuxt/network-test:2025-06-20 bash
kubectl run -it network-test --image=registry.cn-hangzhou.aliyuncs.com/iuxt/network-test:2025-06-20 --restart=Never --rm --command -- bash
```

## 几个配置文件的区别



```bash
# 只需要测试从pod访问外部，不执行kubectl命令，也不用从外部访问pod
kubectl apply -f ./client-pod.yaml

# 测试集群外部访问pod的网络情况
kubectl apply -f ./client-deployment-ingress.yml

# 需要执行kubectl命令，不需要高权限
kubectl apply -f ./client-pod-with-kubectl.yaml

# 需要执行kubectl命令，要高权限 执行！ 可以使用 kubectl node-shell <hostname> 登录任意一台主机。
kubectl apply -f ./client-pod-with-kubectl-admin.yaml
```

## 构建镜像
```bash
# 指定架构构建
docker build --platform linux/amd64 -t test .
docker build --platform linux/amd64 --no-cache -t registry.cn-hangzhou.aliyuncs.com/iuxt/kube-toolkit:20251203 .

```


crontab 目录：
/etc/cron.d/

服务目录：
/etc/services.d/