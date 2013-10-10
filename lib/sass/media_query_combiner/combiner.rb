module Sass
  module MediaQueryCombiner
    module Combiner
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
                [^{}]*        #     Anything that is not a brace
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
end
