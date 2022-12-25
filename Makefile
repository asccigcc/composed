NAME=dev
SRC=github.com
TAG=dev-gems

# Build the development Docker file
build:
	docker build \
		-f dockerfile/Dockerfile \
		--tag=$(TAG) \
		--no-cache \
		--build-arg BUNDLE_GITHUB__COM \
		--build-arg GITHUB_ACCESS_TOKEN .

rm:
	docker image rm $(TAG)

up:
	docker-compose up $(NAME)

down:
	docker-compose down

bash:
	docker-compose exec -w /ruby/src/$(SRC)/$(TAG) dev zsh

# DynamoDB interaction
# Run inside the container shell
create:
	aws dynamodb create-table --endpoint-url http://dynamo:8000 --cli-input-json file:///ruby/src/github.com/dev-gems/dynamodb/create.json

seed:
	aws dynamodb batch-write-item --endpoint-url http://dynamo:8000 --cli-input-json file:///ruby/src/github.com/dev-gems/dynamodb/seed.json

delete:
	aws dynamodb --endpoint-url http://dynamo:8000 delete-table --table-name lms_users
