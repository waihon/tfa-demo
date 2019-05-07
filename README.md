# README

This README documents the steps to get the application up and running locally.

* Ruby version
  * 2.4.3

* Rails version
  * 5.2.2

* Configuration
  * Add reCAPTCHA's `site_key` and `secret_key` to `config/credentials.yml.enc`:
    * `$ EDITOR=vim bin/rails credentials:edit`
    * ```
      recaptcha:
        site_key: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        secret_key: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      ```

* Database
  * PostgreSQL

* Test
  * Dependencies:
    * ChromeDriver
  * How to run the test suite:
    * `$ rails spec`
