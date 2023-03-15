# Change Log
Documentação das mudanças do projeto
 
Baseado em [Keep a Changelog](http://keepachangelog.com/)
e esse projeto adere [Semantic Versioning](http://semver.org/).
 
## [Unreleased]
 
### Added

### Changed
 
### Fixed

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