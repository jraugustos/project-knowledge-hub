# Destino: Google NotebookLM

O NotebookLM transforma a documentação em uma base de conhecimento conversacional — o Gemini responde
perguntas sobre o projeto usando os documentos como fonte, com citações. Também pode gerar Audio Overviews (podcasts).

## Setup

### Instalar o MCP

```bash
# Com uv (preferido)
uv tool install notebooklm-mcp-cli

# Ou com pip
pip install notebooklm-mcp-cli

# Configurar para o ambiente
nlm setup add claude-code       # Claude Code
nlm setup add antigravity       # Antigravity

# Autenticar (uma única vez — abre browser)
nlm auth login

# Verificar
nlm doctor
```

### Criar ou conectar notebook

```bash
# Novo notebook
nlm notebook create "[Projeto] — Knowledge Hub"

# Ou conectar existente (precisa do link de compartilhamento)
nlm notebook add <SHARE_LINK>

# Salvar o ID para uso nos scripts
nlm notebook list
echo "NOTEBOOK_ID_AQUI" > .notebook-id
```

## Enviar documentação

```bash
# Enviar todos os docs de uma vez
bash scripts/send-to-notebooklm.sh docs/ [NOTEBOOK_ID]

# Ou enviar arquivo por arquivo
nlm source add <NOTEBOOK_ID> --file docs/produto/prd.md
nlm source add <NOTEBOOK_ID> --file docs/experiencia/personas.md
# ... etc
```

## Validar

```bash
nlm chat "<NOTEBOOK_ID>" "Resuma os três pilares de documentação deste projeto"
```

## Atualizar

Para re-sincronizar após edições nos docs locais, re-execute o envio.
O NotebookLM substitui sources com mesmo nome automaticamente.

## Gerar Audio Overview

```bash
nlm audio create <NOTEBOOK_ID> --confirm
```

## Limites

- Máximo 50 sources por notebook
- ~500.000 palavras por notebook
- Imagens em Markdown não são processadas visualmente (apenas texto)

## Troubleshooting

Consulte `references/troubleshooting-mcp.md` para problemas comuns.
