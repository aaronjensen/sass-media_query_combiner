require "sass/media_query_combiner/version"
require "sass"

module Sass
  module MediaQueryCombiner
    def self.combine(css)
      queries = Hash.new { |hash, key| hash[key] = '' }
      pretty = true

      filtered_data = css.gsub(/
        \n?                 # Optional newline
        (?<query>           # The media query parameters, this will be $1
          @media            #   Start with @media
          [^{]+             #   One to many characters that are not {, we are guaranteed to have a space
        )
        {
        (?<body>            # The actual body, this will be $2
          (?<braces>        #   Recursive capture group
            (?:
              [^{}]+        #     Anything that is not a brace
            )
            |               #     OR
            (
              {\g<braces>}  #     Recursively capture things within braces, this allows for balanced braces
            )
          )*                # As many of these as we have
        )
        }
        \n?                 # Optional newline
        /mx) do |match|
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
