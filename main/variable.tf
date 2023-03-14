variable "env" {
    description = "Ambiente dos módulos"
    type = string
    default = "dev"
}

variable "aws_region" {
    description = "Região do AWS"
    type = string
    default = "us-east-1"
}

variable "domain" {
    description = "Domínio principal da estrutura"
    type = string
    default = "test.arguschef.com.br"
}

variable "id" {
    description = "ID da Estrutura"
    type = string
    default = "argus-chef"
}

variable "ami_e2c_application_name" {
    description = "Nome da AMI que rodará nas instâncias"
    type = string
    default = "java-11-tomcat-9"
}

variable "e2c_application_instance_type" {
    description = "Máquina que rodará as instâncias"
    type = string
    default = "t3a.micro"
}

variable "e2c_application_volume_size" {
    description = "Quantidade de gigas de armazenamento da instância"
    type = number
    default = 8
}