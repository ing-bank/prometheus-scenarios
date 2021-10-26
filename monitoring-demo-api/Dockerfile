FROM golang:1.14 AS builder

RUN mkdir /app
WORKDIR /app
COPY . .
RUN export CGO_ENABLED=0; go build -o .build/mondemoapi cmd/mondemoapi/main.go


FROM alpine:latest

COPY --from=builder /app/.build/mondemoapi /bin/mondemoapi
RUN chmod 555 /bin/mondemoapi
EXPOSE 8080
CMD [ "/bin/mondemoapi" ]