FROM maven:3.8.4-openjdk-11 as maven
WORKDIR /usr/src/app
COPY . /usr/src/app

# Compile and package the application to an executable JAR
RUN mvn clean install package

FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=target/*.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/${JAR_FILE} /opt/app/app.jar

ENTRYPOINT ["java","-jar","app.jar"]
