pipeline {
    agent {
        label 'pulumi'
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm i'
            }
        }
        stage('Deploy pulumi') {
            environment {
                PATH = "$PATH:$HOME/.pulumi/bin"
                PULUMI_ACCESS_TOKEN =  credentials('pulumi-access-token')
                ARM_CLIENT_SECRET = credentials('aws-sela-secret')
                ARM_SUBSCRIPTION_ID = credentials('aws-id')
            }
            steps {
                sh 'chmod +x scripts/*.sh'
                sh 'sh scripts/run-pulumi.sh cicd us-east-1'
            }
        }
    }
}