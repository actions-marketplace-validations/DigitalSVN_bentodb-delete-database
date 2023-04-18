#!/bin/sh -l

# Exit immediately if a command exits with a non-zero status
set -e

API_TOKEN=$1
DATABASE_ID=$2

if [ -z "$API_TOKEN" ]; then
  echo "API_TOKEN is required - Get your FREE API token at https://www.bentodb.com"
  exit 1
fi

if [ -z "$DATABASE_ID" ]; then
  echo "DATABASE_ID is required - Create a database using the Create Database action https://github.com/DigitalSVN/bentodb-create-database"
  exit 1
fi

echo "Deleting database..."

http_response_code=$(curl --silent --write-out "%{http_code}" --output response.txt \
  -X POST \
  --url "https://www.bentodb.com/api/databases/$API_TOKEN/delete" \
  -H "Accept: application/json" \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $API_TOKEN")

response_content=$(cat response.txt)

content_message=$(echo $response_content | jq -r '.message')
content_error=$(echo $response_content | jq -r '.error')

content_database_id=$(echo $response_content | jq -r '.data.id')
content_database_name=$(echo $response_content | jq -r '.data.name')

rm response.txt

if [[ "$http_response_code" != "200" && "$http_response_code" != "201" ]]; then
  printf "Code:$http_response_code\nMessage:$content_message\nError:$content_error"
  exit 1
fi

# Return these values to the action
echo "database_id=$content_database_id" >> $GITHUB_OUTPUT
echo "database_name=$content_database_name" >> $GITHUB_OUTPUT

# Output the message
printf "Code:$http_response_code\nMessage:$content_message\nError:$content_error"
