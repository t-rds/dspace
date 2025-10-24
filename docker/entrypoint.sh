#!/bin/bash
set -e

echo "🧭 Verificando instalação do DSpace..."

if [ ! -f "$DSPACE_HOME/webapps/xmlui/web.xml" ]; then
  echo "⚙️ DSpace não detectado, iniciando fresh_install..."
  cd /installer
  ant fresh_install || { echo "❌ Erro ao executar fresh_install"; exit 1; }
else
  echo "✅ DSpace já instalado, pulando fresh_install."
fi

echo "🚀 Iniciando o DSpace..."
exec "$DSPACE_HOME/bin/dspace" run
