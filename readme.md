这个是在k8s里面调试用的容器，安装了常用的工具。


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

