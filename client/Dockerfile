# Specify the base image
FROM node:alpine
# Set up the working directory
WORKDIR '/app'
# Copy over the package.json file
COPY ./package*.json ./
# Install node dependencies
RUN npm install
# Copy over all the other files
COPY ./ ./
# Build the project
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html