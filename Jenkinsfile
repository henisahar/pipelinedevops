pipeline {
    agent any

    tools {
        maven 'Maven 3.x'   // Assuming you have a Maven tool configured as 'Maven 3.x'
        jdk 'JDK 17'        // Assuming JDK 17 is configured as 'JDK 17'
    }

    environment {
        SONARQUBE_ENV = 'SonarQube Scanner'  // Ensure that this matches the actual name of your SonarQube installation
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm  // Checkout the source code from the repository
            }
        }

        stage('Build') {
            steps {
                script {
                    echo 'Building the project...'
                    bat 'mvn clean package'  // Use 'sh' for Linux/macOS, 'bat' is for Windows
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube Scanner') {  // Use the environment variable for SonarQube
                    script {
                        bat 'mvn sonar:sonar'  // Run only SonarQube analysis without rebuilding
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'MINUTES') {  // Wait for the SonarQube quality gate result
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
    }
}
