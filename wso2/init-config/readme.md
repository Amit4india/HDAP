# Document to run wso2 automation

# prerequisites
	1>	Download  and install apictl  from following link “https://wso2.com/api-management/tooling/”. it should be installed in path /usr/local/bin/apictl
	2>	Install JQ using “sudo apt-get install jq”

# Script and input file details
	1)wso2automation.sh -> Master script to run automation.
	2)admin.json -> Input json file for  Admin portal API v 0.16 to configure client secret and client id.
	3)alert.json  -> alert configuration
	4)alert_subscribe.sh -alert subscription shell script
	5)apimediation_policy.xml - > Custom Mediation policy description
	6)automationconfig.json -> master automation configuration file
	7)deletetempfolder.sh -> Shell script for deleting the temp folders.
	8)devportal.json -> Input json file for  DEV portal V1 API to configure client secret and client id.
	9)getapiid.sh -> shell script for getting the API ID
	10)getapiInfo.sh -> shell script for getting the API information
	11)getApplicationID.sh  -> shell script for getting the Application ID
	12)getApplicationInfo.sh  -> shell script for getting the Application Info
	13)mediationpolicy.sh -> shell script for medication policy
	14)petstoreapp.json -> Petstore application description file
	15)publisher.json -> Input json file for  Publisher portal V1 API to configure client secret and client id.
	16)subscription.json -> Subscription description file
	17)swagger.yaml ->  API swagger specification of Petstore.
	18)throttlingpolicy.json -> Throttling description file
	19)throttlingpolicy.sh -> shell script for throttling policy
	20)token-gen.sh -> Script that generate token to access Admin portal v0.16 API,DEV portal v1 API,Publisher portal v1 API.

# Running the WSO2 automation script:
	Step 1> Copy "Scripts" folder to intended folder/directory

	Step 2> Make sure apictl to present in "/usr/local/bin" and has execution permission.

	Step 3> Modify the "automationconfig.json" file as required;
			{
				"publisher_url":"https://localhost:9443", <<WSO2 Publisher URL>>
				"token_url":"https://localhost:8243/token", <<WSO2 Token URL>>
				"username":"admin",  <<WSO2 admin user name>>			
				"password":"admin",  <<WSO2 admin user password>>
				"env_name":"dev",   <<WSO2 envirnoment name where application, API need to be binded>>
				"blocklist_ip":"192.101.1.1"  <<Intended IP addrress that need to blocked for using the APIs>>
			}

	Step 4> Modify the "alert.json" for alerts as needed 
			update the  "emailList" attribute with coma separated list of email id for receiving the alerts.
			

	Step 5> Once above said modification are done run the WSO2 automation script as follows
			
	./wso2automation.sh automationconfig.json 		
			
	Step 6> verify the setting in WSO2 UI; 
			Publisher Portal: https://<<wso64-apim.demos.hclets.com>>/publisher/apis
			Developer Portal: https://<<wso64-apim.demos.hclets.com>>/devportal/apis
			Admin Portal: https://<<wso64-apim.demos.hclets.com>>/admin/site/pages/index.jag
  