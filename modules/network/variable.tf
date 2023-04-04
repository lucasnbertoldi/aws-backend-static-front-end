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