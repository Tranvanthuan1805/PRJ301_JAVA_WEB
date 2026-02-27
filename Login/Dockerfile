# ============================
# Dockerfile - VietAir Login
# Multi-stage build: Maven → Tomcat
# ============================

# === Stage 1: Build WAR ===
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /app

# Copy pom.xml truoc de cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B 2>/dev/null || true

# Copy source code
COPY src/ src/
COPY web/ web/

# Build WAR
RUN mvn clean package -DskipTests -B

# === Stage 2: Runtime ===
FROM tomcat:10.1-jdk21-temurin-jammy

# Xoa webapps mac dinh cua Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR tu builder
COPY --from=builder /app/target/Login.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
