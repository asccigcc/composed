# Interact with Dynamo DB

create:
 aws dynamodb create-table --endpoint-url http://dynamo:8000 --cli-input-json file:///ruby/src/github.com/dev-gems/dynamodb/create.json
