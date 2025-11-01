# Step 1: Base image
FROM openjdk:17-jdk-slim AS build

# Step 2: Copy Maven wrapper and project files
COPY . .

# Step 3: Build the project (ye jar banayega)
RUN ./mvnw clean package -DskipTests

# Step 4: Run stage
FROM openjdk:17-jdk-slim

# Step 5: Copy the jar file from previous build
COPY --from=build target/*.jar app.jar

# Step 6: Expose port and run
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
