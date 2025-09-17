FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY echoserver/main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /echo-server main.go



FROM ubuntu:24.04 AS runner
RUN sed -i 's@//.*.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources
RUN apt update && \
    apt install -y curl \
    inetutils-ping \
    bind9-dnsutils \
    telnet \
    ncat \
    nmap \
    python3 \
    mysql-client-core-8.0 \
    redis-tools \
    iputils-tracepath \
    vim \
    bash-completion \
    && apt clean all
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm -f kubectl \
    && curl -OL https://s3.babudiu.com/src/linux/bin/kubectl-node_shell \
    && install -o root -g root -m 0755 kubectl-node_shell /usr/local/bin/kubectl-node_shell \
    && rm -f kubectl-node_shell \
    && echo 'source /usr/share/bash-completion/bash_completion' >> /root/.bashrc \
    && echo 'source <(kubectl completion bash)' >> /root/.bashrc

COPY --from=builder /echo-server /echo-server
RUN chmod +x /echo-server

CMD ["/echo-server"]
