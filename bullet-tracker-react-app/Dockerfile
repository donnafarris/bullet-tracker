# Install latest version of node
FROM node:latest

# Create directory for app
RUN mkdir /app

# Set as current directory for RUN, ADD, COPY commands
WORKDIR /app

# Add to PATH
ENV PATH /app/node_modules/.bin:$PATH

# Add package.json from upstream
ADD package.json /app

# Install dependencies
RUN npm install --silent

# Add entire student fork (overwrites previously added package.json)
COPY . /app

# Uses port which is used by the actual application
EXPOSE 3002
 
# Finally runs the application
CMD [ "npm", "start" ]