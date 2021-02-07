pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "habboubi/flaskapp"
        NAME = "flaskapp"
        STUB_VALUE = "200"
    }
   
    stages {
        stage('Clone') {
            steps {
                script {
                    sh 'rm -rf docker-ansible-jenkins-kube'
                    sh 'git clone git clone --single-branch --branch config https://github.com/jhabboubi/docker-ansible-jenkins-kube.git'
                }
            }
        }
        
        stage('Build') {
            steps {
                //  Building new image
                dir('docker-ansible-jenkins-kube') {
                    sh 'docker image build -t $DOCKER_HUB_REPO/$NAME:latest .'
                    //sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'
                }


                //  Pushing Image to Repository
                 withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER1', passwordVariable: 'PASS1')]) {
                    sh 'docker login -u "$USER1" -p "$PASS1"'
                }
                //sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
                sh 'docker push $DOCKER_HUB_REPO:latest'
                
                echo "Image built and pushed to repository"
            }
        }

    }
}
