FROM node:20-alpine

WORKDIR /app

# Install dependencies
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn ./.yarn
RUN corepack enable && yarn install

# Copy source and build
COPY . .
RUN yarn build

# Expose port
EXPOSE 3000

# Start command
CMD ["sh", "-c", "yarn database:init:prod && yarn start:prod"]
