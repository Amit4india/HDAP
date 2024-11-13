if [ $# -eq 0 ]
       then
       echo 'No arugment supplied!!!'
       exit 1
       else
	#bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:tier_view" -H "Authorization: Basic V0k5SkZrNmxnZWRoeVk0T0Vlblg3djdZSktrYTpHTVh6M1hCbEt6U3U2RzZpTXZBN2dFMDRIWUFh" $2 | jq -r '.access_token'`

	#curl --insecure -X GET "$1/api/am/admin/v0.17/throttling/policies/advanced" -H "accept: application/json" -H "Accept: application/json" -H "Authorization: Bearer $bearerToken"
	adminToken=`./token-gen.sh admin $1`
	
	bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:tier_manage" -H "Authorization: Basic $adminToken" $2 | jq -r '.access_token'`

       curl --insecure -k -X POST "$1/api/am/admin/v0.16/throttling/policies/advanced" -H "accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer $bearerToken" -d @throttlingpolicy.json
	
       bearerToken=`curl --silent -k -d "grant_type=password&username=$3&password=$4&scope=apim:tier_view" -H "Authorization: Basic $adminToken" $2 | jq -r '.access_token'`

       curl --insecure -X GET "$1/api/am/admin/v0.16/throttling/policies/advanced" -H "accept: application/json" -H "Accept: application/json" -H "Authorization: Bearer $bearerToken"
     printf "\n"
fi     
