require 'spec_helper'
require 'sass-media_query_combiner'

describe "Combiner" do
  it "should work with sass" do
    sass = <<SASS
h3
  color: orange

@media (max-width: 480px)
  h1
    color: red

@media (max-width: 980px)
  h4
    color: black

@media (max-width: 480px)
  h2
    color: blue

b
  color: yellow
SASS

    # NOTE: the weird interpolated space in there is required to match.
    # My editor strips out trailing whitespace, so that's how I get it to stay.
    Sass::Engine.new(sass).render.should == <<CSS
h3 {
  color: orange; }
b {
  color: yellow; }

@media (max-width: 480px) {
  h1 {
    color: red; }#{" "}
  h2 {
    color: blue; } }

@media (max-width: 980px) {
  h4 {
    color: black; } }
CSS
  end

  it "should handle webkit keyframes without hanging" do
    sass = <<SASS
    .test{ position: relative;
        @media (min-width: 30em){ top: 1px; }
        @media (min-width: 40em){ top: 2px; }

        @-webkit-keyframes animate-opacity {
             0%   { opacity: 0; }
             100% { opacity: 1; }
        }
}
.test2{ position: relative;
        @media (min-width: 30em){ top: 1px; }
        @media (min-width: 40em){ top: 2px; }
        }
SASS
    Timeout::timeout(2) do
      Sass::Engine.new(sass, syntax: :scss).render
    end
  end
end
