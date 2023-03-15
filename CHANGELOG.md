# Change Log
Documentação das mudanças do projeto
 
Baseado em [Keep a Changelog](http://keepachangelog.com/)
e esse projeto adere [Semantic Versioning](http://semver.org/).
 
## [Unreleased]
 
### Added

### Changed
 
### Fixed

## [0.0.3] - 2023-03-15

### Added
- Domínio, redirecionamento e certificado para load balancer.
- Possibilidade de declaração de múltiplas zonas por meio de lista no auto scalling.
- Declaração direta no arquivo main para algumas variáveis referentes ao auto scalling.

### Changed
- Criação de um módulo front-end para chamar os módulos site-s3 e certificate.
- Movendo arquivos para módulo auto-scaling com a criação da rede, grupos, load balancer e auto scalling.

## [0.0.2] - 2023-03-14

### Changed

**Makefile**
- Execução do main por padrão.
- Módulos podendo ser especificados pela varíavel **module**.
- Variáveis do usuário (**exec_user_code**) e grupo (**exec_group_code**).

## [0.0.1] - 2023-03-13

### Added
- Configuração do compose e make file para rodar o terraform em container.
- Estrutura main do terraform.
- Módulos de certificado (certificate) e site hospedado em um container s3 (site-s3).
- Recursos do auto scaling e load balancer.
- Declaração inicial da estrutura.