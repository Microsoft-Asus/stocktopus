.PHONY: all rtm aws gcp auth clean

RTM_NAME='rtm'
AUTH_NAME='oauth'
SERVERLESS_NAME='serverless'
AWS_TAG='AWS'
GCP_TAG='GCP'

setup: 
	mkdir -p ./bin/
all:  rtm aws gcp auth
rtm: setup
	mkdir  -p ./bin/rtm
	CGO_ENABLED=0 GOOS=linux go build -o ./bin/rtm/$(RTM_NAME) ./cmd/rtm/
aws: setup
	mkdir -p ./bin/aws
	CGO_ENABLED=0 GOOS=linux go build -tags $(AWS_TAG) -o ./bin/aws/$(SERVERLESS_NAME) ./cmd/serverless/
	zip  -j ./bin/aws/stocktopus.zip ./build/aws/* ./bin/aws/*
gcp: setup
	mkdir -p ./bin/gcp
	CGO_ENABLED=0 GOOS=linux go build -tags $(GCP_TAG) -o ./bin/gcp/$(SERVERLESS_NAME) ./cmd/serverless/
	zip  -j ./bin/gcp/stocktopus.zip ./build/gcp/* ./bin/gcp/*
auth: setup
	mkdir -p ./bin/auth
	CGO_ENABLED=0 GOOS=linux go build -o ./bin/auth/$(AUTH_NAME) ./cmd/oauth/
	zip -j ./bin/auth/authtopus.zip ./build/authtopus/* ./bin/auth/*
clean:
	rm -r ./bin
