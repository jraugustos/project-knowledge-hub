#!/usr/bin/env bash
# setup-mcp.sh — Configura a conexão MCP com o NotebookLM para Claude Code
# Uso: bash scripts/setup-mcp.sh [--notebook-name "Nome do Projeto"]

set -euo pipefail

NOTEBOOK_NAME="${1:-}"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[✓]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }

# --- Step 1: Check if nlm CLI is installed ---
echo ""
echo "=== Project Knowledge Hub — Setup MCP ==="
echo ""

if command -v nlm &>/dev/null; then
    log_info "nlm CLI encontrado: $(nlm --version 2>/dev/null || echo 'versão desconhecida')"
else
    log_warn "nlm CLI não encontrado. Instalando..."
    
    if command -v uv &>/dev/null; then
        uv tool install notebooklm-mcp-cli
    elif command -v pipx &>/dev/null; then
        pipx install notebooklm-mcp-cli
    else
        pip install --user notebooklm-mcp-cli
    fi
    
    if command -v nlm &>/dev/null; then
        log_info "nlm CLI instalado com sucesso"
    else
        log_error "Falha na instalação. Tente manualmente: pip install notebooklm-mcp-cli"
        exit 1
    fi
fi

# --- Step 2: Check if MCP is configured for Claude Code ---
echo ""
if claude mcp list 2>/dev/null | grep -qi notebook; then
    log_info "MCP do NotebookLM já configurado no Claude Code"
else
    log_warn "MCP não configurado. Adicionando ao Claude Code..."
    nlm setup add claude-code
    log_info "MCP adicionado ao Claude Code"
fi

# --- Step 3: Check authentication ---
echo ""
if nlm doctor 2>/dev/null | grep -qi "authenticated\|healthy\|ok"; then
    log_info "Autenticação ativa"
else
    log_warn "Autenticação necessária. Abrindo browser para login..."
    nlm auth login
    
    if nlm doctor 2>/dev/null | grep -qi "authenticated\|healthy\|ok"; then
        log_info "Autenticação concluída com sucesso"
    else
        log_error "Problemas na autenticação. Consulte: references/troubleshooting-mcp.md"
        exit 1
    fi
fi

# --- Step 4: Create or connect notebook ---
echo ""
if [ -n "$NOTEBOOK_NAME" ]; then
    log_info "Criando notebook: $NOTEBOOK_NAME — Knowledge Hub"
    NOTEBOOK_ID=$(nlm notebook create "$NOTEBOOK_NAME — Knowledge Hub" 2>/dev/null | grep -oP 'id[:\s]+\K\S+' || echo "")
    
    if [ -n "$NOTEBOOK_ID" ]; then
        log_info "Notebook criado com ID: $NOTEBOOK_ID"
        echo "$NOTEBOOK_ID" > .notebook-id
        log_info "ID salvo em .notebook-id"
    else
        log_warn "Não foi possível extrair o ID automaticamente."
        log_warn "Liste seus notebooks com: nlm notebook list"
        log_warn "E salve o ID manualmente em .notebook-id"
    fi
else
    log_warn "Nenhum nome de notebook fornecido."
    echo "  Para criar: bash scripts/setup-mcp.sh --notebook-name \"Meu Projeto\""
    echo "  Para conectar existente: echo 'NOTEBOOK_ID' > .notebook-id"
fi

echo ""
echo "=== Setup concluído ==="
echo ""
echo "Próximos passos:"
echo "  1. Se conectou a um notebook existente, salve o ID em .notebook-id"
echo "  2. Execute a documentação do projeto"
echo "  3. Os documentos serão enviados automaticamente ao NotebookLM"
echo ""
