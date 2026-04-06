pipeline {
    agent any
    
    environment {
        DOCKER_USER = 'milinxgenix' 
        IMAGE_NAME = 'rivera-web-app'
        FULL_IMAGE = "${DOCKER_USER}/${IMAGE_NAME}:${env.BUILD_ID}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    // 1. Build the image
                    bat "docker build -t ${FULL_IMAGE} ."
                    
                    // 2. Login using the -p flag (Better for Windows Batch)
                    bat "docker login -u %USER% -p %PASS%"
                    
                    // 3. Push the image
                    bat "docker push ${FULL_IMAGE}"
                }
            }
        }

        stage('K8s Deployment') {
            steps {
                script {
                    // 1. Swaps the placeholder for the new image tag
                    powershell "(Get-Content deployment.yaml) -replace 'IMAGE_PLACEHOLDER', '${FULL_IMAGE}' | Set-Content deployment.yaml"
                    
                    // 2. REPLACING 'YourUser' WITH YOUR ACTUAL WINDOWS USERNAME (e.g. milin)
                    bat 'kubectl --kubeconfig="C:/Users/milinxgenix/.kube/config" apply -f deployment.yaml'
                }
            }
        }


    }
}
