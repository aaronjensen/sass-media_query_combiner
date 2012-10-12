require 'spec_helper'
require 'sass-media_query_combiner'

describe "Combiner" do
  it "should with sass" do
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

    Sass::Engine.new(sass).render.should == <<CSS
h3 {
  color: orange; }
b {
  color: yellow; }

@media (max-width: 480px) {
  h1 {
    color: red; } 
  h2 {
    color: blue; } }

@media (max-width: 980px) {
  h4 {
    color: black; } }
CSS
  end
end
