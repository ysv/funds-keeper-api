FROM ruby:2.5.1

ENV RAILS_ENV=production APP_HOME=/home/app

# Create user "app".
RUN useradd --system --create-home --home ${APP_HOME}\
    --shell /sbin/nologin --no-log-init --user-group app

WORKDIR $APP_HOME

# Install dependencies defined in Gemfile.
COPY Gemfile Gemfile.lock $APP_HOME/
RUN mkdir -p /opt/vendor/bundle \
 && chown -R app:app /opt/vendor \
 && su app -s /bin/bash -c "bundle install --path /opt/vendor/bundle"

# Copy application sources.
COPY . $APP_HOME
# TODO: Use COPY --chown=app:app when Docker Hub will support it.
RUN chown -R app:app $APP_HOME

# Switch to application user.
USER app

EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server"]
