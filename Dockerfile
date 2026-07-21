# openjdk:*-alpine images are deprecated/removed from Docker Hub; use Eclipse Temurin instead
FROM eclipse-temurin:17-jre-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the JAR file from the target directory into the container
COPY target/*.jar /usr/src/app/simple-java-app.jar

# Expose the application on port 8080 (if your app is web-based)
EXPOSE 8080

# Command to run the JAR file
CMD ["java", "-jar", "/usr/src/app/simple-java-app.jar"]
