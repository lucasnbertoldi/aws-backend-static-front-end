variable "id" {
    description = "ID que será utilizado para criar os recursos"
    type = string
}

variable "aws_access_key" {
    description = "Chave de acesso para se comunicar com a AWS"
    type = string
}

variable "aws_secret_key" {
    description = "Segredo de acesso para se comunicar com a AWS"
    type = string
}

variable "aws_region" {
    description = "Região do AWS"
    type = string
}

variable "env" {
    description = "Ambiente dos módulos"
    type = string
}

variable "storage" {
    description = "Valor do armazenamento em GB"
    type = number
}

variable "max_storage" {
    description = "Valor do armazenamento em GB caso seja preciso aumentar"
    type = number
}

variable "user_name" {
    description = "Nome do usuário do banco de dados"
    type = string
    default = "admin"
}

variable "password" {
    description = "Senha de administrador para o banco de dados"
    type = string
}

variable "mysql_version" {
    description = "Versão do mysql que será executada"
    type = number
    default = 5
}

variable "database_instance_type" {
    description = "A instância que irá rodar o mysql"
    type = string
}

variable "vpc" {
    description = "VPC que rodara a estrutura do auto scalling"
    type = any
}

variable "zones" {
    description = "Regiões que o auto scalling irá escalar"
    type = list(string)
}

variable "start_network_number" {
    description = "Número da rede que  será criada para o banco de dados. Ex.: n=1 e subredes=2 entao xxx.xxx.1.xxx e xxx.xxx.2.xxx. Atenção para as redes não repetirem entre os recursos."
    type = number
}