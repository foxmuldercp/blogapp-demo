== BlogApp

This small BlogApp based on official Rails Guides with my Twitter-style clone interpretation

App contains my custom authentication module via JWT, Users, Categories, Posts and Comments
Categories and Posts can be created only via registered users.

All application routes located in '/api' scope. I create example nginx configuration file for use it as proxy.

Front-end reactjs application located into external git repo

* Ruby version: Tested on 2.5.0, Rails version 5.1.4

* Ruby installation via rbenv Instructions.
  if you use non-bash shell, update config names 5-7,10 items for your shell .configrc file

    $ sudo apt-get update
    $ sudo apt-get install -y mc zsh git lsof less curl wget nodejs
    $ sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
    $ cd
    $ git clone git://github.com/sstephenson/rbenv.git .rbenv
    $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    $ echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    $ exec $SHELL
    $ git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    $ echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    $ exec $SHELL
    $ git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
    $ rbenv install 2.5.0
    $ rbenv global 2.5.0
    $ ruby -v
    $ echo "gem: --no-ri --no-rdoc" > ~/.gemrc
    $ gem install bundler
    $ gem install rails
    $ rbenv rehash
    $ git clone https://github.com/foxmuldercp/blogapp.git
    $ cd blogapp
    $ bundle install
    $ rake tests

* Now You can run app on 3000 port.

    $ rails s

* If you want use external database, such as MySQL or PostgreSQL, use external instructions, this application
  now use sqlite.
