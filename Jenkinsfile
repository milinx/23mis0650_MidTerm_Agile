pipeline {
    agent any
    
    environment {
        // 1. CHANGE THIS to your actual Docker Hub username
        DOCKER_USER = 'milinxgenix' 
        IMAGE_NAME = 'rivera-web-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls the code from your GitHub repo
                checkout scm
            }
        }

        stage('Docker Build & Push') {
            steps {
                // This block uses the Username/Password you saved in Jenkins
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('K8s Deployment') {
            steps {
                // This assumes your Jenkins is running on the same machine as your K8s (Docker Desktop/Minikube)
                sh "kubectl apply -f deployment.yaml"
            }
        }
    }
}