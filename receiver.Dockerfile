FROM golang:1.21-alpine as base

WORKDIR /app

COPY . /app
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build ./cmd/receiver/receive.go

# RUNNER
FROM alpine:latest
WORKDIR app
COPY --from=base /app/receive .

CMD [ "./receive" ]
