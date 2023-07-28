# Use the official Elixir image as the base image
FROM elixir:latest

# Set the working directory in the container
WORKDIR /app

# Generate private key
RUN openssl genrsa -out private_key.pem 4096

# Copy the application files into the container
COPY . .

# Install dependencies
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

# Build the application
RUN mix compile

# ENV MIX_ENV=prod

# Start the application
EXPOSE 4000
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
CMD ["mix", "phx.server"]


