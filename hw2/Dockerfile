ARG GO_VERSION=1.22
ARG ALPINE_VERSION=3.19

# Stage 1: builder
FROM golang:1.22-alpine AS builder

WORKDIR /app

ARG VERSION=dev
ARG COMMIT=unknown
ARG BUILD_DATE=unknown

COPY go.mod ./
RUN go mod download

COPY main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-s -w -X main.version=${VERSION} -X main.commit=${COMMIT} -X main.buildDate=${BUILD_DATE}" \
    -o /server main.go

# Stage 2: runtime
FROM scratch

LABEL org.opencontainers.image.title="hello-docker" \
      org.opencontainers.image.description="Simple Go HTTP server" \
      org.opencontainers.image.source="https://github.com//hello-docker" 

USER 65532:65532

COPY --from=builder /server /server

EXPOSE 8080

ENTRYPOINT ["/server"]