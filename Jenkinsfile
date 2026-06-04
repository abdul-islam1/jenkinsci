pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKERHUB_USERNAME = "abdul1s"
        DOCKERHUB_REPO_NAME = "jenkins-test"

    }
    
    stages {
        stage('CLEAN WORKSPACE') {
            steps {
                echo 'Cleaning workspace...'
                deleteDir()
            }
        }
        stage('BUILD DOCKER IMAGE') {
            steps {
                echo 'Building Docker Image...'
                echo 'Building...'
                sh 'docker build -t ${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO_NAME}:${IMAGE_TAG} .'
            }
        }

        stage('DOCKER LOGIN + PUSH') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub',
                        passwordVariable: 'pass',
                        usernameVariable: 'uname'
                    )
                ]) {
                    sh 'echo $pass | docker login -u $uname --password-stdin'
                }

                sh 'docker push ${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO_NAME}:${IMAGE_TAG}'
                sh 'docker logout'
            }
        }

        stage('CLEANUP') {
            steps {
                sh 'docker rmi ${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO_NAME}:${IMAGE_TAG}'
            }
        }
    }
}