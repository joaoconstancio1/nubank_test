# 🔗 Nubank URL Shortener

Um aplicativo Flutter elegante e moderno para encurtar URLs, desenvolvido seguindo os princípios de Clean Architecture e padrões de design estabelecidos.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-02569B?style=for-the-badge&logo=flutter&logoColor=white)

## 📋 Índice

- [✨ Funcionalidades](#-funcionalidades)
- [🏗️ Arquitetura](#️-arquitetura)
- [🚀 Tecnologias](#-tecnologias)
- [📱 Screenshots](#-screenshots)
- [⚙️ Configuração](#️-configuração)
- [🔧 Instalação](#-instalação)
- [🎯 Como Usar](#-como-usar)
- [🧪 Testes](#-testes)
- [📁 Estrutura do Projeto](#-estrutura-do-projeto)
- [🌐 API](#-api)
- [🤝 Contribuição](#-contribuição)
- [📝 Licença](#-licença)

## ✨ Funcionalidades

### 🎯 Funcionalidades Principais
- ✅ **Encurtamento de URLs** - Transforme URLs longas em links curtos e fáceis de compartilhar
- ✅ **Abertura de URLs** - Abra URLs originais diretamente no navegador com um toque
- ✅ **Cópia para Clipboard** - Copie URLs encurtadas com feedback visual
- ✅ **Interface Responsiva** - Design adaptável para diferentes tamanhos de tela
- ✅ **Overlay de Loading** - Feedback visual durante operações assíncronas
- ✅ **Tratamento de Erros** - Mensagens de erro amigáveis e informativas

### 🎨 Design e UX
- 🎨 **Interface Moderna** - Design inspirado no Nubank com gradientes e sombras
- 📱 **Responsivo** - Funciona perfeitamente em dispositivos móveis e desktop
- ⚡ **Performance** - Carregamento rápido e transições suaves
- 🔄 **Estados Visuais** - Indicadores claros para diferentes estados da aplicação

## 🏗️ Arquitetura

Este projeto segue os princípios de **Clean Architecture** com separação clara de responsabilidades:

```
lib/

├── core/                           # Núcleo da aplicação
│   ├── network/                    # Camada de rede
│   │   ├── custom_http_client.dart
│   │   ├── dio_http_client.dart
│   │   └── http_exceptions.dart
│   ├── utils/                      # Utilitários
│   │    ├── constants.dart
│   │    ├── loading_overlay.dart
│   │    └── url_launcher_helper.dart
│   └── injection.dart              # injeção de dependência da aplicação
│    
├── modules/
│   └── home/                       # Módulo principal
│       ├── data/                   # Camada de dados
│       │   ├── models/             # Modelos de dados
│       │   ├── repositories/       # Implementações de repositórios
│       │   └── services/           # Serviços de dados
│       ├── domain/                 # Regras de negócio
│       │   ├── entities/           # Entidades
│       │   ├── repositories/       # Interfaces de repositórios
│       │   └── usecases/           # Casos de uso
│       └── presenter/              # Camada de apresentação
│           ├── components/         # Componentes reutilizáveis
│           ├── cubits/             # Gerenciamento de estado
│           └── pages/              # Páginas da aplicação
└── main.dart                       # Ponto de entrada
```

### 🏛️ Padrões Arquiteturais

- **🔄 BLoC Pattern** - Gerenciamento de estado reativo e previsível
- **📦 Repository Pattern** - Abstração da camada de dados
- **🎯 Dependency Injection** - Injeção de dependências com GetIt
- **🏗️ Service Layer** - Serviços centralizados para funcionalidades transversais
- **🎨 Component-Based UI** - Componentes reutilizáveis e modulares

## 🚀 Tecnologias

### 📚 Framework e Linguagem
- **[Flutter](https://flutter.dev/)** `3.32.0+` - Framework de desenvolvimento multiplataforma
- **[Dart](https://dart.dev/)** `3.8.0+` - Linguagem de programação

### 📦 Principais Dependências
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** `^8.1.1` - Gerenciamento de estado
- **[dio](https://pub.dev/packages/dio)** `^5.0.0` - Cliente HTTP robusto
- **[get_it](https://pub.dev/packages/get_it)** `^8.2.0` - Service locator para DI
- **[equatable](https://pub.dev/packages/equatable)** `^2.0.7` - Comparação de objetos
- **[url_launcher](https://pub.dev/packages/url_launcher)** `^6.3.2` - Abertura de URLs
- **[clipboard](https://pub.dev/packages/clipboard)** `^0.1.3` - Manipulação do clipboard

### 🧪 Dependências de Teste
- **[bloc_test](https://pub.dev/packages/bloc_test)** `^9.1.0` - Testes para BLoC
- **[mocktail](https://pub.dev/packages/mocktail)** `^1.0.0` - Mocking para testes

## 📱 Screenshots

### 🏠 Tela Principal
A interface principal apresenta um design clean com:
- Campo de entrada para URLs
- Lista de URLs encurtadas
- Botões de ação intuitivos

### ⚡ Estados da Aplicação
- **Estado Vazio** - Mensagem motivacional para começar
- **Estado de Loading** - Overlay elegante durante operações
- **Estado com Dados** - Lista organizada de URLs
- **Estados de Erro** - Mensagens informativas e ações de recuperação

## ⚙️ Configuração

### 📋 Pré-requisitos

- **Flutter SDK** `3.32.0` ou superior
- **Dart SDK** `3.8.0` ou superior
- **Android Studio** / **VS Code** com extensões Flutter
- **Git** para controle de versão

### 🌐 Configuração da API

O aplicativo se conecta a uma API REST hospedada em:
```
https://url-shortener-server.onrender.com/api
```

#### 📡 Endpoints Utilizados:
- `POST /alias` - Criar URL encurtada
- `GET /alias/{id}` - Obter URL original

## 🔧 Instalação

### 1️⃣ Clone o Repositório
```bash
git clone https://github.com/joaoconstancio1/nubank_test.git
cd nubank_test
```

### 2️⃣ Instale as Dependências
```bash
flutter pub get
```

### 3️⃣ Configure o Ambiente
```bash
# Verificar se o Flutter está corretamente configurado
flutter doctor

# Listar dispositivos disponíveis
flutter devices
```

### 4️⃣ Execute a Aplicação
```bash
# Modo debug
flutter run

# Modo release
flutter run --release

# Para plataforma específica
flutter run -d chrome        # Web
flutter run -d windows       # Windows
flutter run -d android       # Android
```

## 🎯 Como Usar

### 1️⃣ Encurtar uma URL
1. Digite ou cole uma URL válida no campo de entrada
2. Toque no botão "Encurtar URL"
3. Aguarde o processamento
4. A URL encurtada aparecerá na lista

### 2️⃣ Abrir URL Original
1. Toque no ícone de abertura na URL desejada
2. Aguarde o overlay de loading
3. A URL original abrirá no navegador padrão

### 3️⃣ Gerenciar URLs
- **Visualizar**: Todas as URLs ficam salvas na sessão atual
- **Organizar**: Lista ordenada cronologicamente
- **Limpar**: Reinicie o app para limpar a lista

## 🧪 Testes

### 🔍 Executar Todos os Testes
```bash
flutter test
```

### 📊 Cobertura de Testes
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### 🔧 Script Automatizado de Cobertura
Para facilitar a geração e visualização da cobertura de testes, utilize o script automatizado:
```bash
./tools/coverage.sh
```

**Este script:**
- ✅ Executa todos os testes com cobertura
- ✅ Gera o relatório HTML automaticamente
- ✅ Abre o relatório no navegador padrão
- ✅ Funciona em Linux, macOS e Windows

**📋 Pré-requisito:**
- **lcov** deve estar instalado no sistema:
  - **Ubuntu/Debian:** `sudo apt-get install lcov`
  - **macOS:** `brew install lcov`
  - **Windows:** Instale via [Chocolatey](https://chocolatey.org/) com `choco install lcov` ou use o WSL

### 🧪 Tipos de Teste Implementados
- **Unit Tests** - Testes de lógica de negócio
- **Widget Tests** - Testes de componentes UI
- **BLoC Tests** - Testes de gerenciamento de estado

### 📁 Estrutura de Testes
```
test/
├── unit/                   # Testes unitários
│   ├── cubits/            # Testes de BLoC/Cubit
│   ├── repositories/      # Testes de repositórios
│   └── services/          # Testes de serviços
├── widget/                # Testes de widgets
└── integration/           # Testes de integração
```

## 📁 Estrutura do Projeto

### 🔧 Core (Núcleo)
```
core/
├── mixins/                 # Funcionalidades reutilizáveis
├── network/               # Camada de comunicação
├── services/              # Serviços globais
└── utils/                 # Utilitários e constantes
```

### 🏠 Módulo Home
```
modules/home/
├── data/                  # Camada de dados
│   ├── models/           # Modelos de dados
│   ├── repositories/     # Implementações
│   └── services/         # Serviços de dados
├── domain/               # Lógica de negócio
│   ├── entities/         # Entidades do domínio
│   ├── repositories/     # Contratos
│   └── usecases/         # Casos de uso
└── presenter/            # Interface do usuário
    ├── components/       # Componentes UI
    ├── cubits/          # Gerenciamento de estado
    └── pages/           # Páginas/Telas
```

### 🎨 Componentes UI Principais
- **`AliasLoadedWidget`** - Lista de URLs encurtadas
- **`AliasEmptyWidget`** - Estado vazio
- **`UrlInputCard`** - Campo de entrada de URL
- **`IntroCard`** - Cartão de introdução
- **`AliasTile`** - Item individual da lista

## 🌐 API

### 🔗 Base URL
```
https://url-shortener-server.onrender.com/api
```

### 📋 Endpoints

#### 📤 Criar Alias
```http
POST /alias
Content-Type: application/json

{
  "url": "https://exemplo.com/url-muito-longa"
}
```

**Resposta:**
```json
{
  "id": "abc123",
  "alias": "https://short.ly/abc123",
  "originalUrl": "https://exemplo.com/url-muito-longa",
  "createdAt": "2024-01-01T00:00:00Z"
}
```

#### 📥 Obter URL Original
```http
GET /alias/{id}
```

**Resposta:**
```json
{
  "originalUrl": "https://exemplo.com/url-muito-longa"
}
```

### ⚠️ Tratamento de Erros
- **400** - Bad Request (URL inválida)
- **404** - Not Found (Alias não encontrado)
- **500** - Server Error (Erro interno)
- **Network** - Erro de conectividade

## 🤝 Contribuição

### 🚀 Como Contribuir

1. **Fork** o projeto
2. **Clone** sua fork
3. **Crie** uma branch para sua feature
4. **Implemente** suas mudanças
5. **Teste** sua implementação
6. **Commit** suas mudanças
7. **Push** para sua branch
8. **Abra** um Pull Request

### 📝 Diretrizes de Contribuição

- ✅ **Código Limpo** - Siga as convenções do Dart/Flutter
- ✅ **Testes** - Mantenha ou melhore a cobertura de testes
- ✅ **Documentação** - Documente novas funcionalidades
- ✅ **Commits** - Use mensagens descritivas
- ✅ **Performance** - Otimize quando possível

### 🐛 Reportar Bugs

Use as [Issues do GitHub](https://github.com/joaoconstancio1/nubank_test/issues) para:
- 🐛 Reportar bugs
- 💡 Sugerir melhorias
- ❓ Fazer perguntas
- 📈 Solicitar novas funcionalidades

## 📝 Licença

Este projeto está sob a licença **MIT**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 🏆 Créditos

### 👨‍💻 Desenvolvedor
**João Constâncio** - [GitHub](https://github.com/joaoconstancio1)

### 🎨 Design
Interface inspirada no design system do **Nubank** com cores e padrões modernos.

### 🚀 Tecnologias
Construído com as melhores práticas da comunidade **Flutter** e padrões de **Clean Architecture**.

---

<div align="center">

**⭐ Se este projeto foi útil para você, considere dar uma estrela!**

![GitHub stars](https://img.shields.io/github/stars/joaoconstancio1/nubank_test?style=social)
![GitHub forks](https://img.shields.io/github/forks/joaoconstancio1/nubank_test?style=social)

</div>
