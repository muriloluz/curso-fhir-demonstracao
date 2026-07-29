#!/usr/bin/env bash
# Baixa o validador oficial HL7 (validator_cli.jar) para recursos/validador/.
set -euo pipefail
cd "$(dirname "$0")"

DESTINO=recursos/validador/validator_cli.jar
URL=https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar

if [[ -f "$DESTINO" ]]; then
  echo "Já existe: $DESTINO ($(du -h "$DESTINO" | cut -f1))"
  exit 0
fi

echo "Baixando validator_cli.jar (~200 MB)..."
curl -L --progress-bar -o "$DESTINO" "$URL"
echo "OK: $DESTINO"
