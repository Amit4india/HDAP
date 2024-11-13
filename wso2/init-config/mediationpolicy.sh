if [ $# -eq 0 ] 
	then
		echo 'No arugment supplied!!!'
		exit 1
	else
		echo "$1,$2,$3,$4,$5"
		apiID=$5
		
		pubToken=`./token-gen.sh publisher $1`
		
		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:mediation_policy_view" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`

		curl --insecure -X GET "$1/api/am/publisher/v1/apis/$apiID/mediation-policies?limit=25&offset=0" -H "accept: application/json" -H "Authorization: Bearer $bearerToken"

		printf "\n"

		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:mediation_policy_create" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`

		curl --insecure -X POST "$1/api/am/publisher/v1/apis/$apiID/mediation-policies" -H "accept: application/json" -H "Authorization: Bearer $bearerToken" -H "Content-Type: multipart/form-data" -F "mediationPolicyFile=@apimediation_policy.xml;type=application/xml" -F "type=in"

		printf "\nAfter setting mediation policy\n"

		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:mediation_policy_view" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`


		curl --insecure -X GET "$1/api/am/publisher/v1/apis/$apiID/mediation-policies?limit=25&offset=0" -H "accept: application/json" -H "Authorization: Bearer $bearerToken"

		printf "\n"
fi

