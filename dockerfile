# Use Node.js version 16 as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files into the container
COPY package*.json ./

# Install the dependencies (this will include Jest if it's in your package.json)
RUN npm install && npm list --depth=0

# Copy the rest of the application files into the container
COPY . .

# Expose the application on port 3000 (for HTTP server)
EXPOSE 3000

# Set the command to run the app (usually, "start" is used to run the app)
CMD ["npm", "start"]
