# openjdk:* images were deprecated and removed from Docker Hub entirely -
# eclipse-temurin is the actively-maintained successor (same OpenJDK build,
# different publisher).
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Wildcard, not a hardcoded version: this broke the last two builds when
# pom.xml's version changed (1.0 -> 1.0-SNAPSHOT) but this path didn't.
# There's exactly one jar in target/ (the shaded/main one - no separate
# sources/javadoc jars are built here), so the wildcard is unambiguous.
COPY target/*.jar /usr/src/app/simple-java-app.jar

# Expose the application on port 8080 (if your app is web-based)
EXPOSE 8080

# Command to run the JAR file
CMD ["java", "-jar", "/usr/src/app/simple-java-app.jar"]
