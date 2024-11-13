echo '########################### WSO2 Automation Script started... ##################################'
if [ $# -eq 0 ] 
	then
		echo 'Configuration file argument missing!!!'
		exit 1
fi
		configfile=$(realpath "$1")
		echo "Config File : $configfile"
		if [ -f "$configfile" ] 
		then
				echo "automation config json file found....."
		else
				echo "automation config json file does not exists!!!"
				exit 1
		fi
		publisher_url=`jq -r '.publisher_url' $1`
		token_url=`jq -r '.token_url' $1`
		username=`jq -r '.username' $1`
		password=`jq -r '.password' $1`
		env_name=`jq -r '.env_name' $1`
		blocklist_ip=`jq -r '.blocklist_ip' $1`

		echo "publisher_url :$publisher_url"
		echo "token_url :$token_url"
		echo "username :$username"
		echo "password :$password"
	#	echo '########################### Deleting temp folder ##################################'
	#	`./deletetempfolder.sh`
		echo '########################### Creating environment ##################################'
		/usr/local/bin/apictl add-env -e $env_name --apim $publisher_url --token $token_url
		echo '########################### Installing API ##################################'
		/usr/local/bin/apictl init PetStore --oas swagger.yaml --initial-state=PUBLISHED -f
		echo '########################### Login environment ##################################'
		/usr/local/bin/apictl login $env_name -u $username -p $password -k
		echo '########################### Importing API ##################################'
		/usr/local/bin/apictl import-api -e $env_name -f PetStore/ -k --update

		echo "########################### Create Application ##################################"
		
		pubToken=`./token-gen.sh publisher $publisher_url`
		adminToken=`./token-gen.sh admin $publisher_url`
		devToken=`./token-gen.sh developper $publisher_url`
		echo "============================================================================="
		echo "pubToken : :::$pubToken:::"
	        echo "adminToken ::::$adminToken::"
	        echo "devToken  : :::$devToken::"
		echo "============================================================================="
		bearerToken=`curl --silent -k -d "grant_type=password&username=$username&password=$password&scope=apim:app_manage" -H "Authorization: Basic $pubToken" $token_url | jq -r '.access_token'`
		#echo "bearerToken  :::: $bearerToken"

		if [ -z "$bearerToken" ]
		then
      			echo "\$bearerToken bewrer token is  empty"
			exit 1
		fi

		curl --silent --insecure -k -X POST "$publisher_url/api/am/store/v1/applications" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $bearerToken" --data @petstoreapp.json 

		printf "\n"

		echo "########################### Subscription attach ##################################"
		apiID=`./getapiid.sh $publisher_url $token_url $username $password`
		appID=`./getApplicationID.sh $publisher_url $token_url $username $password`
		appInfo=`./getApplicationInfo.sh $publisher_url $token_url $username $password`
		apiInfo=`./getapiInfo.sh $publisher_url $token_url $username $password`
		
		if [ -z "$apiID" ]
                then
                        echo "API ID is  empty"
                        exit 1
                fi


		echo "$apiID -> $appID -> $appInfo  -> $apiInfo"	


		subscriptionfile="subscription.json"
		if [ -f "$subscriptionfile" ] 
		then
				echo "Subscription json file found....."
		else
				echo "Subscription json file does not exists!!!"
				exit 1
		fi

		contents="$(jq -r --arg ts "$appID" '.applicationId=$ts' subscription.json)" && \
		echo "${contents}" > subscription.json

		contents="$(jq -r --arg ts "$apiID" '.apiId=$ts' subscription.json)" && \
		echo "${contents}" > subscription.json


		contents="$(jq -r --argjson ts "$appInfo" '.applicationInfo=$ts' subscription.json)" && \
		echo "${contents}" > subscription.json

		contents="$(jq -r --argjson ts "$apiInfo" '.apiInfo=$ts' subscription.json)" && \
		echo "${contents}" > subscription.json
		
		contents="$(jq -M 'del(.apiInfo.workflowStatus)' subscription.json)" && \
		echo "${contents}" > subscription.json

		contents="$(jq -M 'del(.apiInfo.hasThumbnail)' subscription.json)" && \
                echo "${contents}" > subscription.json

		contents="$(jq -M 'del(.apiInfo.securityScheme)' subscription.json)" && \
                echo "${contents}" > subscription.json


	bearerToken=`curl -k -d "grant_type=password&username=$username&password=$password&scope=apim:subscribe" -H "Authorization: Basic $devToken" $token_url | jq -r '.access_token'`	

		echo "Subscription brarer token : $bearerToken"
		curl --insecure -X POST "$publisher_url/api/am/store/v1/subscriptions" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $bearerToken" --data @subscription.json 
		
		
		echo "########################### GET SUBSCRIPTION ###########################"

		bearerToken=`curl --silent -k -d "grant_type=password&username=$username&password=$password&scope=apim:subscription_view" -H "Authorization: Basic $pubToken" $token_url | jq -r '.access_token'`

		curl --insecure -X GET "$publisher_url/api/am/publisher/v1/subscriptions?apiId=$apiID" -H "accept: application/json" -H "Authorization: Bearer $bearerToken"

		printf "\n"
		
		echo '##################Discovering API###############################'
		/usr/local/bin/apictl --insecure list apis -e $env_name

		echo "########################### Monetization attach ###########################"
		bearerToken=`curl -k -d "grant_type=password&username=$username&password=$password&scope=apim:api_publish" -H "Authorization: Basic $pubToken" $token_url | jq -r '.access_token'`

		curl --insecure -X POST "$publisher_url/api/am/publisher/v1/apis/$apiID/monetize" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"enabled\": true, \"properties\": { \"additionalProp1\": \"string\", \"additionalProp2\": \"string\", \"additionalProp3\": \"string\" }}" -H "Authorization: Bearer $bearerToken"

		printf "\n"

		echo "########################### Create Blacklist throttling properties ###########################"

		bearerToken=`curl --silent -k -d "grant_type=password&username=$username&password=$password&scope=apim:bl_manage" -H "Authorization: Basic $adminToken" $token_url | jq -r '.access_token'`
		
		echo "Blacklist bearer token : $bearerToken"

		curl --insecure -X POST "$publisher_url/api/am/admin/v0.16/throttling/blacklist" -H "accept: application/json" -H "Content-Type: application/json" -d @blacklist.json -H "Authorization: Bearer $bearerToken"

		printf "\n"

		echo "########################### API Mediation Policies ###########################"
		
		./mediationpolicy.sh $publisher_url $token_url $username $password $apiID

		echo "########################### Throttling Policy ###########################"
		./throttlingpolicy.sh $publisher_url $token_url $username $password

		echo "########################### Alert Subscription ###########################"
		./alert_subscribe.sh $publisher_url $token_url $username $password

