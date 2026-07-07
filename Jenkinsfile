pipeline {

    agent any

    environment {
        IMAGE_NAME = "task-tracker"
        CONTAINER_NAME = "task-tracker-app"
    }

    stages {

        stage('SCM Pull') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Deploy using Docker Compose') {
            steps {
                sh '''
                    docker-compose down || true
                    docker-compose up -d
                '''
            }
        }


        stage('Cleanup') {
            steps {
                sh '''
                    docker image prune -f
                '''
            }
        }

    }

    post {

        success {
            echo 'Pipeline completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }

        always {
            echo 'Pipeline execution finished.'
        }

    }

}

