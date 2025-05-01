pipeline {
    agent any
    stages {
        stage("Git Checkout") {
            steps {
                git branch: 'dev', url: 'https://github.com/Abdel1117/Maven', credentialsId: 'git-hub-cred'
            }
        }
        stage("Build de l'application") {
            steps {
                bat 'mvn clean install'
            }
        }
        stage("Execution des Tests Unitaire") {
            steps {
                bat 'mvn test'
            }
        }
        stage('Build the Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhubId', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'docker images'
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker build -t abdel11117/mavenmini:latest .'
                    bat 'docker push abdel11117/mavenmini:latest'
                }
            }
        }
    }
   post {
    success {
        script {
            emailext(
                body: 'Job accompli avec succès',
                subject: 'Job accompli avec succès',
                to: 'abderahmane.adjali@live.fr'
            )
        }
    }
    failure {
        script {
            emailext(
                body: 'Job échoué',
                subject: 'Job échoué',
                to: 'abderahmane.adjali@live.fr'
            )
        }
    }
}
}
