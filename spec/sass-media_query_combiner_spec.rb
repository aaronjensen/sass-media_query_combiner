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
    expected_output = <<CSS
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

    Sass::Engine.new(sass).render.should == expected_output
  end

  it "should work with sourcemaps" do
    options = {
      filename: "out.css",
      sourcemap_filename: "out.css.map"
    }

    expected_output = <<CSS
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

/*# sourceMappingURL=out.css.map */
CSS

    output, _ = Sass::Engine.new(sass, options).render_with_sourcemap("out.css.map")
    output.should == expected_output
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
