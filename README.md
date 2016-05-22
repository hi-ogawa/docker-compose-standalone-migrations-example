Usage example of [Dockerized standalone-migrations](https://github.com/hi-ogawa/docker-standalone-migrations) with docker-compose.

Commands to run:

```
-- prepare images --
$ docker-compose pull
$ docker-compose build


-- start postgresql server --
$ docker-compose up -d pg
Starting dockercomposemigratorexample_pg_data_box_1
Starting dockercomposemigratorexample_pg_1


-- run migration --
$ docker-compose run --no-deps --rm migrator rake db:migrate
== 20160522105041 CreateUserTable: migrating ==================================
-- execute("create table \"user\"(\n  \"email\" text,\n  \"password\" text\n)\n")
   -> 0.0019s
== 20160522105041 CreateUserTable: migrated (0.0027s) =========================


-- start application --
$ docker-compose run --no-deps --rm app /bin/bash -c 'app "postgresql://postgres@pg:5432/postgres"'
[User {emailField = "test@test.com", passwordField = "asdfjkl;"}]
[User {emailField = "test@test.com", passwordField = "asdfjkl;"},User {emailField = "foo@bar.com", passwordField = "12345678"}]
```
