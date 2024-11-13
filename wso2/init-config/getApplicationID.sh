if [ $# -eq 0 ]  
	then
		echo 'No arugment supplied!!!'
		exit 1
	else
		pubToken=`./token-gen.sh publisher $1`
		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:app_manage" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`

		applID=`curl --silent --insecure -k -X GET "$1/api/am/store/v1/applications?limit=25&offset=0" -H "accept: application/json"  -H "Authorization: Bearer $bearerToken" | jq -r '.list[] | select(.name=="PetstoreApp").applicationId'`

		echo "$applID";
fi


