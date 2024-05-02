FROM jenkins/inbound-agent:alpine as jnlp

FROM mcr.microsoft.com/dotnet/core/runtime:2.2-alpine

RUN apk -U add openjdk11-jre

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
CMD ["java -jar /usr/share/jenkins/agent.jar -url https://dev.zeabur.app/jenkins/ -secret 8632a53674b07300e6f39144a3bc4a93bd877a8ba508101c0f7bea586880fd9e -name agent"]
