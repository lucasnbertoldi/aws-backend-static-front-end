
env="FOLDER=$(args)\nEXEC_USER=1000\nEXEC_GROUP=1000"

v:
	echo $(env) > .env
	docker-compose up terraform-version
i:
	echo $(env) > .env
	docker-compose up terraform-init
p:
	echo $(env) > .env
	docker-compose up terraform-plan
a:
	echo $(env) > .env
	docker-compose up terraform-apply
d:
	echo $(env) > .env
	docker-compose up terraform-destroy

