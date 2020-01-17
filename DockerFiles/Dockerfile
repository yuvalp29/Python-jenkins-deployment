FROM python:latest
MAINTAINER Yuval Podoksik ”ypodoksik29@cs.colman.ac.il”
RUN apk add --update python
COPY . /app
WORKDIR /app
ENTRYPOINT ["python"]
EXPOSE 8080
EXPOSE 80
CMD ["python", "./app/server.py"]
