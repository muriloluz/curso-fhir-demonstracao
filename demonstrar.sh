#!/usr/bin/env bash
# Demonstração completa: FSH → JSON (SUSHI) → validação (validator_cli).
set -euo pipefail
cd "$(dirname "$0")"

BUNDLE=fsh-generated/resources/Bundle-rac-bundle-completo.json
BUNDLE_AMPLIADO=fsh-generated/resources/Bundle-rac-bundle-ampliado.json

echo "== 1/3 Cache do SUSHI (br.ufg.cgis.rnds-lite#0.5.0) =="
CACHE="$HOME/.fhir/packages/br.ufg.cgis.rnds-lite#0.5.0"
if [[ -d "$CACHE" ]]; then
  echo "  já no cache — ok"
else
  mkdir -p "$CACHE"
  tar -xzf recursos/rnds-lite-0.5.0.tgz -C "$CACHE"
  echo "  instalado em $CACHE"
fi

echo
echo "== 2/3 SUSHI: compilando FSH → JSON =="
sushi .
echo "  gerado: $BUNDLE"
echo "  gerado: $BUNDLE_AMPLIADO"

echo
echo "== 3/3 Validador oficial HL7 =="
java -jar recursos/validador/validator_cli.jar \
     "$BUNDLE" \
     "$BUNDLE_AMPLIADO" \
     -version 4.0.1 -ig recursos/rnds-lite-0.5.0.tgz
