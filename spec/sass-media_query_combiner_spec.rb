require 'spec_helper'
require 'sass-media_query_combiner'

describe "Combiner" do
  let(:sass) { <<SASS }
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

  it "should work with sass" do
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

  it "should work with debug_info: true" do
    Timeout::timeout(1) do
      Sass::Engine.new(sass, debug_info: true).render.should == <<CSS
@media -sass-debug-info{filename{}line{font-family:\\000031}}
h3 {
  color: orange; }
@media -sass-debug-info{filename{}line{font-family:\\0000316}}
b {
  color: yellow; }

@media (max-width: 480px) {
@media -sass-debug-info{filename{}line{font-family:\\000035}}
  h1 {
    color: red; }#{" "}
@media -sass-debug-info{filename{}line{font-family:\\0000313}}
  h2 {
    color: blue; } }

@media (max-width: 980px) {
@media -sass-debug-info{filename{}line{font-family:\\000039}}
  h4 {
    color: black; } }
CSS
    end
  end
end
