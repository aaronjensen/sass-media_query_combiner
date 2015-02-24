module Sass
  module MediaQueryCombiner
    module Combiner
      def self.combine(css)
        queries = Hash.new { |hash, key| hash[key] = '' }
        pretty = true

        css, source_map_url = extract_source_map_url(css)

        filtered_data = css.gsub(/
          \n?                 # Optional newline
          (?<query>           # The media query parameters, this will be $1
            @media            #   Start with @media
            (?!\ -sass-debug-info) # Ignore sass-debug-info
            [^{]+             #   One to many characters that are not {, we are guaranteed to have a space
          )
          {
          (?<body>            # The actual body, this will be $2
            (?<braces>        #   Recursive capture group
              (?:
                [^{}]*        #     Anything that is not a brace
                |             #     OR
                {\g<braces>}  #     Recursively capture things within braces, this allows for balanced braces
              )*              # As many of these as we have
            )
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
        "#{filtered_data}#{"\n" if pretty}#{combined}#{source_map_url}\n"
      end

      def self.extract_source_map_url(css)
        source_map_url = ''

        css = css.gsub(/\n*\/\*# sourceMappingURL=.* \*\/$/m) do |match|
          source_map_url = match
          ''
        end

        return css, source_map_url
      end
    end
  end
end
