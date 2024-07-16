FROM golang:1.22 AS build-stage

WORKDIR /app

COPY go.mod ./
RUN go mod download

ADD cmd/ ./cmd/
ADD handler/ ./handler/
ADD template/ ./template/

RUN CGO_ENABLED=0 GOOS=linux go build -o go-htmx cmd/server/server.go

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /app/go-htmx .
COPY --from=build-stage /app/template/ ./template/

EXPOSE 8000

USER nonroot:nonroot

ENTRYPOINT ["/go-htmx"]