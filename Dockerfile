FROM golang:1.21-alpine as build
ARG GO_VERSION=1.19

#Define Environment variable for cross platform c compilation
ENV CGO_ENABLED=0
LABEL author ="khandokar ismail"

#Define default working directory
WORKDIR /app

#Copy go.mod,go.sum in default directory
COPY go.mod go.sum ./

#Downloading all the necessary go libraries.
RUN go mod download
COPY *.go ./

#Building Go app binary.
RUN go build -o /gapp

#Starting release stage using "base-debian11" as base image which is minimal and production ready
FROM gcr.io/distroless/base-debian11 as release
ENV PORT=9000
WORKDIR /
#Copying binary form buils stage
COPY --from=build ./gapp /gapp
ENTRYPOINT [ "/gapp" ]