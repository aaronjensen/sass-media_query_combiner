require "sass/media_query_combiner/version"
require "sass"

module Sass
  module MediaQueryCombiner
    def self.combine(css)
      queries = Hash.new { |hash, key| hash[key] = '' }
      pretty = true

      filtered_data = css.gsub(/\n?(?<query>@media[^{]+){(?<body>(?<braces>(?:[^{}]+)|({\g<braces>}))*)}\n?/m) do |match|
        queries[$1] << $2
        pretty &&= /\n$/m === match
        ''
      end

      combined = queries.map { |query, body| "#{query}{#{body}}" }.
        join(("\n\n" if pretty))
      "#{filtered_data}#{"\n" if pretty}#{combined}\n"
    end
  end
end

Sass::Engine.class_eval do
  def render_with_combine
    Sass::MediaQueryCombiner.combine(render_without_combine)
  end
  alias_method :render_without_combine, :render
  alias_method :render, :render_with_combine
  alias_method :to_css, :render_with_combine
end
