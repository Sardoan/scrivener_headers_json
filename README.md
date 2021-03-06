# Scrivener.Headers

[![Build Status][travis-img]][travis] [![Hex Version][hex-img]][hex] [![Hex docs][hexdocs-img]][hexdocs] [![License][license-img]][license]

[travis-img]: https://travis-ci.org/doomspork/scrivener_headers.png?branch=master
[travis]: https://travis-ci.org/doomspork/scrivener_headers
[hex-img]: https://img.shields.io/hexpm/v/scrivener_headers.svg
[hex]: https://hex.pm/packages/scrivener_headers
[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg
[license]: http://opensource.org/licenses/MIT
[hexdocs-img]: http://img.shields.io/badge/hex-docs-green.svg?style=flat
[hexdocs]: https://hexdocs.pm/scrivener_headers/Scrivener.Headers.html


Helpers for paginating API responses with [Scrivener](https://github.com/drewolson/scrivener) and HTTP headers.  Implements [RFC-5988](https://mnot.github.io/I-D/rfc5988bis/), the proposed standard for Web linking.

## Setup

Add to `mix.exs`:

```elixir
  defp deps do
    [
      # ...
      {:scrivener_headers_json,
    	git: "https://github.com/Sardoan/scrivener_headers_json"}
      # ...
    ]
  end
```

## Usage

Add this configuration for custom header names:

```elixir
config :scrivener_headers_json, link: "link"
config :scrivener_headers_json, total: "total"
config :scrivener_headers_json, per_page: "per-page"
config :scrivener_headers_json, total_pages: "total-pages"
config :scrivener_headers_json, page_number: "page-number"
```

With `paginate/2` we can easily set our pagination headers:

```elixir
def index(conn, params) do
  page = MyApp.Person
         |> where([p], p.age > 30)
         |> order_by([p], desc: p.age)
         |> preload(:friends)
         |> MyApp.Repo.paginate(params)

  conn
  |> Scrivener.Headers.paginate(page)
  |> render("index.json", people: page.entries)
end
```

With `curl --include` we can see our new headers:

```shell
$ curl --include 'https://localhost:4000/people?page=5'
HTTP/1.1 200 OK
Link: {"first":"http://localhost:4000/people?page=1",
  "last":"http://localhost:4000/people?page=30",
  "next":"http://localhost:4000/people?page=6",
  "prev":"http://localhost:4000/people?page=4"}
Total: 300
Per-Page: 10
```

## Contributing

Contributions of all types are welcomed and encouraged.  Based on [scrivener_headers][scrivener_header] .

[scrivener_header]: https://github.com/doomspork/scrivener_headers/

## License

MIT license. Please see [LICENSE][license] for details.

[LICENSE]: https://github.com/doomspork/scrivener_headers/blob/master/LICENSE
