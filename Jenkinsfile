// Uses Declarative syntax to run commands inside a container.
pipeline {
    triggers {
        pollSCM("*/5 * * * *")
    }
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
  containers:
  - name: docker
    image: quay.imanuel.dev/dockerhub/library---docker:stable
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
'''
            defaultContainer 'node'
        }
    }
    stages {
        stage('Push') {
            steps {
                container('docker') {
                    sh "docker build -t quay.imanuel.dev/imanuel/budget:$BUILD_NUMBER ."
                    withDockerRegistry(credentialsId: 'quay.imanuel.dev', url: 'https://quay.imanuel.dev') {
                        sh "docker push quay.imanuel.dev/imanuel/budget:$BUILD_NUMBER"
                    }
                }
            }
        }
    }
}
