# Destino: Microsoft OneNote

O OneNote funciona como base de conhecimento dentro do ecossistema Microsoft.
Ideal para times que usam Microsoft 365, Teams e Copilot.

## Setup

### Opção 1: OneNote MCP (recomendado)

```bash
# Clonar e instalar
git clone https://github.com/danosb/onenote-mcp.git
cd onenote-mcp
npm install
```

Configurar no ambiente:

```json
{
  "mcpServers": {
    "onenote": {
      "type": "stdio",
      "command": "node",
      "args": ["/caminho/para/onenote-mcp/onenote-mcp.mjs"]
    }
  }
}
```

### Opção 2: OneNote MCP avançado (mais ferramentas)

Para funcionalidades extras como edição de páginas e busca avançada:

```bash
git clone https://github.com/eshlon/onenotemcp.git
cd onenotemcp
npm install
```

### Autenticação

Ambas as opções usam Azure AD com Device Code Flow:

1. Criar um App Registration no Azure Portal (gratuito)
2. Habilitar permissões: `Notes.Read`, `Notes.ReadWrite`, `Notes.Create`, `User.Read`
3. Na primeira execução, o MCP fornecerá um código para autenticar no browser
4. O token é salvo localmente para sessões futuras

### Azure App Registration (passo a passo)

1. Acesse https://portal.azure.com
2. Azure Active Directory → App registrations → New registration
3. Nome: "OneNote MCP"
4. Redirect URI: `https://login.microsoftonline.com/common/oauth2/nativeclient`
5. Copie o Application (client) ID
6. Configure como variável de ambiente:
   ```bash
   export AZURE_CLIENT_ID="seu_client_id"
   ```

## Estrutura no OneNote

Criar a seguinte hierarquia:

```
📓 [Projeto] — Knowledge Hub
├── 📑 Produto (Section)
│   ├── 📄 PRD
│   ├── 📄 Mapa de Funcionalidades
│   └── ...
├── 📑 Experiência (Section)
│   ├── 📄 Personas
│   ├── 📄 Jornada do Usuário
│   ├── 📄 Service Blueprint
│   ├── 📄 Branding
│   ├── 📄 Design System
│   └── ...
└── 📑 Tecnologia (Section)
    ├── 📄 Stack Técnica
    ├── 📄 Arquitetura
    ├── 📄 Integrações
    └── ...
```

## Enviar documentação

Usando o OneNote MCP, para cada arquivo em `docs/`:

1. Listar notebooks existentes ou criar um novo
2. Criar sections por pilar (Produto, Experiência, Tecnologia)
3. Criar uma página por artefato com o conteúdo do Markdown convertido para HTML
   (OneNote usa HTML internamente para conteúdo de páginas)

O OneNote aceita HTML como formato de input para páginas. Markdown precisa ser convertido:
- Converter headings, listas, bold/italic para HTML equivalente
- Tabelas: converter para HTML tables
- Mermaid: gerar como imagem e inserir

## Atualizar

Para re-sincronizar, atualizar o conteúdo das páginas existentes via MCP.
O OneNote mantém histórico de versões.

## Integração com Copilot

Uma vez que a documentação está no OneNote, o Microsoft Copilot pode acessá-la
nativamente para responder perguntas sobre o projeto — similar ao que o NotebookLM faz
com o Gemini. Isso funciona via Microsoft 365 Copilot ou Copilot Studio.

## Vantagens

- Integrado com Microsoft 365 (Teams, Outlook, SharePoint)
- Copilot pode acessar os docs para responder perguntas
- Suporta rich content (imagens, tabelas, embeddings)
- Funciona offline no app desktop
- Compartilhamento via OneDrive/SharePoint

## Limites

- Requer Azure App Registration (gratuito, mas tem setup)
- Device Code Flow de auth pode ser confuso na primeira vez
- Formatação é HTML internamente — menos limpo que Markdown puro
- MCPs disponíveis são comunitários (não oficiais da Microsoft)
