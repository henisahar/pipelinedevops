pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'SonarQube_server'  // Ensure that this matches the actual name of your SonarQube installation in Jenkins
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
                script {
                    withSonarQubeEnv('SonarQube_server') {  // Use the correct name of your SonarQube installation in Jenkins
                        bat 'mvn sonar:sonar'  // Running SonarQube analysis; clean package is not needed here since you already built the project
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'MINUTES') {  // Wait for the SonarQube quality gate result
                        waitForQualityGate abortPipeline: true  // Abort the pipeline if the quality gate fails
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
