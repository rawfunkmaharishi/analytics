# Data Science for Music Streaming

We sell our music through [State51](https://state51.com/), and every month they send us an awful, hard-to-comprehend spreadsheet with our sales data in it. So I thought I'd see if I could make it more useful with some Ruby and Docker

## Getting the data

Download the "detail view" spreadsheet, open it in Google Sheets and export it as a CSV, then place it in the `data/` dir with a sensible ISO8801-compliant name (`2019-10-08` or something)

## Building the Docker image

```
make build
```` 

ought to do it

## Running it

Populate the `fields` list in `conf.yaml` with the indeces of the fields you'd like to anaylyse (`8`, `9`, `1` and `24`, which we're using, correspond to `Album Title`, `Track Title`, `Music Service` and `Country of Sale`), then 

```
make analyse
``` 

will attempt to parse the newest file it finds under `data/` and should generate some output like:

```
********************************************************************************

Data from 2019-10-18.csv:

  The top 3 results for Album Title are:
    * Junk Science (146 occurences)
    * Flux (27 occurences)
    * Takatsuka (23 occurences)

  The top 10 results for Track Title are:
    * Hippy Jazz (73 occurences)
    * Hope to Go (14 occurences)
    * New York Stuntman (14 occurences)
    * Could Be (13 occurences)
    * Chemosphere (12 occurences)
    * Fabric (12 occurences)
    * Basic Era (8 occurences)
    * Boot (8 occurences)
    * The Cone Mill (6 occurences)
    * Ceramic Dragon (4 occurences)

  The top 10 results for Music Service are:
    * Spotify - Stream (36 occurences)
    * iTunes - EU Apple Music (27 occurences)
    * iTunes - JP Apple Music (27 occurences)
    * iTunes - US Apple Music (24 occurences)
    * iTunes - UK Apple Music (12 occurences)
    * iTunes - CA Apple Music (9 occurences)
    * iTunes - RoW Apple Music (6 occurences)
    * iTunes - BR Apple Music (5 occurences)
    * Google Play - Google Locker GB (5 occurences)
    * iTunes - RU Apple Music (4 occurences)

  The top 10 results for Country of Sale are:
    * GB (56 occurences)
    * JP (29 occurences)
    * US (27 occurences)
    * DE (13 occurences)
    * CA (9 occurences)
    * UA (6 occurences)
    * FR (6 occurences)
    * BR (5 occurences)
    * RU (4 occurences)
    * DK (3 occurences)

Possibly we made £4.43 in sales, but it's hard to tell

********************************************************************************
```

## Developing it

If you'd like to play with the code (and God knows it needs help) then something like 

```
make run
```

will drop you into a shell from which you can run 

```
ruby analyse.rb /opt/data/2019-10-18.csv
``` 

or similar 

## Running the tests

There are no tests