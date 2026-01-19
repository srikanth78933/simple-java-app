def call() {
    stage('Build using Shared Library') {
        echo "Running Maven build from Shared Library..."
        sh 'mvn clean package'
    }
}

