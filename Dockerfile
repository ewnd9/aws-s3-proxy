FROM golang:1.20-alpine as builder
WORKDIR /build
COPY go.mod go.sum .
RUN go mod download
COPY *.go ./
COPY internal ./internal
RUN CGO_ENABLED=0 GOOS=linux go build -o /main main.go

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder main /bin/main
ENTRYPOINT ["/bin/main"]
