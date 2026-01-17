FROM node:20-alpine

WORKDIR /app

# Install system dependencies
RUN apk add --no-cache python3 make g++ cairo-dev pango-dev libpng-dev libjpeg-turbo-dev giflib-dev

# Copy package files
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn ./.yarn
COPY packages ./packages

# Install dependencies
RUN corepack enable && yarn install

# Copy rest of source
COPY . .

# Build the server
RUN yarn nx build twenty-server

# Expose port
EXPOSE 3000

# Start command
CMD ["sh", "-c", "yarn database:init:prod && yarn nx start twenty-server"]

