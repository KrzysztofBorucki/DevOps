Install the following plugins if they are not already installed:
GitHub Integration Plugin: Allows Jenkins to integrate with GitHub repositories.
Azure Web App Plugin: Enables deployment to Azure Web Service.

Step 3: Set Up GitHub Webhook

In your GitHub repository, go to "Settings" > "Webhooks" > "Add webhook."
Set the Payload URL to your Jenkins server URL followed by "/github-webhook/" (e.g., https://your-jenkins-server/github-webhook/).
Set the Content type to "application/json."
Select "Let me select individual events" and choose "Push events."
Save the webhook.

Step 4: Create a New Jenkins Pipeline

In Jenkins, click on "New Item" to create a new pipeline job.
Enter a name for the job and select "Pipeline" as the job type.
Scroll down to the "Pipeline" section and select "Pipeline script from SCM" as the definition.
Choose "Git" as the SCM and provide your GitHub repository URL.
Save the job configuration.

Step 5: Configure Jenkinsfile

In your GitHub repository, create a file named "Jenkinsfile" at the root level.
Add the following content to your Jenkinsfile:

pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'YOUR_BUILD_COMMAND_HERE' // Replace this with your actual build command (e.g., npm install, mvn clean install, etc.).
            }
        }
        
        stage('Test') {
            steps {
                sh 'YOUR_TEST_COMMAND_HERE' // Replace this with your actual test command.
            }
        }
        
        stage('Deploy') {
            steps {
                azureWebAppPublish azureCredentialsId: 'YOUR_AZURE_CREDENTIALS', resourceGroup: 'YOUR_RESOURCE_GROUP', appName: 'YOUR_AZURE_APP_NAME'
            }
        }
    }
}

Step 6: Set Up Azure Credentials in Jenkins

In Jenkins, go to "Manage Jenkins" > "Manage Credentials."
Click on "Jenkins" store.
Click on "Global credentials (unrestricted)" > "Add Credentials."
Enter your Azure credentials (Service Principal) with the necessary permissions to deploy to the Azure Web App.


Step 7: upgrade

pipeline {
    agent any
    tools {
	    maven "MAVEN3"
	    jdk "OracleJDK8"
	}

    environment {
        registryCredential = 'ecr:us-east-2:awscreds'
        appRegistry = "951401132355.dkr.ecr.us-east-2.amazonaws.com/vprofileappimg"
        vprofileRegistry = "https://951401132355.dkr.ecr.us-east-2.amazonaws.com"
        cluster = "vprofile"
        service = "vprofileappsvc"
    }
  stages {
    stage('Fetch code'){
      steps {
        git branch: 'docker', url: 'https://github.com/devopshydclub/vprofile-project.git'
      }
    }


    stage('Test'){
      steps {
        sh 'mvn test'
      }
    }

    stage ('CODE ANALYSIS WITH CHECKSTYLE'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    echo 'Generated Analysis Result'
                }
            }
        }

        stage('build && SonarQube analysis') {
            environment {
             scannerHome = tool 'sonar4.7'
          }
            steps {
                withSonarQubeEnv('sonar') {
                 sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                   -Dsonar.projectName=vprofile-repo \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }

        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }

    stage('Build App Image') {
       steps {
       
         script {
                dockerImage = docker.build( appRegistry + ":$BUILD_NUMBER", "./Docker-files/app/multistage/")
             }

     }
    
    }

    stage('Upload App Image') {
          steps{
            script {
              docker.withRegistry( vprofileRegistry, registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }
          }
     }
     
     stage('Deploy to ecs') {
          steps {
        withAWS(credentials: 'awscreds', region: 'us-east-2') {
          sh 'aws ecs update-service --cluster ${cluster} --service ${service} --force-new-deployment'
        }
      }
     }

  }
}
