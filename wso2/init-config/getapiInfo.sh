if [ $# -eq 0 ] 
	then
		echo 'No arugment supplied!!!'
		exit 1
	else
		pubToken=`./token-gen.sh publisher $1`
		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:api_view" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`

		# echo "Bearer Token : $bearerToken";

		apiInfo=`curl --silent --insecure -X GET "$1/api/am/publisher/v1/apis?limit=25&offset=0" -H "accept: application/json" -H "Accept: application/json" -H "Authorization: Bearer $bearerToken" | jq -r '.list[] | select(.name=="Petstore")'| tr -d '\n\t'`

		echo "$apiInfo";
fi

