pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "willstopher/case-study-1"
        CONTAINER_NAME = "case-study-1-container"
        STUB_VALUE = "200"
    }
   
    stages {
        stage('Clone') {
            steps {
                script {
                    sh 'rm -rf 2020_03_DO_Boston_casestudy_part_1'
                    sh 'git clone https://github.com/willstopher817/2020_03_DO_Boston_casestudy_part_1.git'
                }
            }
        }
        
        stage('Build') {
            steps {
                //  Building new image
                dir('2020_03_DO_Boston_casestudy_part_1') {
                    sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
                    sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'
                }


                //  Pushing Image to Repository
                 withCredentials([usernamePassword(credentialsId: 'case-study-1', usernameVariable: 'USER1', passwordVariable: 'PASS1')]) {
                    sh 'docker login -u "$USER1" -p "$PASS1"'
                }
                sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
                sh 'docker push $DOCKER_HUB_REPO:latest'
                
                echo "Image built and pushed to repository"
            }
        }

        stage('Setup') {
            steps {
                script {
		    dir('2020_03_DO_Boston_casestudy_part_1') {
                        ansiblePlaybook(playbook: 'ansible-playbook-setup.yaml')
                    }
                }
            }
        }

    }
}
