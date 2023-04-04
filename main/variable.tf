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
    default = "domain.com"
}

variable "id" {
    description = "ID da Estrutura"
    type = string
    default = "app-name"
}

variable "ami_e2c_application_name" {
    description = "Nome da AMI que rodará nas instâncias"
    type = string
    default = "java-11-tomcat-9"
}