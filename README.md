# Projeto iOS: Buscador de CEP

## 📱 Objetivo

Este projeto é um aplicativo iOS desenvolvido em Swift com o objetivo de buscar informações de endereço (bairro, logradouro e UF) a partir da digitação de um CEP. Ao digitar o CEP no input, os dados são retornados e exibidos em uma `UITableView`.

 [ViaCEP](https://viacep.com.br/ws/\(cep)/json)

---

## 🏗 Arquitetura

O projeto utiliza a arquitetura **MVVM** combinada com os padrões **Repository** e **Service** com **DataSource**. Essa abordagem permite uma melhor separação de responsabilidades e testabilidade.

### 📌 MVVM (Model-View-ViewModel)

- **Model**: Representa as entidades do domínio, como `Endereco`.
- **View**: Interface gráfica (Storyboard ou SwiftUI), responsável apenas pela exibição.
- **ViewModel**: Contém a lógica de apresentação e transforma os dados do modelo para a view.

### 📌 Repository

Camada intermediária que abstrai a fonte dos dados. Ela decide se os dados vêm de uma API, cache local, banco de dados, etc.

### 📌 Service

Responsável por fazer a chamada à API de CEP (ex: ViaCEP) e retornar os dados brutos.

### 📌 DataSource

Classe responsável por fornecer os dados formatados à `UITableView`.

---

## 🚀 Fluxo de Funcionamento

1. Usuário digita um CEP no campo de texto.
2. O `ViewModel` é notificado através de bindings (RxSwift).
3. O `ViewModel` chama o `Repository`, que por sua vez utiliza o `Service`.
4. O `Service` faz a requisição HTTP para a API de CEP.
5. A resposta é convertida em um `Model` (`Endereco`) e retornada ao `ViewModel`.
6. O `ViewModel` processa os dados e atualiza a `View` através da `DataSource`.

---

## 📦 Dependências (Pods)

```ruby
pod 'RxSwift'
pod 'RxCocoa'
pod 'CocoaDebug'
```

### 📌 Estrutura de Projeto
├── Model
│   └── Address.swift
├── View
│   └── CepViewController.swift
├── ViewModel
│   └── AddressViewModel.swift
├── Repository
│   └── AddressRepository.swift
├── Service
│   └── AddressService.swift
├── DataSource
│   └── UniqueViewDataSource.swift
