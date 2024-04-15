FROM golang:1.22.2-alpine3.19

WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod .
COPY go.sum .

# Download dependencies
RUN go mod download


COPY . .

RUN go build -o main .

EXPOSE 8080

CMD ["./main"]
