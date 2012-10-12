# Sass::MediaQueryCombiner

Combines all matching media queries while compiling your Sass. 

If you're using
Rails 3.1+ or Sprockets, you should use [sprockets-media_query_combiner](https://github.com/aaronjensen/sprockets-media_query_combiner)

For example:

```css
h3 {
  color: orange
}
@media (max-width: 480px) {
  h1 {
    color: red
  }
}
@media (max-width: 980px) {
  h4 {
    color: black
  }
}
@media (max-width: 480px) {
  h2 {
    color: blue
  }
}
```

Would end up as (except the whitespace won't be so clean):

```css
h3 {
  color: orange
}
@media (max-width: 480px) {
  h1 {
    color: red
  }
  h2 {
    color: blue
  }
}
@media (max-width: 980px) {
  h4 {
    color: black
  }
}
```

### Note

**This will change the order of your css, so be aware of that.** All the
`@media` queries will end up at the end of each css file in the order that
they are first encountered. In other words, if you're relying on only using
min-width or only using max-width in a specific order you'll want to be sure
define your media queries in the right order up front before you use them
randomly throughout your file.

## Installation

Add this line to your application's Gemfile:

    gem 'sass-media_query_combiner'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sass-media_query_combiner

## Usage

It should just work as long as `sass-media_query_combiner` is required. If you're using
`sass --watch` do:

```bash
sass --watch -r sass-media_query_combiner
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
