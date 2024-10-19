pipeline {
    agent any

    environment {
        // Corrected SonarQube environment to match the installation name 'SonarQube_server'
        SONARQUBE_ENV = 'SonarQube_server'
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
                    bat 'mvn clean package'  // Use 'bat' for Windows, replace with 'sh' for Linux/macOS
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Using the SonarQube environment variable set earlier
                    withSonarQubeEnv(SONARQUBE_ENV) {
                        withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                            bat 'mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN'  // Inject token into the SonarQube command
                        }
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
