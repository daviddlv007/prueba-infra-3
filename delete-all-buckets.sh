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
    aws s3api list-object-versions --bucket "$BUCKET" --output json > "$tmp"

    count=$(jq '[.Versions[]?, .DeleteMarkers[]?] | length' "$tmp")
    if [ "$count" -eq 0 ]; then
      rm -f "$tmp"
      break
    fi

    jq '{Objects: ([.Versions[]? | {Key:.Key, VersionId:.VersionId}] + 
                   [.DeleteMarkers[]? | {Key:.Key, VersionId:.VersionId}]) | .[:1000] }' \
       "$tmp" > "${tmp}.del"

    aws s3api delete-objects --bucket "$BUCKET" --delete "file://${tmp}.del" >/dev/null

    rm -f "$tmp" "${tmp}.del"
  done

  echo ">> Objetos eliminados. Ahora borrando bucket..."
  aws s3api delete-bucket --bucket "$BUCKET" --region "$REGION"
  echo ">> Bucket $BUCKET eliminado ✅"
}

for b in "${BUCKETS[@]}"; do
  empty_and_delete_bucket "$b"
done
