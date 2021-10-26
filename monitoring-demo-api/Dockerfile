FROM alpine:latest

COPY .build/mondemoapi /bin/mondemoapi
RUN chmod 555 /bin/mondemoapi
EXPOSE 8080
CMD [ "/bin/mondemoapi" ]