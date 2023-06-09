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

variable "domain" {
    description = "Domínio que será hospedado o site"
    type = string
}

variable "route_53_zone_id" {
    description = "Id da zona do registro do Route53 onde o domínio está hospedado"
    type = string
}

variable "e2c_application_instance_type" {
    description = "Máquina que rodará as instâncias"
    type = string
}

variable "e2c_application_volume_size" {
    description = "Quantidade de gigas de armazenamento da instância"
    type = number
}

variable "ami_id" {
    description = "O id da ami que ira executar no auto scaling"
    type = string
}

variable "auto_scaling_cpu_percentage" {
    description = "Qual o uso do CPU que vai gerar a criação de outra instância"
    type = number
}

variable "vpc" {
    description = "VPC que rodara a estrutura do auto scalling"
    type = any
}

variable "zones" {
    description = "Regiões que o auto scalling irá escalar"
    type = list(string)
}

variable "gw_table_route" {
    description = "A rota do gateway da internet"
    type = any
}

variable "start_network_number" {
    description = "Número da rede que  será criada para o banco de dados. Ex.: n=1 e subredes=2 entao xxx.xxx.1.xxx e xxx.xxx.2.xxx. Atenção para as redes não repetirem entre os recursos."
    type = number
}