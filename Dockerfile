# Utilisation d'une image Maven pour la phase de build
FROM maven:3.8.1-openjdk-11 AS build
WORKDIR /app

# Copie des fichiers de configuration et des sources
COPY pom.xml .
COPY src ./src

# Compilation et packaging du projet Maven
RUN mvn clean package -DskipTests

# Utilisation d'une image JDK minimale pour l'exécution
FROM openjdk:11-jre
WORKDIR /app

# Copie du jar généré depuis l'étape de build
COPY --from=build /app/target/*.jar app.jar

# Exposition du port (à adapter selon votre application)
EXPOSE 8080

# Commande de démarrage
ENTRYPOINT ["java", "-jar", "app.jar"]