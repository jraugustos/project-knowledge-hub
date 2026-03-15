# Destino: Notion

O Notion permite organizar a documentação em páginas hierárquicas com rich text, databases e views.
Ideal para times que já usam Notion como ferramenta de gestão.

## Setup

### MCP disponível

Existem várias opções de Notion MCP. A mais comum:

```json
{
  "mcpServers": {
    "notion": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@notionhq/mcp-server"],
      "env": {
        "NOTION_API_KEY": "sua_integration_key"
      }
    }
  }
}
```

### Obter a API Key

1. Acesse https://www.notion.so/my-integrations
2. Crie uma nova integration (Internal)
3. Copie o "Internal Integration Secret"
4. Dê acesso à integration no workspace onde quer criar os docs

### No Antigravity

Adicionar ao `mcp_config.json` via Manage MCP Servers → View raw config.

## Estrutura no Notion

Criar a seguinte hierarquia:

```
📁 [Projeto] — Documentação
├── 📄 _INDEX (índice geral)
├── 📁 Produto
│   ├── 📄 PRD
│   ├── 📄 Mapa de Funcionalidades
│   └── ...
├── 📁 Experiência
│   ├── 📄 Personas
│   ├── 📄 Jornada do Usuário
│   ├── 📄 Service Blueprint
│   ├── 📄 Branding
│   ├── 📄 Design System
│   └── ...
└── 📁 Tecnologia
    ├── 📄 Stack Técnica
    ├── 📄 Arquitetura
    ├── 📄 Integrações
    └── ...
```

## Enviar documentação

Usando o Notion MCP, para cada arquivo em `docs/`:

1. Criar a página-mãe se não existir
2. Criar sub-páginas por pilar
3. Converter o Markdown para blocos do Notion e criar cada página

O Notion MCP aceita Markdown como input e converte automaticamente para blocos.

## Atualizar

Para re-sincronizar, atualizar o conteúdo das páginas existentes via MCP.
O Notion mantém histórico de versões automaticamente.

## Vantagens do Notion

- Rich text nativo com suporte a Markdown
- Databases para organizar artefatos com propriedades (status, pilar, tipo)
- Views (Table, Board, Gallery) para visualizar a documentação de diferentes formas
- Compartilhamento fácil com o time
- Comentários e menções inline

## Limites

- Requer API key e integration configurada
- Formatação Mermaid não é renderizada nativamente (usar imagens ou links para visualizadores)
