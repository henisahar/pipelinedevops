pipeline {
    agent any


    environment {
        SONARQUBE_ENV = 'SonarQube Scanner'
        SONAR_TOKEN = credentials('sonarqube-token')  // Reference the credentials ID you created
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                script {
                    bat 'mvn clean package'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube Scanner') {
                    script {
                        bat "mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN"
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'MINUTES') {
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
        failure {
            echo 'Pipeline failed.'
        }
    }
}
