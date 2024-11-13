tokenType=$1

#echo "URL :$2"
#echo "tokentype : $1"

case "$tokenType" in 

#case 1 
    "admin")
 
clientidadmin=`curl --silent -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @admin.json $2/client-registration/v0.16/register| jq -r '.clientId'`
 
clientsecretidadmin=`curl --silent -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @admin.json $2/client-registration/v0.16/register| jq -r '.clientSecret'`

#echo "clientidadmin: $clientidadmin"; 
#echo "clientsecretidadmin:$clientsecretidadmin";

adminToken=`echo -n "$clientidadmin:$clientsecretidadmin" | base64`
echo $adminToken;;

#case 2 
    "publisher") 
clientidpublisher=`curl --silent -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @publisher.json $2/client-registration/v0.16/register| jq -r '.clientId'`

clientsecretidpublisher=`curl --silent -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @publisher.json $2/client-registration/v0.16/register| jq -r '.clientSecret'`
 
#echo "clientidpublisher: $clientidpublisher";
#echo "clientsecretidpublisher: $clientsecretidpublisher";

publisherToken=`echo -n "$clientidpublisher:$clientsecretidpublisher" | base64`
echo $publisherToken;;


#case 2 
    "developper") 
clientiddevportal=`curl --silent -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @devportal.json $2/client-registration/v0.16/register| jq -r '.clientId'`
 
clientsecretiddevportal=`curl --silent -k -X POST -H "Authorization: Basic YWRtaW46YWRtaW4=" -H "Content-Type: application/json" -d @devportal.json $2/client-registration/v0.16/register| jq -r '.clientSecret'`

#echo "clientiddevportal: $clientiddevportal";
#echo "clientsecretiddevportal: $clientsecretiddevportal";

devportalToken=`echo -n "$clientiddevportal:$clientsecretiddevportal" | base64`
echo $devportalToken;;
esac
