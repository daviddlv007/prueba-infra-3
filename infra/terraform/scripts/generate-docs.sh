#!/bin/bash
set -e

# Generar documentación básica de la infraestructura
if [ -f "infrastructure.json" ]; then
    echo "# Infrastructure Documentation" > infrastructure.md
    echo "Generated on: $(date)" >> infrastructure.md
    echo "" >> infrastructure.md
    echo "## Terraform Outputs" >> infrastructure.md
    echo '```json' >> infrastructure.md
    cat infrastructure.json >> infrastructure.md
    echo '```' >> infrastructure.md
    echo "Documentation generated at infrastructure.md"
else
    echo "No infrastructure.json found, skipping documentation generation"
fi