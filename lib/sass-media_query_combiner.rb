require "sass/media_query_combiner/version"
require "sass/media_query_combiner/combiner"
require "sass"

Sass::Engine.class_eval do
  def render_with_combine
    Sass::MediaQueryCombiner::Combiner.combine(render_without_combine)
  end
  alias_method :render_without_combine, :render
  alias_method :render, :render_with_combine
  alias_method :to_css, :render_with_combine

  def render_with_sourcemap_with_combine(*args)
    rendered, sourcemap = render_with_sourcemap_without_combine(*args)

    rendered = Sass::MediaQueryCombiner::Combiner.combine(rendered)

    return rendered, sourcemap
  end
  alias_method :render_with_sourcemap_without_combine, :render_with_sourcemap
  alias_method :render_with_sourcemap, :render_with_sourcemap_with_combine
end
