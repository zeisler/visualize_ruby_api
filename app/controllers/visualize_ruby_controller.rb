require "visualize_ruby"

class VisualizeRubyController < ApplicationController
  def show
    expires_in 1.hour, public: true
    case format
    when :png, :dot
      tempfile.binmode
      graph
      send_file tempfile.path, type: media_type, x_sendfile: true
      tempfile.close
    else
      render json: { graph: graph }
    end
  rescue Parser::SyntaxError => e
    render json: { exception: e.message }, status: :bad_request
  end

  def version
    render json: { version: VisualizeRuby::VERSION }
  end

  private

  def graph
    graphs = VisualizeRuby::Builder.new(ruby_code: ruby_code).build
    VisualizeRuby::Graphviz.new(
        *graphs
    ).to_graph(path: path, format: format)
  end

  def ruby_code
    JSON.parse(request.raw_post)["ruby_code"]
  end

  def format
    params.fetch(:format, :svg).to_sym
  end

  def path
    case format
    when :svg
      nil
    else
      tempfile
    end
  end

  def media_type
    case format
    when :png
      "application/png"
    when :dot
      "text/plain"
    end
  end

  def tempfile
    @tempfile ||= Tempfile.new("graph")
  end
end
