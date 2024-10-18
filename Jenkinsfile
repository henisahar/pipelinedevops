pipeline {
    agent any
    
    stages {
        stage('Cloning Code') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Project') {
            steps {
                script {
                    echo 'Building the Project...'
                    bat 'mvn clean package'
                }
            }
        }
    }
}
