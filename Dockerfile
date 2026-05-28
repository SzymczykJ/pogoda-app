# Etap 1: instalacja zależności
FROM node:22-alpine AS deps

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

# Etap 2: obraz końcowy
FROM node:22-alpine AS runner

WORKDIR /app

LABEL org.opencontainers.image.authors="Julia Szymczyk"
LABEL org.opencontainers.image.title="Aplikacja pogodowa"
LABEL org.opencontainers.image.description="Prosta aplikacja pogodowa Node.js Express"

ENV NODE_ENV=production
ENV PORT=8080

RUN rm -rf /usr/local/lib/node_modules/npm \
    && rm -f /usr/local/bin/npm /usr/local/bin/npx

COPY --from=deps /app/node_modules ./node_modules
COPY package*.json ./
COPY server.js ./
COPY public ./public

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:8080/ || exit 1

USER node

CMD ["node", "server.js"]
