# Step 1: Base image
FROM openjdk:17-jdk-slim AS build

# Step 2: Copy all files
COPY . .

# Step 3: Give permission to mvnw
RUN chmod +x ./mvnw

# Step 4: Build the project (ye jar banayega)
RUN ./mvnw clean package -DskipTests

# Step 5: Run stage
FROM openjdk:17-jdk-slim

# Step 6: Copy jar from build stage
COPY --from=build target/*.jar app.jar

# Step 7: Expose port and run
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
