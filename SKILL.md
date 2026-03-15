---
name: project-knowledge-hub
description: >
  Documenta projetos digitais de forma completa, cobrindo três pilares — Produto, Experiência e Tecnologia —
  e gera toda a documentação em Markdown local, com opção de distribuir para diferentes plataformas
  de conhecimento: Google NotebookLM, Notion, Google Docs, ou Microsoft OneNote.
  Use esta skill sempre que o usuário pedir para documentar um projeto, criar documentação de produto,
  mapear jornadas de usuário, definir arquitetura técnica, gerar PRD, service blueprint, personas,
  branding, design system, ou qualquer combinação desses artefatos. Também acione quando o usuário mencionar
  "documentar projeto", "knowledge base do projeto", "base de conhecimento", "NotebookLM", "Notion",
  "Google Docs", "OneNote", "central de documentação", ou quiser organizar a documentação de um projeto
  existente ou novo. Funciona para qualquer tipo de projeto digital: web, mobile, e-commerce, SaaS,
  plataformas, APIs, etc.
---

# Project Knowledge Hub

Skill para documentar projetos digitais de ponta a ponta, gerar artefatos em Markdown e distribuir
para a plataforma de conhecimento que o usuário preferir.

## Visão Geral

A documentação é organizada em **três pilares**:

1. **Produto** — O quê e por quê: PRD, funcionalidades, roadmap, métricas
2. **Experiência** — Para quem e como: Personas, jornadas, service blueprint, branding, design system
3. **Tecnologia** — Com quê e onde: Stack, arquitetura, integrações, infraestrutura

### Arquitetura de output

A skill segue um modelo de **geração + distribuição**:

```
Passo 1-2: Discovery + Geração
        ↓
   docs/ (Markdown local)        ← SEMPRE gerado, é o output primário
        ↓
Passo 4: Distribuição (opcional)
        ↓
   ┌─────────────┬─────────┬──────────────┬──────────┐
   │ NotebookLM  │ Notion  │ Google Docs  │ OneNote  │
   └─────────────┴─────────┴──────────────┴──────────┘
```

O Markdown local é o **entregável principal**. A distribuição para plataformas externas é uma
camada opcional que o usuário escolhe depois — ou não escolhe, e os docs ficam no projeto.

---

## Passo 0: Definir destino da documentação

Pergunte ao usuário onde ele quer centralizar a documentação do projeto.
Se ele não souber ou não quiser escolher agora, o padrão é **Markdown local** — e ele decide depois.

### Destinos disponíveis

| Destino | MCP necessário | Setup |
|---|---|---|
| **Markdown local** (padrão) | Nenhum | `docs/` na raiz do projeto |
| **Google NotebookLM** | `notebooklm-mcp-cli` | Consulte `references/destinations/notebooklm.md` |
| **Notion** | `notion-mcp` | Consulte `references/destinations/notion.md` |
| **Google Docs** | Google Docs MCP (nativo no Antigravity) | Consulte `references/destinations/google-docs.md` |
| **Microsoft OneNote** | `onenote-mcp` | Consulte `references/destinations/onenote.md` |

O usuário pode escolher **mais de um destino** — a documentação é gerada uma vez e distribuída
para quantas plataformas quiser.

Se o destino escolhido requer MCP, configure-o agora seguindo o guia específico em `references/destinations/`.
Se não conseguir configurar, não bloqueie — gere o Markdown local e oriente o usuário a distribuir manualmente depois.

---

## Passo 1: Discovery — Entender o Projeto

Antes de documentar, é preciso entender. Conduza uma entrevista rápida com o usuário para capturar o contexto. Adapte as perguntas ao que já souber (memória, arquivos no repositório, conversas anteriores).

### Perguntas essenciais

**Contexto geral:**
- Qual o nome do projeto?
- Qual o problema que ele resolve?
- Quem são os usuários principais?
- Em que estágio está? (ideia, MVP, produção, escala)

**Produto:**
- Quais as funcionalidades principais já definidas?
- Existe algum documento de produto existente? (PRD, specs, backlog)
- Quais métricas de sucesso importam?

**Experiência:**
- Os usuários já foram mapeados? (personas, pesquisas)
- Existem fluxos ou jornadas já desenhados?
- Quais são os principais pontos de contato do serviço?
- Existe identidade visual definida? (logo, paleta de cores, tipografia, ícones)
- Existe um design system ou biblioteca de componentes? (Figma, Storybook, etc.)

**Tecnologia:**
- Qual stack está sendo usada ou planejada?
- Existem integrações com serviços externos?
- Qual a infraestrutura de deploy?
- Existe repositório? Qual a estrutura?

Se o usuário apontar para um repositório ou arquivos, analise-os antes de perguntar o que já pode ser inferido.

---

## Passo 2: Gerar Documentação — Os Três Pilares

Gere os documentos em Markdown na pasta `docs/` do projeto. Cada pilar tem artefatos obrigatórios e opcionais. Consulte `references/artifact-guide.md` para detalhes sobre estrutura e conteúdo de cada artefato.

### Estrutura de pastas

