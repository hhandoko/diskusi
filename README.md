[![License](https://img.shields.io/badge/license-Apache--2.0-brightgreen.svg)](LICENSE)
[![Master Build Status](https://travis-ci.org/hhandoko/diskusi.svg?branch=master)](https://travis-ci.org/hhandoko/diskusi)

# Diskusi

`diskusi` is a comments system and discussion board inspired by Disqus.

## Prerequisites

### Develop and Compile Dependencies

The following binaries / libraries need to be installed in order to compile the web application.
The version numbers denotes the specific version used to develop the web application, it may or may not work under other minor versions:

  - [Elixir Lang] v1.4.x
  - [Elm Lang] v0.18.x
  - [Phoenix Framework] v1.2.x
  - [Node.js] v7.5.x
  - [npm] v4.5.x
  - [Ruby] v2.2.x
  - [Sass] v3.4.x

### Services (Database) Dependencies

The following applications need to be installed in order to provision an Ubuntu guest VM (1 core, 1GB RAM) which will contain the necessary services:

  * [Oracle VM VirtualBox] v5.1.x
  * [Vagrant] v1.9.x

The following Vagrant plugin is not mandatory, but help speed up subsequent box provisioning by caching common packages:

  * [vagrant-cachier]

Successful Vagrant provisioning will enable the following services to be available within a guest VM:

  * [PostgreSQL] v9.6.x

## Setup Steps

  1. Configure the services:
     1. Run `vagrant up`
  1. Install dependencies:
     1. Install Phoenix dependencies with `mix deps.get`
     1. Configure Dialyzer support with `mix do compile, dialyzer --plt` (this will take a few minutes on first run)
     1. Install npm dependencies with `npm install`
  1. Data store setup:
     1. Create database with `mix ecto.create`
     1. Migrate database with `mix ecto.migrate`
     1. Seed the database with `mix run priv/repo/seeds.exs`
  1. Run type-checker:
     1. Run Dialyzer with `mix dialyzer`
  1. Run tests:
     1. Run Elixir tests with `mix test`
     1. Run JavaScript and Elm tests with `npm test`
  1. Start application with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

*NOTE: Run `mix docs` to generate (updated) doc-comment documentation.*

## Contributing

We follow the "[feature-branch]" Git workflow.

  1. Commit changes to a branch in your fork (use `snake_case` convention):
     - For technical chores, use `chore/` prefix followed by the short description, e.g. `chore/do_this_chore`
     - For new features, use `feature/` prefix followed by the feature name, e.g. `feature/feature_name`
     - For bug fixes, use `bug/` prefix followed by the short description, e.g. `bug/fix_this_bug`
  1. Rebase or merge from "upstream"
  1. Submit a PR "upstream" to `develop` branch with your changes

Please read [CONTRIBUTING] for more details.

## License

`diskusi` is released under the Apache Version 2.0 License. See the [LICENSE] file for further details.

[CONTRIBUTING]: https://github.com/hhandoko/diskusi/blob/master/CONTRIBUTING.md
[Elixir Lang]: http://elixir-lang.org
[Elm Lang]: http://elm-lang.org/
[feature-branch]: http://nvie.com/posts/a-successful-git-branching-model/
[LICENSE]: https://github.com/hhandoko/diskusi/blob/master/LICENSE.txt
[Node.js]: https://nodejs.org
[npm]: https://www.npmjs.com
[Oracle VM VirtualBox]: https://www.virtualbox.org
[Phoenix Framework]: http://www.phoenixframework.org
[PostgreSQL]: http://www.postgresql.org
[Ruby]: https://www.ruby-lang.org
[Sass]: http://sass-lang.com
[Vagrant]: https://www.vagrantup.com
[vagrant-cachier]: https://github.com/fgrehm/vagrant-cachier
