FROM maven:3.6.3 AS maven
LABEL MAINTAINER="asif.mohammed1@cbre.com"

# Compile and package the application to an executable JAR
RUN mvn package 

FROM openjdk:11
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
