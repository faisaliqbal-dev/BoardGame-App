FROM openjdk:17-alpine
        
WORKDIR /usr/src/app
 
COPY target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
