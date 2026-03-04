# ============================
# Dockerfile - Da Nang Travel Hub
# Multi-stage build: Maven → Tomcat
# ============================

# === Stage 1: Build WAR ===
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /app

# Copy pom.xml first to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B 2>/dev/null || true

# Copy source code
COPY src/ src/

# Build WAR
RUN mvn clean package -DskipTests -B

# === Stage 2: Runtime ===
FROM tomcat:10.1-jdk21-temurin-jammy

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from builder (artifact name from pom.xml: DaNangTravelHub-4.0-SNAPSHOT.war)
COPY --from=builder /app/target/DaNangTravelHub-4.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
