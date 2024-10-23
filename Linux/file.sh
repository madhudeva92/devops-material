#!/bin/bash
url=$1
while true; do
   response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
   if [ "$response" -eq 200 ]; then
       echo "Received 200 OK response. Exiting."
       break
   elif [ "$response" -ge 300 ] && [ "$response" -lt 400 ]; then
       echo "Received $response Redirect. Following..."
       url=$(curl -s -L -o /dev/null -w "%{url_effective}" "$url")
   else
       echo "Received $response response. Retrying..."
   fi
   sleep 1  # Add a delay between requests to avoid excessive requests
done
