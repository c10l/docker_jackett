How to run this container:

```shell
export JACKETT_PORT=9117
export JACKETT_CONFIG_DIR=/opt/Jackett/config
docker run -p $JACKETT_PORT:9117 -d -v "${JACKETT_CONFIG_DIR}":/config --name jackett cassianoleal/jackett
```
