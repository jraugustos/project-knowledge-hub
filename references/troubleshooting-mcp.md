# Troubleshooting — Conexão MCP com NotebookLM

Guia para resolver problemas comuns na configuração e uso do MCP do NotebookLM com Claude Code.

---

## Problemas de Instalação

### `nlm: command not found`
O pacote não foi instalado globalmente ou o PATH não inclui o diretório de binários.

**Soluções:**
```bash
# Verificar se está instalado
pip show notebooklm-mcp-cli

# Se instalou com uv:
uv tool list | grep notebooklm

# Reinstalar globalmente
pip install --user notebooklm-mcp-cli
# ou
uv tool install notebooklm-mcp-cli --force
```

### Erro de dependência Python
Requer Python 3.10+.

```bash
python3 --version
# Se < 3.10, atualizar Python antes de instalar
```

---

## Problemas de Autenticação

### `Authentication expired` ou `Session invalid`
A sessão do Google expirou. Reautenticar:

```bash
nlm auth login
# Isso abre o browser — fazer login novamente na conta Google
```

### Login abre browser mas não completa
Pode ser problema com o browser headless. Forçar browser visível:

```bash
nlm auth login --show-browser
```

### Conta Google com 2FA
O fluxo de auth suporta 2FA, mas pode ser mais lento. Aguardar o prompt de verificação no browser e completar manualmente.

---

## Problemas de Conexão MCP

### Claude Code não reconhece o MCP
Verificar se foi adicionado:

```bash
claude mcp list
```

Se não aparece, re-adicionar:

```bash
nlm setup add claude-code
```

Depois reiniciar o Claude Code.

### MCP conecta mas não responde
Verificar saúde:

```bash
nlm doctor
```

Se `doctor` reportar problemas, tentar reset:

```bash
nlm auth logout
nlm auth login
```

---

## Problemas com Notebooks

### `Notebook not found`
O ID pode estar errado ou o notebook foi deletado. Listar notebooks disponíveis:

```bash
nlm notebook list
```

### Limite de sources atingido
NotebookLM suporta até 50 sources por notebook e ~500.000 palavras. Se atingir o limite:

1. Consolidar documentos menores em um único Markdown
2. Remover sources obsoletas: `nlm source remove <NOTEBOOK_ID> <SOURCE_ID>`
3. Criar um segundo notebook para documentação histórica

### Source não aparece após upload
O NotebookLM pode levar alguns segundos para processar. Aguardar 10-15 segundos e verificar:

```bash
nlm source list <NOTEBOOK_ID>
```

---

## Problemas de Performance

### Respostas lentas do NotebookLM
É normal — o MCP usa automação de browser, não uma API direta. Respostas podem levar 5-15 segundos. Para acelerar:

- Manter apenas sources relevantes no notebook ativo
- Usar queries específicas, não genéricas
- Fechar sessões não utilizadas: `nlm session close`

### Muitos tokens consumidos
O MCP adiciona overhead ao contexto. Para reduzir:

```bash
# Usar perfil minimal
npx notebooklm-mcp config set profile minimal
```

---

## Alternativa: Upload Manual

Se o MCP persistir com problemas e o bloqueio for crítico, a skill pode gerar os documentos localmente e o usuário faz upload manual:

1. Acessar https://notebooklm.google.com
2. Criar ou abrir o notebook do projeto
3. Clicar em "+" para adicionar source
4. Selecionar "Upload" e enviar os arquivos .md gerados em `docs/`

Isso perde a automação mas mantém o resultado final idêntico — o NotebookLM como central de conhecimento.
