# Rails Devs

Find Rails developers looking for freelance and contract work.

<img width="1764" alt="image" src="https://user-images.githubusercontent.com/2092156/141209840-fea16afa-541b-4129-a8b0-8d2d544f7b4a.png">

### Getting started

#### Requirements

You need the following installed:

* Ruby 3.0 or higher
* [bundler](https://bundler.io) - `gem install bundler`
* [Imagemagick](https://imagemagick.org) - `brew install imagemagick`
* [Yarn](https://yarnpkg.com) - `brew install yarn`

Optional:

* [foreman](https://github.com/ddollar/foreman) - `gem install foreman`
* [overmind](https://github.com/DarthSim/overmind) - `gem install overmind`

#### Initial setup

An installation script is included with the repository that will automatically get the application setup.

```bash
bin/setup
```

### Development

Run the following (requires `foreman` or `overmind`) to start the server and automatically build assets.

```bash
bin/dev
```

### Testing

Run `rails test` to run unit/integration tests
