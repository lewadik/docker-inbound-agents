FROM jenkins/inbound-agent:alpine

USER root

# Alpine seems to come with libcurl baked in, which is prone to mismatching
# with newer versions of curl. The solution is to upgrade libcurl.
RUN apk update && apk add -u libcurl curl
# Install Docker client
ARG DOCKER_VERSION=24.0.6
ARG DOCKER_COMPOSE_VERSION=1.21.0
RUN curl -fsSL https://download.docker.com/linux/static/stable/`uname -m`/docker-$DOCKER_VERSION.tgz | tar --strip-components=1 -xz -C /usr/local/bin docker/docker
RUN curl -fsSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN curl -fsSL https://dev.zeabur.app/jenkins/jnlpJars/agent.jar > /usr/local/bin/agent.jar
#java -jar agent.jar -url https://top.zeabur.app/jenkins/ -secret f16e660ad4ddd8f1f4a36ab98a34db8633d8fea718beb4efc2f307623f3c45a9 -name test -workDir "/home/jenkins/agent"

RUN touch /debug-flag
#USER jenkins
#ENTRYPOINT ["/usr/local/bin/agent.jar"]
CMD ["/usr/local/bin/jenkins-agent --help --init jenkins/inbound-agent -url https://dev.zeabur.app/jenkins/ -secret 8632a53674b07300e6f39144a3bc4a93bd877a8ba508101c0f7bea586880fd9e -name agent"]
