# ./Dockerfile

# Extend from the official Elixir image.
FROM elixir:latest

# Create app directory and copy the Elixir projects into it.
# RUN mkdir /app
# COPY . /app
# WORKDIR /app

# Install Hex package manager.
# By using `--force`, we don’t need to type “Y” to confirm the installation.
# RUN mix local.hex --force

# Compile the project.
# RUN mix do compile

RUN mkdir /app
WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

# COPY assets/package.json ./assets/
# RUN npm install --prefix ./assets

COPY . .

RUN mix do release

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

CMD ["mix", "phx.server"]
