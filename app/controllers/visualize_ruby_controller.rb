require "visualize_ruby"

class VisualizeRubyController < ApplicationController
  def show
    svg = VisualizeRuby::Graphviz.new(
        *VisualizeRuby::Builder.new(ruby_code: ruby_code).build
    ).to_graph(svg: String)
    expires_in 1.hour, public: true
    render json: { svg: svg }
  rescue Parser::SyntaxError => e
    render json: { exception: e.message}, status: :bad_request
  end

  private

  def ruby_code
    JSON.parse(request.raw_post)["ruby_code"]
  end
end
