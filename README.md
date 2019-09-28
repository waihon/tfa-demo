# README

This README documents the steps to get the application up and running locally.

* Ruby version
  * 2.4.3

* Rails version
  * 5.2.2

* Configuration
  * Add reCAPTCHA's `site_key` and `secret_key` to `config/credentials.yml.enc`:
    1. `$ rm config/credentials.yml.enc`
    2. `$ EDITOR=vim bin/rails credentials:edit`
      ```
        recaptcha:
          site_key: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          secret_key: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      ```

* Database
  * PostgreSQL
  * `$ rails db:setup`

* Test
  * Dependencies:
    * ChromeDriver
      1. Visit [ChromeDriver](http://chromedriver.storage.googleapis.com/index.html) page.
      2. Download the file corresponding the your Chrome version for your OS.
      3. Unzip the download file.
      4. Move the `chromedriver` to a directory on the path, e.g. `/usr/loca/bin` on macOS.
  * How to run the test suite:
    * `$ rails spec`
