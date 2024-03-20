FROM maven:3.6.3-jdk-11 as build
#Sets base image for bild stage

WORKDIR /app 
# Sets working directory inside the container to /app

COPY MyWebApp/pom.xml .
COPY MyWebApp/src ./src
# Copy the project files into the image

RUN mvn clean package
#This line runs the Maven command to clean the project and package it into a distributable format (typically a WAR file).


FROM tomcat:9.0-jdk11-openjdk
# Sets base image for final stage

RUN rm -rf /usr/local/tomcat/webapps/*
# This line removes any existing artifacts from the Tomcat webapps directory to ensure a clean deployment environment.


COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
# Copy the WAR file from the build image to the Tomcat webapps directory


