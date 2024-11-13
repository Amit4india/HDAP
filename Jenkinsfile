def inputJSONFile
def tempOutputFile = "/tmp/hdap-output-${env.BUILD_NUMBER}.json"

pipeline {

 agent any

    stages {
        stage('readConfig') {
            steps {
                script {
                     inputJSONFile = readJSON file: 'hdap-input.json'
                }				
            }
        }
  
        stage('jenkins') {
            when {
                expression { inputJSONFile['jenkins']['provision'] == 'yes' }
            }		
            steps {
					echo "Starting to create infra for Jenkins"
                    build 'dna-hdap/jenkins-terraform-pipeline'
					sleep 5
					echo "Starting to configure Jenkins on infra provisioned."
                    build job: 'dna-hdap/jenkins-ansible-pipeline', parameters: [string(name: 'PORT', value: "${inputJSONFile['jenkins']['properties']['jenkins_port']}"), string(name: 'USERNAME', value: "${inputJSONFile['jenkins']['properties']['jenkins_username']}"), string(name: 'PASSWORD', value: "${inputJSONFile['jenkins']['properties']['jenkins_password']}"),string(name: 'VERSION', value: "${inputJSONFile['jenkins']['properties']['jenkins_version']}"),string(name: 'outFilePath', value: "${tempOutputFile}")]
                        }
       }
       
        stage('sonar') {
            when {
                expression { inputJSONFile['sonar']['provision'] == 'yes' }
            }		
            steps {
					echo "Starting to create infra for Sonar"
                    build 'dna-hdap/sonar-terraform-pipeline'
					sleep 5
					echo "Starting to configure Sonar on infra provisioned."
                    build job: 'dna-hdap/sonar-ansible-pipeline', parameters: [string(name: 'PORT', value: "${inputJSONFile['sonar']['properties']['sonar_port']}"), string(name: 'USERNAME', value: "${inputJSONFile['sonar']['properties']['sonar_username']}"), string(name: 'PASSWORD', value: "${inputJSONFile['sonar']['properties']['sonar_password']}"),string(name: 'VERSION', value: "${inputJSONFile['sonar']['properties']['sonar_version']}"), string(name: 'out_File_Path', value: "${tempOutputFile}")]
            }
       }

        stage('nexus') {
            when {
                expression { inputJSONFile['nexus']['provision'] == 'yes' }
            }		
            steps {
					echo "Starting to create infra for Nexus"
                    build 'dna-hdap/nexus-terraform-pipeline'
					sleep 5
					echo "Starting to configure Nexus on infra provisioned."
					build job: 'dna-hdap/nexus-ansible-pipeline', parameters: [string(name: 'PORT', value: "${inputJSONFile['nexus']['properties']['nexus_port']}"), string(name: 'USERNAME', value: "${inputJSONFile['nexus']['properties']['nexus_username']}"), string(name: 'PASSWORD', value: "${inputJSONFile['nexus']['properties']['nexus_password']}"),string(name: 'VERSION', value: "${inputJSONFile['nexus']['properties']['nexus_version']}"), string(name: 'out_File_Path', value: "${tempOutputFile}")]
            }
       }
       
        stage('kubernetes') {
            when {
                expression { inputJSONFile['kubernetes']['provision'] == 'yes' }
            }		
            steps {
                script {
                    echo "Starting to provision kubernetes."
					build job: 'dna-hdap/kubernetes-cluster-setup-pipeline', parameters: [string(name: 'Name', value: "${inputJSONFile['kubernetes']['properties']['cluster_name']}"), string(name: 'masterCount', value: "${inputJSONFile['kubernetes']['properties']['master_nodes_count']}"), string(name: 'masterType', value: "${inputJSONFile['kubernetes']['properties']['master_nodes_spec']}"),string(name: 'nodeCount', value: "${inputJSONFile['kubernetes']['properties']['nodes_count']}"),string(name: 'nodeType', value: "${inputJSONFile['kubernetes']['properties']['nodes_spec']}"),string(name: 'KOPS_STATE_STORE', value: "${inputJSONFile['kubernetes']['properties']['kops_state_store']}"),string(name: 'retryCounter', value: "${inputJSONFile['kubernetes']['properties']['retryCounter']}")]					
					sleep 5
                }
            }
       }
       
	   stage('kubernetes ingress') {
            when {
                expression { inputJSONFile['kubernetes']['ingress']['provision'] == 'yes' }
            }		
            steps {
                script {
					echo "Starting to provision kubernetes ingress controller."
					build 'dna-hdap/kubernetes-ingress-controller-pipeline'
					sleep 5
                }
            }
       }	 
	   
        stage('kubernetes dashboard') {
            when {
                expression { inputJSONFile['kubernetes']['dashboard']['provision'] == 'yes' }
            }		
            steps {
                script {
                    echo "Starting to provision kubernetes dashboard."
 				    build 'dna-hdap/kubernetes-dashboard-pipeline'
					sleep 5
                }
            }
       }	   

        stage('kubernetes istio') {
            when {
                expression { inputJSONFile['kubernetes']['istio']['provision'] == 'yes' }
            }		
            steps {
                script {
                    echo "Starting to provision istio  on kubernetes."
				    build 'dna-hdap/kubernetes-istio-pipeline'
					sleep 5
                }
            }
       }	   	   
	   
        stage('wso2') {
            when {
                expression { inputJSONFile['wso2']['provision'] == 'yes' }
            }
            steps {
                echo 'provision wso2'
				build job: 'dna-hdap/k8s-wso2-pipeline', parameters: [string(name: 'REPLICAS', value: "${inputJSONFile['wso2']['properties']['replicas']}"), string(name: 'NODE_IP', value: "${inputJSONFile['wso2']['properties']['node_ip']}"), string(name: 'outFilePath', value: "${tempOutputFile}")]
                sleep 5
            }
        }

        stage('elk') {
            when {
                expression { inputJSONFile['elk']['provision'] == 'yes' }
            }
            steps {
                echo 'provision elk-pipeline on kubernetes'
				build job: 'dna-hdap/k8s-elk-pipeline', parameters: [string(name: 'replicas', value: "${inputJSONFile['elk']['properties']['replicas']}"), string(name: 'outFilePath', value: "${tempOutputFile}")]
                sleep 5
            }
        }

        stage('prometheus') {
            when {
                expression { inputJSONFile['prometheus']['provision'] == 'yes' }
            }		
            steps {
                      echo 'provision prometheus'
            }
       }
        stage('adc') {
            when {
                expression { inputJSONFile['hcl-app']['adc']['provision'] == 'yes' }
            }		
			
            steps {
				
				echo 'provision Jenkins on kubernetes'
				build job: 'dna-hdap/k8s-jenkins-pipeline', parameters: [string(name: 'replicas', value: "${inputJSONFile['hcl-app']['adc']['properties']['replicas']}"), string(name: 'outFilePath', value: "${tempOutputFile}")]
                sleep 10
				
				echo 'provision Sonar on kubernetes'
				build job: 'dna-hdap/k8s-sonar-pipeline', parameters: [string(name: 'replicas', value: "${inputJSONFile['hcl-app']['adc']['properties']['replicas']}"), string(name: 'outFilePath', value: "${tempOutputFile}")]
                sleep 10
				
				echo 'provision Nexus on kubernetes'
				build job: 'dna-hdap/k8s-nexus-pipeline', parameters: [string(name: 'replicas', value: "${inputJSONFile['hcl-app']['adc']['properties']['replicas']}"), string(name: 'outFilePath', value: "${tempOutputFile}")]
                sleep 10
				
                echo 'provision ADC on kubernetes'
				build job: 'dna-hdap/k8s-adc-pipeline', parameters: [string(name: 'replicas', value: "${inputJSONFile['hcl-app']['adc']['properties']['replicas']}"), string(name: 'outFilePath', value: "${tempOutputFile}")]
                sleep 10
            }
			
       }	   
       stage('Output Config') {
            steps {
					echo "committing hdap-output to git"
					sh '''
					echo "Consolidating the output from all the executions"
					 #cp  ${tempOutputFile} ${WORKSPACE}/pib-output.json
					 #git add ${WORKSPACE}/hdap-output.json
					 #git commit -m "added the hdap-output.json file"
					 #git push
					 '''
				}
			}
    }
}