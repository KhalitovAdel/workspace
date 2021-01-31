# workspace
Based on code-server

dependency: docker, docker-compose

RUN command: 

```
docker-compose up -d && sudo chown $(id -u):$(id -g) -R ~/default
```

GOTO: https://default.$(DEFAULT_HOST)

RUN command one more workspace: 

```
WORKSPACE_NAME=second docker-compose up -d workspace && sudo chown $(id -u):$(id -g) -R ~/$(WORKSPACE_NAME)
```

GOTO: https://$(WORKSPACE_NAME).$(DEFAULT_HOST)

You can rewrite all env:

```
CUID=1000
CGID=1000
WORKSPACE_NAME=default
PASSWORD=Qwerty12345
DEFAULT_HOST=workspace.adel.khalitov.monster
```
