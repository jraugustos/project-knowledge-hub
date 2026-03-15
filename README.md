# 📚 Project Knowledge Hub

Uma **skill para AI coding assistants** que documenta projetos digitais de ponta a ponta, organizando toda a documentação em três pilares — **Produto**, **Experiência** e **Tecnologia** — com distribuição opcional para plataformas de conhecimento.

<p align="center">
  <img src="https://img.shields.io/badge/format-Markdown-blue" alt="Format: Markdown"/>
  <img src="https://img.shields.io/badge/language-Português%20BR-green" alt="Language: PT-BR"/>
  <img src="https://img.shields.io/badge/license-MIT-yellow" alt="License: MIT"/>
</p>

---

## 🎯 O que é?

O Project Knowledge Hub é uma skill que transforma qualquer projeto digital em uma base de documentação estruturada. Ela guia o assistente de IA a conduzir uma entrevista de discovery com o desenvolvedor e, a partir das respostas + análise do repositório, gera automaticamente todos os artefatos de documentação em Markdown.

### Problema que resolve

Projetos crescem sem documentação. Quando alguém precisa entender o contexto — seja um novo membro do time, o próprio dev voltando meses depois, ou uma IA — a informação está espalhada em código, commits, conversas e na cabeça de alguém.

### Como resolve

A skill sistematiza o conhecimento do projeto em **artefatos padronizados** organizados por pilar, gerando documentação que pode ser consultada localmente ou distribuída para plataformas como NotebookLM, Notion, Google Docs e OneNote.

---

## 🏗️ Os Três Pilares

| Pilar | Foco | Artefatos Principais |
|---|---|---|
| 📦 **Produto** | O quê e por quê | PRD, Mapa de Funcionalidades, Roadmap, Métricas & KPIs |
| 🧑‍🎨 **Experiência** | Para quem e como | Personas, Jornada do Usuário, Service Blueprint, Branding, Design System |
| ⚙️ **Tecnologia** | Com quê e onde | Stack Técnica, Diagrama de Arquitetura, Mapa de Integrações, Modelo de Dados |

### Artefatos gerados

<details>
<summary><strong>📦 Pilar Produto</strong> (2 obrigatórios + 4 opcionais)</summary>

| Artefato | Obrigatório | Descrição |
|---|---|---|
| PRD | ✅ | Visão, problema, objetivos, escopo, requisitos |
| Mapa de Funcionalidades | ✅ | Features priorizadas (MoSCoW) |
| Roadmap | — | Timeline de entregas por fase |
| Métricas & KPIs | — | North star metric e indicadores |
| Análise Competitiva | — | Comparativo com soluções do mercado |
| Glossário | — | Termos e definições do domínio |

</details>

<details>
<summary><strong>🧑‍🎨 Pilar Experiência</strong> (5 obrigatórios + 3 opcionais)</summary>

| Artefato | Obrigatório | Descrição |
|---|---|---|
| Personas | ✅ | Perfis de usuários com goals e frustrações |
| Mapa de Jornada | ✅ | Etapas, emoções e touchpoints por persona |
| Service Blueprint | ✅ | Front-stage, back-stage e processos de suporte |
| Branding | ✅ | Identidade visual: logo, cores, tipografia, tom de voz |
| Design System | ✅ | Componentes UI em Atomic Design |
| User Flows | — | Diagramas de decisão para fluxos críticos |
| Mapa de Stakeholders | — | Influência × interesse |
| Princípios de Design | — | Diretrizes de UX/UI |

</details>

<details>
<summary><strong>⚙️ Pilar Tecnologia</strong> (3 obrigatórios + 4 opcionais)</summary>

| Artefato | Obrigatório | Descrição |
|---|---|---|
| Stack Técnica | ✅ | Linguagens, frameworks, serviços |
| Diagrama de Arquitetura | ✅ | Componentes e conexões (Mermaid) |
| Mapa de Integrações | ✅ | APIs externas e fluxo de dados |
| Estrutura do Repositório | — | Organização de pastas e convenções |
| Modelo de Dados | — | ERD simplificado (Mermaid) |
| Estratégia de Deploy | — | CI/CD, ambientes, monitoramento |
| ADRs | — | Decisões arquiteturais e trade-offs |

</details>

---

## 🔄 Como funciona

```
            ┌──────────────────┐
            │   0. Escolher    │
            │     destino      │
            └────────┬─────────┘
                     ▼
            ┌──────────────────┐
            │   1. Discovery   │
            │   (entrevista +  │
            │    análise repo) │
            └────────┬─────────┘
                     ▼
            ┌──────────────────┐
            │   2. Geração     │
            │   dos artefatos  │
            │   em Markdown    │
            └────────┬─────────┘
                     ▼
            ┌──────────────────┐
            │   3. Índice      │
            │   (_INDEX.md)    │
            └────────┬─────────┘
                     ▼
       ┌─────────────┴──────────────┐
       │  4. Distribuição (opcional) │
       └─────────────┬──────────────┘
                     ▼
  ┌──────────┬───────┴──────┬────────────┐
  │ Notebook │   Notion     │ Google     │ OneNote
  │   LM     │              │  Docs      │
  └──────────┴──────────────┴────────────┘
```

