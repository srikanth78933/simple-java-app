pipeline {
    agent any

    tools {
        maven 'maven3.9.16'
        jdk 'java21'
    }

    environment {
        DOCKER_IMAGE = 'devopstraining064/project4-demo-dockerimage'
        IMAGE_TAG    = "${env.BUILD_NUMBER}"
        EKS_CLUSTER  = 'mycompany-dev-eks'
        AWS_REGION   = 'us-east-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'project-7', url: 'https://github.com/srikanth78933/simple-java-app.git'
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn versions:set -DnewVersion=1.0.$BUILD_NUMBER -DgenerateBackupPoms=false'
                sh 'mvn clean package'
            }
        }

        stage('Deploy JAR to Nexus') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'nexus-credentials', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                    writeFile file: 'settings.xml', text: """<settings>
  <servers>
    <server>
      <id>nexus-releases</id>
      <username>${NEXUS_USER}</username>
      <password>${NEXUS_PASS}</password>
    </server>
  </servers>
</settings>"""
                    sh 'mvn deploy -s settings.xml'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$IMAGE_TAG .'
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/') {
                    sh 'docker push $DOCKER_IMAGE:$IMAGE_TAG'
                }
            }
        }

        stage('Deploy to EKS with Helm') {
            steps {
                sh '''
                    echo "Setting up kubeconfig"
                    aws eks update-kubeconfig --region $AWS_REGION --name $EKS_CLUSTER

                    echo "Installing/upgrading Helm release"
                    helm upgrade --install simple-java-app ./helm-chart/simple-java-app \
                        --set image.repository=$DOCKER_IMAGE \
                        --set image.tag=$IMAGE_TAG
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check error logs.'
        }
    }
}
