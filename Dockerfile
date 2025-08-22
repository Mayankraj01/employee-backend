# Stage 1: Build the app
FROM maven:3.8.7-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and src directory
COPY pom.xml .
COPY src ./src

# Build the app and skip tests (to save time)
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/employee-api-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
