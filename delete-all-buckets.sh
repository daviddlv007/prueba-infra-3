#!/usr/bin/env bash
set -euo pipefail

REGION="us-east-1"
BUCKETS=(
  "prueba-infra-3-dev-7f3a2c"
  "terraform-state-879381239285-dev"
  "elasticbeanstalk-us-east-1-879381239285"
)

empty_and_delete_bucket() {
  local BUCKET=$1
  echo "================================================================"
  echo ">> Procesando bucket: $BUCKET"
  echo "================================================================"

  while true; do
    tmp=$(mktemp)
    aws s3api list-object-versions --bucket "$BUCKET" > "$tmp"

    # Extraer claves y versionId con grep + awk
    KEYS=$(grep '"Key":' "$tmp" | awk -F'"' '{print $4}')
    VERSIONIDS=$(grep '"VersionId":' "$tmp" | awk -F'"' '{print $4}')

    if [ -z "$KEYS" ]; then
      rm -f "$tmp"
      break
    fi

    del=$(mktemp)
    echo '{"Objects":[' > "$del"
    paste -d' ' <(echo "$KEYS") <(echo "$VERSIONIDS") | \
    awk '{printf "{\"Key\":\"%s\",\"VersionId\":\"%s\"},", $1, $2}' >> "$del"
    sed -i 's/,$//' "$del"   # eliminar coma final
    echo ']}' >> "$del"

    aws s3api delete-objects --bucket "$BUCKET" --delete "file://$del" >/dev/null

    rm -f "$tmp" "$del"
  done

  echo ">> Objetos eliminados. Ahora borrando bucket..."
  aws s3api delete-bucket --bucket "$BUCKET" --region "$REGION"
  echo ">> Bucket $BUCKET eliminado ✅"
}

for b in "${BUCKETS[@]}"; do
  empty_and_delete_bucket "$b"
done
