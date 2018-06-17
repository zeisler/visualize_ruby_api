require "visualize_ruby"

class VisualizeRubyController < ApplicationController
  def show
    svg = VisualizeRuby::Graphviz.new(
        *VisualizeRuby::Parser.new(JSON.parse(request.raw_post)["ruby_code"]).parse
    ).to_graph(svg: String)
    expires_in 1.hour, :public => true
    render json: { svg: svg }
  end
end
