# Utiliser une image Maven avec le JDK 17
FROM maven:3.8.6-eclipse-temurin-17 AS build

# Définir le répertoire de travail comme /app
WORKDIR /app

# Copier le fichier pom.xml d'abord pour optimiser le cache Docker
COPY pom.xml .

# Télécharger les dépendances sans copier le code source
RUN mvn dependency:go-offline

# Copier le reste du projet dans le conteneur
COPY . .

# Compiler le projet et créer un fichier .jar, en skippant les tests
RUN mvn clean package -DskipTests

# Définir la commande par défaut pour exécuter Maven en mode debug
CMD ["mvn", "package", "-X"]
