pipeline{
    agent any
    stages{
        stage('BUILD DOCKER IMAGE'){
             steps{
                echo 'Building Docker Image...'
            }
            steps{
                echo 'Building...'
                 sh 'docker build -t abdul1s/jenkins-test:${BUILD_NUMBER} .'
            }
        }
        stage('DOCKER LOGIN + PUSH'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'uname')]) {
                    sh 'echo $pass | docker login -u $uname --password-stdin'
            }
                    sh 'docker push abdul1s/jenkins-test:${BUILD_NUMBER}'
                    sh 'docker logout'
        }
        stage('CLEANUP'){
            steps{
                sh 'docker rmi abdul1s/jenkins-test:${BUILD_NUMBER}'
            }
        }
    }
}