O **Markdown local** (`docs/`) é sempre o entregável principal e source of truth. A distribuição para plataformas externas é uma camada opcional.

---

## 📁 Estrutura do projeto

```
project-knowledge-hub/
├── SKILL.md                              # Instruções completas da skill
├── references/
│   ├── artifact-guide.md                 # Guia detalhado de cada artefato
│   ├── troubleshooting-mcp.md            # Solução de problemas MCP
│   └── destinations/
│       ├── notebooklm.md                 # Setup: Google NotebookLM
│       ├── notion.md                     # Setup: Notion
│       ├── google-docs.md                # Setup: Google Docs
│       └── onenote.md                    # Setup: Microsoft OneNote
└── scripts/
    ├── setup-mcp.sh                      # Configura conexão MCP + NotebookLM
    └── send-to-notebooklm.sh             # Envia docs para NotebookLM
```

---

## 🚀 Como usar

### 1. Instalar a skill

Copie esta pasta para o diretório de skills do seu AI assistant. Por exemplo, no Gemini CLI:

```bash
# Clone o repositório
git clone https://github.com/jraugustos/project-knowledge-hub.git

# Copie para o diretório de skills do seu projeto
cp -r project-knowledge-hub/ seu-projeto/.agents/skills/project-knowledge-hub/
```

### 2. Acionar a skill

A skill é ativada quando você faz pedidos como:

- *"Documente este projeto"*
- *"Crie a documentação de produto"*
- *"Mapeie as jornadas de usuário"*
- *"Monte a base de conhecimento do projeto"*
- *"Defina a arquitetura técnica"*
- *"Gere o PRD, service blueprint e personas"*

### 3. Responder o Discovery

A skill fará perguntas sobre o projeto cobrindo contexto geral, produto, experiência e tecnologia. Se houver um repositório, ela analisa o código antes de perguntar.

### 4. Receber a documentação

A documentação será gerada em `docs/` na raiz do projeto:

```
docs/
├── _INDEX.md
├── produto/
│   ├── prd.md
│   ├── funcionalidades.md
│   └── ...
├── experiencia/
│   ├── personas.md
│   ├── jornada.md
│   ├── service-blueprint.md
│   ├── branding.md
│   ├── design-system.md
│   └── ...
└── tecnologia/
    ├── stack.md
    ├── arquitetura.md
    ├── integracoes.md
    └── ...
```

---

## 🌐 Destinos de distribuição

| Destino | MCP necessário | Funcionalidade extra |
|---|---|---|
| **Markdown local** (padrão) | Nenhum | — |
| **Google NotebookLM** | `notebooklm-mcp-cli` | IA conversacional sobre os docs + Audio Overview (podcast) |
| **Notion** | `@notionhq/mcp-server` | Páginas hierárquicas, databases, views |
| **Google Docs** | Google Docs MCP | Colaboração em tempo real, comentários |
| **Microsoft OneNote** | `onenote-mcp` | Integração Microsoft 365 + Copilot |

Múltiplos destinos podem ser configurados simultaneamente.

### Setup rápido para NotebookLM

```bash
# Instalar e configurar automaticamente
bash scripts/setup-mcp.sh --notebook-name "Meu Projeto"

# Enviar docs já gerados
bash scripts/send-to-notebooklm.sh docs/ [NOTEBOOK_ID]
```

Para outros destinos, consulte os guias em `references/destinations/`.

---

## 🛠️ Scripts incluídos

### `scripts/setup-mcp.sh`

Configura a conexão MCP com o NotebookLM automaticamente:

1. Verifica/instala o `nlm` CLI
2. Configura o MCP no AI assistant
3. Autentica com a conta Google
4. Cria ou conecta um notebook

```bash
bash scripts/setup-mcp.sh --notebook-name "Nome do Projeto"
```

### `scripts/send-to-notebooklm.sh`

Envia todos os arquivos `.md` de um diretório para o NotebookLM como sources:

```bash
bash scripts/send-to-notebooklm.sh docs/ [NOTEBOOK_ID]
```

Funcionalidades:
- Detecção automática do notebook ID via `.notebook-id`
- Envio com logging colorido e contagem de sucesso/falha
- Validação automática da base de conhecimento após envio

---

## 📖 Referências

| Arquivo | Descrição |
|---|---|
| [`SKILL.md`](SKILL.md) | Instruções completas da skill (fluxo passo a passo) |
| [`references/artifact-guide.md`](references/artifact-guide.md) | Guia detalhado de estrutura e conteúdo para cada artefato |
| [`references/troubleshooting-mcp.md`](references/troubleshooting-mcp.md) | Solução de problemas comuns na conexão MCP |
| [`references/destinations/`](references/destinations/) | Guias de setup para cada plataforma de distribuição |

---

## 🤝 Compatibilidade

A skill foi projetada para funcionar com AI coding assistants que suportem o formato de skills em Markdown, incluindo:

- Google Gemini CLI / Antigravity
- Outros assistentes com suporte a custom skills/instructions

A distribuição para plataformas externas utiliza o protocolo **MCP (Model Context Protocol)**.

---

## 📄 Licença

MIT — use, modifique e distribua livremente.
