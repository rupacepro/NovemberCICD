pipeline {
    agent any

    environment {
        // Define environment variables
        DOCKER_IMAGE = "rupacepro/cicd_node_app"
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

        // Stage 3: Run Tests with Jest
        stage('Run Tests') {
            steps {
                script {
                    // Run the tests using Jest
                    docker.image("${DOCKER_IMAGE}").inside {
                        sh 'npm install'
                        sh 'npm test' // Assuming you are using Jest for testing
                    }
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
