pipeline {
    agent any 
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_REPO = 'aguevarar29/backend-final-exam'
    }

    stages {
        stage ('Install dependencies') {
            agent {
                docker {
                    image 'node:18-alpine'
                }
            }
            steps {
                echo "Remove old dependencies"
                sh 'rm -rf node_modules package-lock.json'
                sh 'npm install'
            }
        }

        stage ('Build project') {
            agent {
                docker { image 'node:18-alpine'}
            }
            steps {
                sh 'npm run build'
            }
        }

        stage('Push image to dockerhub') {
            agent {
                docker {
                    image 'docker:latest'
                }
            }
            steps {
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                docker build -t $DOCKER_REPO:latest .
                docker push $DOCKER_REPO:latest
                '''
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }
    }
}