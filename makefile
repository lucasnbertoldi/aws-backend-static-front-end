
env="FOLDER=$(if $(module),modules/$(module),main)\nEXEC_USER=$(if $(exec_user_code),$(exec_user_code),1000)\nEXEC_GROUP=$(if $(exec_group_code),$(exec_group_code),1000)"

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