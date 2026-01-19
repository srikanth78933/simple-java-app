@Library('my-shared-lib') _

pipeline {
    agent any
    tools {
        maven 'maven3.9.9'
        jdk 'java17'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'project-1', url: 'https://github.com/sreekanth78933/simple-java-app.git'
            }
        }

        stage('Build') {
            steps {
                mavenBuild()   // calling shared library function
            }
        }

        stage('Post-Build') {
            steps {
                echo "Build completed successfully using Shared Library."
            }
        }
    }
}

