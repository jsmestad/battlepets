# BattlePets Manager

**TODO** Description of the application

## Requirements

* SQLite (or change the `config/database.yml` to a different driver)

## Getting Started

### Up and Running

Assuming you've cloned the repo and are in the working directory:

```
bundle install
bundle exec rake db:create db:migrate db:test:prepare
bundle exec rspec
```

Assuming everything went well, the output should be a passing spec suite stating
no failures:

```
17 examples, 0 failures
```

### Viewing API Docs

Run the following commands:

```
bundle exec rails s
```

Visit [/api/docs](http://localhost:3000/api/docs) to view the API documentation


