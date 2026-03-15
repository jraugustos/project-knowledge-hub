# Destino: Google Docs

O Google Docs é ideal para times que usam Google Workspace e precisam de documentação
colaborativa com comentários, sugestões e controle de acesso via Drive.

## Setup

### No Antigravity

O Antigravity tem integração nativa com Google — pode já estar disponível.
Verifique em MCP Servers se o Google Drive/Docs está listado.

### Via MCP genérico

Se não estiver disponível nativamente:

```json
{
  "mcpServers": {
    "google-drive": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@anthropic/google-drive-mcp"]
    }
  }
}
```

A autenticação usa OAuth — o browser abrirá para autorizar acesso ao Drive.

## Estrutura no Google Drive

Criar a seguinte estrutura de pastas:

```
📁 [Projeto] — Documentação
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

Para cada arquivo em `docs/`:

1. Criar a pasta do projeto no Drive (se não existir)
2. Criar sub-pastas por pilar
3. Criar um Google Doc por artefato, convertendo o Markdown para o formato do Docs

O Google Docs aceita import de Markdown, mas tabelas e Mermaid precisam de tratamento especial:
- Tabelas: converter para tabelas nativas do Docs
- Mermaid: gerar como imagem PNG e inserir no doc

## Atualizar

Substituir o conteúdo dos docs existentes ou criar versões novas.
O Google Docs mantém histórico de versões automaticamente.

## Vantagens

- Colaboração em tempo real nativa
- Comentários e sugestões de edição
- Controle de acesso granular (viewer, commenter, editor)
- Familiar para qualquer pessoa com conta Google
- Funciona bem no mobile

## Limites

- Markdown não é formato nativo — precisa conversão
- Mermaid não renderiza — precisa ser convertido para imagem
- Menos flexível para estruturação hierárquica que Notion
