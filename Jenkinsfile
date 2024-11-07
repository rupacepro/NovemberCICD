pipeline {
    agent any

    environment {
        // Define environment variables
        DOCKER_IMAGE = "cicd_node_app"
    }

    stages {
        // Stage 1: Clone Repository from GitHub
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // Stage 2: Build Docker Image
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Verify Docker Image') {
            steps {
                script {
                    // List all Docker images to verify the image is built
                    bat 'docker images'
                }
            }
        }

        // Stage 3: Run Tests with Jest
        stage('Run Tests') {
            steps {
                script {
                    // Running the Docker container and executing Jest tests
                    bat """
                        docker run --rm -t -v C:/ProgramData/Jenkins/.jenkins/workspace/NodeCI_CD_Pipeline:/workspace \
                        -w /workspace \
                        rupacepro/cicd_node_app npm test
                    """
                }
            }
        }

        // Stage 4: Push Docker Image to Docker Hub (Optional)
        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                    
                    // Push the image to Docker Hub
                    docker.image("${DOCKER_IMAGE}").push()
                }
            }
        }

        // Stage 5: Deploy Application (Optional)
        stage('Deploy') {
            steps {
                script {
                    // Add steps to deploy your app (could be Kubernetes, AWS, etc.)
                    echo 'Deploying the app to production...'
                }
            }
        }
    }

    post {
        success {
            echo "CI/CD pipeline succeeded!"
        }
        failure {
            echo "CI/CD pipeline failed."
        }
    }
}
