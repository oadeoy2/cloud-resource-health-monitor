pipeline {
    agent any

    environment {
        AWS_REGION        = 'us-east-1'
        BACKEND_REPO      = '478517495773.dkr.ecr.us-east-1.amazonaws.com/cloud-resource-health-monitor-dev-backend'
        FRONTEND_REPO     = '478517495773.dkr.ecr.us-east-1.amazonaws.com/cloud-resource-health-monitor-dev-frontend'
        PROMETHEUS_REPO   = '478517495773.dkr.ecr.us-east-1.amazonaws.com/cloud-resource-health-monitor-dev-prometheus'
        GRAFANA_REPO      = '478517495773.dkr.ecr.us-east-1.amazonaws.com/cloud-resource-health-monitor-dev-grafana'
        NODE_EXPORTER_REPO = '478517495773.dkr.ecr.us-east-1.amazonaws.com/cloud-resource-health-monitor-dev-node-exporter'
        IMAGE_TAG         = "${env.BUILD_NUMBER}"
    }

    options {
        skipStagesAfterUnstable()
    }

    stages {
        stage('Checkout Code') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-token', passwordVariable: 'GIT_TOKEN', usernameVariable: 'GIT_USER')]) {
                    sh 'git clone https://${GIT_USER}:${GIT_TOKEN}@github.com/oadeoy2/cloud-resource-health-monitor.git source'
                }
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-ecr-creds']]) {
                    sh '''
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $BACKEND_REPO
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $FRONTEND_REPO
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $PROMETHEUS_REPO
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $GRAFANA_REPO
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $NODE_EXPORTER_REPO
                    '''
                }
            }
        }

        stage('Build & Push Backend Image') {
            steps {
                dir('source/backend') {
                    sh '''
                        docker build -t backend:$IMAGE_TAG .
                        docker tag backend:$IMAGE_TAG $BACKEND_REPO:$IMAGE_TAG
                        docker push $BACKEND_REPO:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Build & Push Frontend Image') {
            steps {
                dir('source/frontend') {
                    sh '''
                        docker build -t frontend:$IMAGE_TAG .
                        docker tag frontend:$IMAGE_TAG $FRONTEND_REPO:$IMAGE_TAG
                        docker push $FRONTEND_REPO:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Build & Push Prometheus Image') {
            steps {
                dir('source/monitoring/prometheus') {
                    sh '''
                        docker build -t prometheus-monitor:$IMAGE_TAG .
                        docker tag prometheus-monitor:$IMAGE_TAG $PROMETHEUS_REPO:latest
                        docker push $PROMETHEUS_REPO:latest
                    '''
                }
            }
        }

        stage('Build & Push Grafana Image') {
            steps {
                dir('source/monitoring/grafana') {
                    sh '''
                        docker build -t grafana-monitor:$IMAGE_TAG .
                        docker tag grafana-monitor:$IMAGE_TAG $GRAFANA_REPO:latest
                        docker push $GRAFANA_REPO:latest
                    '''
                }
            }
        }

        stage('Build & Push Node Exporter Image') {
            steps {
                dir('source/monitoring/node-exporter') {
                    sh '''
                        docker build -t node-exporter:$IMAGE_TAG .
                        docker tag node-exporter:$IMAGE_TAG $NODE_EXPORTER_REPO:latest
                        docker push $NODE_EXPORTER_REPO:latest
                    '''
                }
            }
        }

        stage('Trigger ECS Redeploy') {
            steps {
                sh '''
                    aws ecs update-service \
                        --cluster cloud-resource-health-monitor-dev-cluster \
                        --service backend-service \
                        --force-new-deployment \
                        --region $AWS_REGION

                    aws ecs update-service \
                        --cluster cloud-resource-health-monitor-dev-cluster \
                        --service frontend-service \
                        --force-new-deployment \
                        --region $AWS_REGION

                    aws ecs update-service \
                        --cluster cloud-resource-health-monitor-dev-cluster \
                        --service prometheus-service \
                        --force-new-deployment \
                        --region $AWS_REGION

                    aws ecs update-service \
                        --cluster cloud-resource-health-monitor-dev-cluster \
                        --service grafana-service \
                        --force-new-deployment \
                        --region $AWS_REGION

                    aws ecs update-service \
                        --cluster cloud-resource-health-monitor-dev-cluster \
                        --service node-exporter-service \
                        --force-new-deployment \
                        --region $AWS_REGION
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
