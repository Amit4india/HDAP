if [ $# -eq 0 ] 
	then
		echo 'No arugment supplied!!!'
		exit 1
	else
		pubToken=`./token-gen.sh publisher $1`
		bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:api_view" -H "Authorization: Basic $pubToken" $2 | jq -r '.access_token'`
		if [ -z "$bearerToken" ]
                then
                        echo "Bearer token  is  empty"
                        exit 1
                fi

		 #echo "Bearer Token : $bearerToken";

		apiID=`curl --silent --insecure -X GET "$1/api/am/publisher/v1/apis?limit=25&offset=0" -H "accept: application/json" -H "Accept: application/json" -H "Authorization: Bearer $bearerToken" | jq -r '.list[] | select(.name=="Petstore").id'`

		echo "$apiID";
fi