```
docs/
├── _INDEX.md                       ← Mapa de navegação
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

### Pilar 1: Produto

| Artefato | Obrigatório | Descrição |
|---|---|---|
| PRD (Product Requirements Document) | ✅ | Visão, problema, objetivos, escopo, requisitos funcionais e não-funcionais |
| Mapa de Funcionalidades | ✅ | Lista estruturada de features com priorização (MoSCoW ou similar) |
| Roadmap | Opcional | Timeline de entregas por fase ou sprint |
| Métricas & KPIs | Opcional | North star metric, KPIs primários e secundários |
| Análise Competitiva | Opcional | Comparativo com soluções similares no mercado |
| Glossário do Projeto | Opcional | Termos e definições específicas do domínio |

### Pilar 2: Experiência

| Artefato | Obrigatório | Descrição |
|---|---|---|
| Personas | ✅ | Perfis dos usuários com goals, frustrações, contexto |
| Mapa de Jornada do Usuário | ✅ | Etapas, ações, emoções, touchpoints para cada persona principal |
| Service Blueprint | ✅ | Front-stage, back-stage, processos de suporte, evidências físicas |
| Branding | ✅ | Identidade da marca: logo, cores, tipografia, ícones, tom de voz, assets visuais |
| Design System | ✅ | Componentes UI em Atomic Design: átomos, moléculas, organismos, templates, páginas |
| Fluxos de Usuário (User Flows) | Opcional | Diagramas de decisão para fluxos críticos |
| Mapa de Stakeholders | Opcional | Quem influencia ou é impactado pelo projeto |
| Princípios de Design | Opcional | Diretrizes de UX/UI que guiam as decisões |

### Pilar 3: Tecnologia

| Artefato | Obrigatório | Descrição |
|---|---|---|
| Stack Técnica | ✅ | Linguagens, frameworks, bancos de dados, serviços |
| Diagrama de Arquitetura | ✅ | Visão macro dos componentes e como se conectam (usar Mermaid) |
| Mapa de Integrações | ✅ | APIs externas, webhooks, serviços terceiros com fluxo de dados |
| Estrutura do Repositório | Opcional | Organização de pastas, convenções, monorepo vs multi-repo |
| Modelo de Dados | Opcional | Entidades principais e relacionamentos (ERD simplificado em Mermaid) |
| Estratégia de Deploy | Opcional | CI/CD, ambientes, infra, monitoramento |
| Decisões Técnicas (ADRs) | Opcional | Registro de decisões arquiteturais importantes e seus trade-offs |

### Formato dos documentos

Cada documento Markdown segue esta estrutura base:

```markdown
# [Nome do Artefato]

> **Projeto:** [Nome] | **Pilar:** [Produto/Experiência/Tecnologia] | **Versão:** 1.0 | **Data:** YYYY-MM-DD

## Contexto
[Por que este artefato existe e como ele se conecta ao projeto]

## Conteúdo
[O corpo do artefato — seções variam por tipo]

## Conexões
[Links para outros artefatos relacionados dentro dos três pilares]

---
*Gerado via Project Knowledge Hub*
```

---

## Passo 3: Gerar Documento Índice

Crie `docs/_INDEX.md` como mapa de navegação de toda a documentação:

```markdown
# 🗂️ [Nome do Projeto] — Índice de Documentação

## 📦 Produto
- PRD — Visão, escopo e requisitos
- Mapa de Funcionalidades — Features priorizadas
- [outros artefatos gerados]

## 🧑‍🎨 Experiência
- Personas — Perfis de usuários
- Jornada do Usuário — Fluxo por persona
- Service Blueprint — Visão completa do serviço
- Branding — Identidade visual da marca
- Design System — Componentes UI (Atomic Design)
- [outros artefatos gerados]

## ⚙️ Tecnologia
- Stack Técnica — Ferramentas e linguagens
- Arquitetura — Diagrama de componentes
- Integrações — APIs e serviços externos
- [outros artefatos gerados]

---
📍 Documentação gerada via Project Knowledge Hub
🗓️ [Data de geração]
```

---

## Passo 4: Distribuir para plataforma(s) escolhida(s)

Se o usuário escolheu um ou mais destinos no Passo 0, distribua agora.
Se não escolheu, pergunte: "A documentação está pronta em `docs/`. Quer enviar para alguma plataforma de conhecimento?"

Se a resposta for não, finalize aqui — o Markdown local já é o entregável completo.

### Distribuição por destino

Para cada destino, siga o guia correspondente em `references/destinations/`:

#### Google NotebookLM
```bash
bash scripts/send-to-notebooklm.sh docs/ [NOTEBOOK_ID]
```
Detalhes: `references/destinations/notebooklm.md`

#### Notion
Usar o Notion MCP para criar páginas a partir dos Markdowns.
Detalhes: `references/destinations/notion.md`

#### Google Docs
Usar o Google Docs MCP para criar documentos no Drive.
Detalhes: `references/destinations/google-docs.md`

#### Microsoft OneNote
Usar o OneNote MCP para criar páginas em um notebook.
Detalhes: `references/destinations/onenote.md`

### Distribuição múltipla

Se o usuário escolheu mais de um destino, envie para todos em sequência.
Os docs em `docs/` são a source of truth — os destinos são cópias distribuídas.

---

## Passo 5: Orientação Final ao Usuário

Após completar, explique ao usuário:

1. **Onde está a documentação:**
   - **Sempre:** `docs/` no projeto — é a versão canônica
   - **Se distribuiu:** Links para a plataforma escolhida

2. **Como manter atualizado:**
   - Edite os Markdowns em `docs/` e redistribua quando quiser
   - Cada guia de destino em `references/destinations/` explica como re-sincronizar

3. **Audio Overview (NotebookLM):** Se usou NotebookLM, sugerir geração de podcast:
   ```bash
   nlm audio create <NOTEBOOK_ID> --confirm
   ```

---

## Referências

- `references/artifact-guide.md` — Guia detalhado de cada artefato com exemplos e templates
- `references/destinations/notebooklm.md` — Setup e uso do NotebookLM como destino
- `references/destinations/notion.md` — Setup e uso do Notion como destino
- `references/destinations/google-docs.md` — Setup e uso do Google Docs como destino
- `references/destinations/onenote.md` — Setup e uso do OneNote como destino
- `references/troubleshooting-mcp.md` — Solução de problemas comuns na conexão MCP
