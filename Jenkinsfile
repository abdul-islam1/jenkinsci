pipeline {
    agent any

    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        DOCKERHUB_USERNAME = "abdul1s"
        DOCKERHUB_REPO_NAME = "jenkins-test"

    }
    
    stages {
     
        stage('BUILD DOCKER IMAGE') {
            steps {
                echo 'Building Docker Image...'
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

        stage('CLEAN DOCKER IMAGES') {
            steps {
                sh 'docker rmi ${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO_NAME}:${IMAGE_TAG}'
            }
        }
        stage('TRIGGER NEXT PIPELINE') {
            steps {
               build job: 'cd-config', parameters: [string(name: 'IMAGE_TAG', value: "${IMAGE_TAG}")]
            }
        }



        stage('CLEANING WORKSPACE') {
            steps {
                script {
                    cleanWs()
                }
            }
        }
    }
}