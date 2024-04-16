FROM golang:1.21-alpine AS builder 

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV PORT=3200

WORKDIR /home/project

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o ./go_server

# RUN ./go_server

CMD [ "./go_server" ] 

# FROM nginx:1.25 as Final

# WORKDIR /usr/share/nginx/html/
# COPY --from=builder /home/project/go_server ./

# CMD [ "./go_server" ]