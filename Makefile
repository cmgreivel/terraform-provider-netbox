test:
	go test -v $(shell go list ./... | grep -v /vendor/)

testacc:
	@echo
	@echo ============================================================
	@echo For tests to work, your NetBox must be configured correctly.
	@echo
	TF_ACC=1 go test -v ./netbox -run="TestAcc"

build: deps
	gox -osarch="linux/amd64 windows/amd64 darwin/amd64" \
	-output="pkg/{{.OS}}_{{.Arch}}/terraform-provider-netbox" .

release: release_bump release_build

release_bump:
	scripts/release_bump.sh

release_build:
	scripts/release_build.sh

deps:
#	go get -u github.com/hashicorp/terraform/plugin

clean:
	rm -rf pkg/
