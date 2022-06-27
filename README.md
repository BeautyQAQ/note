# 内容

```yml
# portainer
version: '3'

services:
  portainer:
    image: portainer/portainer-ce
    container_name: portainer
    command: -H unix:///var/run/docker.sock
    restart: always
    ports:
      - 9000:9000
      - 8000:8000
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data portainer/portainer-ce

volumes:
  portainer_data:
```


```yml
# PostgreSQL
version: "3"

services:
  postgres:
    image: postgres:14-alpine
    container_name: postgresql
    environment:
      POSTGRES_USER: root
      POSTGRES_PASSWORD: root
    ports:
      - 5432:5432
    volumes:
      - /usr/local/PostgreSQL/data:/var/lib/postgresql/data
```