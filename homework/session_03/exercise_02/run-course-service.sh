set -e

CONTAINER_NAME="rikkei-course-service"
IMAGE="nginxdemos/hello"
HOST_PORT=8081
CONTAINER_PORT=80

docker rm -f "$CONTAINER_NAME" 2>/dev/null || true
docker run -d \
  --name "$CONTAINER_NAME" \
  -p "$HOST_PORT":"$CONTAINER_PORT" \
  "$IMAGE"

sleep 2

docker ps --filter "name=$CONTAINER_NAME"

curl -s http://localhost:"$HOST_PORT" | head -n 30
