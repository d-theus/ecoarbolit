FROM dtheus/rails

ENV RAILS_ENV production
ENV BUNDLE_WITHOUT test:development
ENV PATH $RBENV_ROOT/shims/:$PATH

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN rbenv exec bundle install

ADD . $HOME/app/
USER root
RUN chown -R web $HOME/app
USER web
WORKDIR $HOME/app/
RUN bundle exec rake assets:clobber; \
      bundle exec rake tmp:clear; \
      bundle exec rake assets:precompile; \
      bundle exec rake sitemap:refresh

CMD rm -rf /tmp/rails.pid; bundle exec rails s --pid=/tmp/rails.pid
