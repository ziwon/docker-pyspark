TAG=latest

all: 
	@$(MAKE) clean build push

build: clean
	@./scripts/build.sh $(TAG)

push: build
	@./scripts/push.sh $(TAG)

run: build
	@./scripts/run.sh $(TAG)

clean:
	@./scripts/clean.sh $(TAG)