FROM python:3-alpine

RUN apk add --no-cache bash curl iputils git

RUN mkdir -p /tmp/gotty 
RUN wget -c https://github.com/sorenisanerd/gotty/releases/download/v1.5.0/gotty_v1.5.0_linux_amd64.tar.gz -O - | tar -zx -C /tmp/gotty/
RUN mv /tmp/gotty/gotty /usr/local/bin/ 

RUN pip install flask dnspython

WORKDIR /app
COPY *.py /app/

ADD start.sh /app
RUN chmod +x /app/start.sh

RUN adduser -D user
RUN chown user:user /app/start.sh
USER user

COPY bashrc /home/user/.bashrc

WORKDIR /home/user

CMD ["/app/start.sh"]
