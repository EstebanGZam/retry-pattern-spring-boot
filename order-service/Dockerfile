# Usamos una imagen oficial de Java
FROM eclipse-temurin:17-jdk AS builder

# Definir el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el proyecto al contenedor
COPY . .

# Uncomment in case the image build doesn't work
# RUN apt-get update && apt-get install -y maven
# Construir el proyecto con Maven
RUN ./mvnw clean package -DskipTests

# Extraer el JAR generado
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copiar el JAR generado en la fase anterior
COPY --from=builder /app/target/order-service-*.jar app.jar

# Exponer el puerto 8081
EXPOSE 8081

# Comando de ejecución
ENTRYPOINT ["java", "-jar", "app.jar"]
