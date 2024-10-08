FROM node:20-slim as builder
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
COPY . /app
WORKDIR /app
RUN corepack enable pnpm \
  && pnpm i\
  && pnpm b

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app/.vitepress/dist /usr/share/nginx/html/

EXPOSE 80
