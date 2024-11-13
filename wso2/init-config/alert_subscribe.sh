if [ $# -eq 0 ]  
	then
		echo 'No arugment supplied!!!'
		exit 1
	else
		pubToken=`./token-gen.sh publisher $1`
		
		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:pub_alert_manage" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`
		
		curl --insecure -X PUT "$1/api/am/publisher/v1/alert-subscriptions" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $bearerToken" -d @alert.json
		
		printf "\n"
fi

