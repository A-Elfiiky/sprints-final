pipeline {
    agent any
    stages {
        stage('Checkout external proj 🙈🙈🙈') {
            steps {
                git url: 'https://github.com/A-Elfiiky/sprints-final.git', branch: 'main' , credentialsId: 'github'
            }
        }
        stage('Build Docker image Python app and push to ecr 🚚📌') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/flask_app/FlaskApp/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 612386077301.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t python_app:app_"$BUILD_NUMBER" .
                    docker tag python_app:app_"$BUILD_NUMBER" 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"
                    docker push 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"
                    '''
                }
            }
        }
        stage('Build Docker image mysql and push to ecr 🚚📌') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/flask_app/db/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 612386077301.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t python_db:db_"$BUILD_NUMBER" .
                    docker tag python_db:db_"$BUILD_NUMBER" 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"
                    docker push 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"
                    '''
                }
            }
        }

        stage('Apply Kubernetes files 🚀 🎉 ') {
            steps{
            withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                script {
                    sh '''
                    sed -i \"s|image:.*|image: 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"|g\" `pwd`/kubernetes_manifest_file/deployment_flaskapp.yml
                    sed -i \"s|image:.*|image: 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"|g\" `pwd`/kubernetes_manifest_file/statefulSet_flaskdb.yml
                    aws eks --region us-east-1 update-kubeconfig --name eks
                    kubectl apply -f $PWD/kubernetes_manifest_file
                    '''
                }
            }
        }
        stage('INGRESS and LB URL 🚀 🎉 ') {
            steps{       
                script { 
                    sh '''
                    echo "LB SVC URL 🎉 🎉 🎉"
                    echo $(kubectl get svc flask-service-lb -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'):5002
                    echo "INGRESS URL 🎉 🎉 🎉"
                    echo $(kubectl get ingress ingress-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
                    '''
                }
            }
        }
    }
}

