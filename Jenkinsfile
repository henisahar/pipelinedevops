pipeline {
    agent any

    environment {
        SONARQUBE_ENV = 'SonarQube_server'
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
                    echo 'Building the project...'
                    bat 'mvn clean package'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv(SONARQUBE_ENV) { 
                        bat 'mvn sonar:sonar'
                    }
                }
            }
        }

        stage('Deploying App to Kubernetes') {
            steps {
                script {
                    echo 'Deploying to Kubernetes...'
                    kubernetesDeploy(configs: "Deployment.yaml", kubeconfigId: "kubernetes")
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
