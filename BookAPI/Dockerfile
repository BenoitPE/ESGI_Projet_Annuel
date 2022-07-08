FROM openjdk:17-jdk-alpine
EXPOSE 8080
COPY target/bookapi-0.0.1-SNAPSHOT.jar bookapi-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/bookapi-0.0.1-SNAPSHOT.jar"]