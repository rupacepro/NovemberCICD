pipeline {
    agent any

    environment {
        // Define environment variables
        DOCKER_IMAGE = "rupacepro/cicd_node_app"
        dockerhub_credentials = credentials('rupacepro-dockerhub')
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
                    docker.build("${DOCKER_IMAGE}:${BUILD_ID}")
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

        // // Stage 3: Run Tests with Jest
        // stage('Run Tests') {
        //     steps {
        //         script {
        //             // Run the tests inside the container using the updated path
        //             bat """
        //                 docker run --rm -t -v C:/Users/rupac/Desktop/DevOps:/workspace \
        //                 -w /workspace \
        //                 cicd_node_app npm test
        //             """
        //         }
        //     }
        // }


       // Stage 5: Push Docker Image to Docker Hub
        stage('Push Docker Image') {
            steps {
                script {
                    // Access DockerHub credentials securely from Jenkins
                    withCredentials([usernamePassword(credentialsId: 'rupacepro-dockerhub', 
                                                       usernameVariable: 'DOCKER_USERNAME', 
                                                       passwordVariable: 'DOCKER_PASSWORD')]) {
                        
                        // Login to Docker Hub using credentials
                        bat """
                        echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
                        """
                    }

                    // Push the Docker image to Docker Hub
                    bat "docker push ${DOCKER_IMAGE}:${BUILD_ID}"
                }
            }
        }





        // // Stage 5: Deploy Application (Optional)
        // stage('Deploy') {
        //     steps {
        //         script {
        //             // Add steps to deploy your app (could be Kubernetes, AWS, etc.)
        //             echo 'Deploying the app to production...'
        //         }
        //     }
        // }
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
