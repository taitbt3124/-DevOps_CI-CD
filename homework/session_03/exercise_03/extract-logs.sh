set -e

CONTAINER_NAME="rikkei-course-service"
HOST_PORT=8081
LINES=15

docker start "$CONTAINER_NAME" >/dev/null

for i in $(seq 1 15); do
  curl -s -o /dev/null http://localhost:"$HOST_PORT"/
  curl -s -o /dev/null http://localhost:"$HOST_PORT"/courses/"$i"
done

docker logs --tail "$LINES" -t "$CONTAINER_NAME"
