pipeline {
    agent any 
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_REPO = 'aguevarar29/backend-final-exam'
    }

    stages {
        stage ('Login to Dockerhub') {
            agent {
                docker {
                    image 'docker:latest'
                }
            }
            steps {
                sh '''
                echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                '''
            }
        }

        stage('Install dependencies') {
            steps {
                script {
                    docker.image('node:18-alpine').inside {
                        sh '''
                        echo "Remove old dependencies"
                        rm -rf node_modules package-lock.json
                        npm install
                        '''
                    }
                }
            }
        }

        stage('Build project') {
            steps {
                script {
                    docker.image('node:18-alpine').inside {
                        sh 'npm run build'
                    }
                }
            }
        }

        stage('Build and Push image to dockerhub') {
            steps {
                script {
                    sh '''
                    docker build -t $DOCKER_REPO:latest .
                    docker push $DOCKER_REPO:latest
                    '''
                }
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