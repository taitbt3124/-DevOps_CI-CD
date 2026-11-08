set -e

CONTAINER_NAME="rikkei-frontend-qa"
IMAGE="nginx"
API_ENDPOINT="https://qa-api.rikkei.edu.vn"

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

docker run -d \
  --name "$CONTAINER_NAME" \
  -e API_ENDPOINT="$API_ENDPOINT" \
  "$IMAGE"

docker ps --filter "name=$CONTAINER_NAME"

docker exec -it "$CONTAINER_NAME" bash
