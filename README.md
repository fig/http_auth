# README

This is the beggining of an app that could receive and store data from a
bunch of remote Raspberry Pi backed sensors.


* Clone the repository

* `bundle install`

* `rails db:migrate`

* Run the tests `rake spec`

Data from Pis is authenticated with HTTP Basic Authentication

Example request(HTTP POST using libcurl)

```bash
curl \
--url     http://localhost:3000/readings \
--header  'Content-Type: application/json' \
--user    pi:THBPBPTHPT! \
--data    '{"reading": {"raspberry_id": "1", "temperature":"21"}}' \
```
