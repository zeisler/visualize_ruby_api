FROM ruby:2.7

# Install dependencies including Graphviz
RUN apt-get update && apt-get install -y \
    graphviz \
    redis-server

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the working directory
COPY Gemfile Gemfile.lock ./

# Install the required gems
RUN bundle install

# Copy the rest of the application code into the working directory
COPY . .

# Expose the port that the application runs on
EXPOSE 3000

ENV RAILS_ENV=production

CMD service redis-server start && \
    SECRET_KEY_BASE=$(rails secret) && \
    echo "Generated SECRET_KEY_BASE: $SECRET_KEY_BASE" && \
    SECRET_KEY_BASE=$SECRET_KEY_BASE rails server
