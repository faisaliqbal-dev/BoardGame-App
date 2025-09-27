FROM openjdk:17-alpine
        
WORKDIR usr/scr/app
 
COPY target/*.jar usr/scr/app

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
