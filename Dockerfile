# Dockerfile para aplicação Spring Boot
# Multi-stage build para otimizar o tamanho da imagem final

# Stage 1: Build da aplicação
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copia os arquivos de dependências primeiro (cache de camadas)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia o código fonte
COPY src ./src

# Compila a aplicação
RUN mvn clean package -DskipTests

# Stage 2: Imagem final otimizada
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Cria um usuário não-root para executar a aplicação
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copia o JAR compilado do stage anterior
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta da aplicação
EXPOSE 8080

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]

