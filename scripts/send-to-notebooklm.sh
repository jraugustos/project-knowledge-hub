#!/usr/bin/env bash
# send-to-notebooklm.sh — Envia documentos gerados para o NotebookLM como sources
# Uso: bash scripts/send-to-notebooklm.sh <docs-directory> [notebook-id]

set -euo pipefail

DOCS_DIR="${1:?Uso: bash scripts/send-to-notebooklm.sh <docs-directory> [notebook-id]}"
NOTEBOOK_ID="${2:-}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log_info()  { echo -e "${GREEN}[✓]${NC} $1"; }
log_warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
log_error() { echo -e "${RED}[✗]${NC} $1"; }
log_step()  { echo -e "${CYAN}[→]${NC} $1"; }

# --- Resolve notebook ID ---
if [ -z "$NOTEBOOK_ID" ]; then
    if [ -f ".notebook-id" ]; then
        NOTEBOOK_ID=$(cat .notebook-id | tr -d '[:space:]')
        log_info "Notebook ID encontrado em .notebook-id: $NOTEBOOK_ID"
    else
        log_error "Notebook ID não fornecido e .notebook-id não encontrado."
        echo "  Uso: bash scripts/send-to-notebooklm.sh <docs-dir> <notebook-id>"
        echo "  Ou salve o ID em .notebook-id"
        exit 1
    fi
fi

# --- Validate docs directory ---
if [ ! -d "$DOCS_DIR" ]; then
    log_error "Diretório não encontrado: $DOCS_DIR"
    exit 1
fi

# --- Find all markdown files ---
FILES=$(find "$DOCS_DIR" -name "*.md" -type f | sort)
FILE_COUNT=$(echo "$FILES" | wc -l)

if [ -z "$FILES" ]; then
    log_error "Nenhum arquivo .md encontrado em $DOCS_DIR"
    exit 1
fi

echo ""
echo "=== Enviando documentação para o NotebookLM ==="
echo ""
echo "Notebook: $NOTEBOOK_ID"
echo "Arquivos: $FILE_COUNT"
echo ""

# --- Send each file ---
SUCCESS=0
FAILED=0

while IFS= read -r file; do
    filename=$(basename "$file")
    relative=$(realpath --relative-to="$DOCS_DIR" "$file" 2>/dev/null || echo "$file")
    
    log_step "Enviando: $relative"
    
    if nlm source add "$NOTEBOOK_ID" --file "$file" 2>/dev/null; then
        log_info "  Enviado: $filename"
        ((SUCCESS++))
    else
        log_error "  Falha: $filename"
        ((FAILED++))
    fi
    
    # Pequena pausa para não sobrecarregar
    sleep 2
done <<< "$FILES"

echo ""
echo "=== Resultado ==="
echo ""
log_info "Enviados com sucesso: $SUCCESS"
if [ "$FAILED" -gt 0 ]; then
    log_error "Falhas: $FAILED"
fi

# --- Validation ---
echo ""
log_step "Validando base de conhecimento..."
sleep 5

RESPONSE=$(nlm chat "$NOTEBOOK_ID" "Liste os principais tópicos cobertos pela documentação deste projeto" 2>/dev/null || echo "")

if [ -n "$RESPONSE" ]; then
    echo ""
    log_info "NotebookLM respondeu com sucesso. Base de conhecimento ativa."
    echo ""
    echo "Resposta de validação:"
    echo "─────────────────────"
    echo "$RESPONSE"
    echo "─────────────────────"
else
    log_warn "Não foi possível validar automaticamente."
    log_warn "Abra o NotebookLM manualmente e verifique os sources."
fi

echo ""
echo "=== Envio concluído ==="
echo ""
