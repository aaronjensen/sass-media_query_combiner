require 'spec_helper'
require 'sass/media_query_combiner/combiner'

describe Sass::MediaQueryCombiner::Combiner do
  it "should handle keyframes in media queries" do
    Timeout::timeout(0.5) do
      Sass::MediaQueryCombiner::Combiner.combine <<CSS
@media (min-width: 40em) {
  @-webkit-keyframes whatever {}
}
CSS
    end
  end
end
