# Use the official Node.js 18 image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --frozen-lockfile

# Copy the rest of the app
COPY . .

# Build the Next.js app
RUN npm run build

# Use a smaller runtime image
FROM node:18-alpine

WORKDIR /app

# Copy built files from the builder stage
COPY --from=builder /app ./

# Expose the port Next.js runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
