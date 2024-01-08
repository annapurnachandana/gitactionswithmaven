FROM maven:3.6.3-openjdk-14-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml -DskipTests

FROM openjdk:14-slim
COPY --from=build /target/gitactionswithmaven-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 6379
ENTRYPOINT ["java","-jar","app.jar"]