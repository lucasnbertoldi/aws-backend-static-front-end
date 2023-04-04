# Estrutura Terraform AWS - Backend + Frontend Estático

[Histórico de Mudanças](https://github.com/lucasnbertoldi/aws-terraform-angular-java-mysql/blob/main/CHANGELOG.md)

## Especificações

 - **Banco de Dados**: Mysql 8.0.32 ou 5.7.40
 - **Front-end**: Site Estático

O projeto executa o Terraform em um container Docker com base neste modelo: [terraform-docker](https://github.com/lucasnbertoldi/terraform-docker)

## Requisitos

- Criar uma AMI para ser executada no Load Balancer e especificar seu nome na variável ami_e2c_application_name no arquivo /main/variable.tf.
- Criar uma zona para o domínio especificado na variável domain no arquivo /main/variable.tf. 
- Criar uma pasta chamada front-end na raiz do projeto e inserir os arquivos estáticos referentes ao Front-end.
- Criar arquivo chamado auth.tf e inserir o seguinte conteúdo:

*Substitua **segredo** e **chave_acesso** pelas suas credenciais da AWS.*

    variable "aws_access_key" {
        description = "Chave de acesso para se comunicar com a AWS"
        type = string
        default = "chave_acesso"
    }
    
    variable "aws_secret_key" {
        description = "Segredo de acesso para se comunicar com a AWS"
        type = string
        default = "segredo"
    }

- Altere as definições dos módulos conforme a sua necessidade no arquivo /main/main.tf

## Módulos

 - **auto-scaling**: define as configurações para load balancer.
 - **certificate**: solicita um certificado SSL e cria as configurações de roteamento para validação.
 - **front-end**: utiliza os serviços certificate e site-s3 para criar a estrutura para execução do front-end estático.
 - **mysql-database**: cria as definições para o banco de dados em multi-az.
 - **network**: cria VPC e Gateway
 - **site-s3**: configurações para hospedar site em um bucket s3.