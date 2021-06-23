## Deploying the webb application on remote server in Docker container

### Dockerfile
```dockerfile
FROM python:3.7

WORKDIR /code

COPY ./requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

EXPOSE 9010

CMD gunicorn -b 0.0.0.0:9010 app:server
```

If it's Dash application then app:server refers to: 
```python
app = dash.Dash(__name__)
server = app.server
```


### docker-compose.yml
Remember to connect other volumes with data if the application uses data from outside of the current mount scope
```yaml
version: "3"
services:
  app_name:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "9010:9010"
    expose:
      - "9010"
    restart: always
    volumes:
      - ./:/code
```
