FROM docker.n8n.io/n8nio/n8n

USER root

# Install Chrome dependencies and Chrome
RUN apk add --no-cache \
    chromium \
    nss \
    glib \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    udev \
    ttf-liberation \
    font-noto-emoji

# Tell Puppeteer to use installed Chrome instead of downloading it
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser


RUN npm install -g puppeteer
RUN apk add --no-cache chromium
# Install n8n-nodes-puppeteer in a permanent location
COPY . /opt/n8n-custom-nodes/node_modules/n8n-nodes-puppeteer
RUN cd /opt/n8n-custom-nodes/node_modules/n8n-nodes-puppeteer && \
    npm install && \
		npm run build && \
    chown -R node:node /opt/n8n-custom-nodes



USER node

