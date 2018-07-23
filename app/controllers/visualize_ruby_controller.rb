require "visualize_ruby"
require File.join(Rails.root, "lib/create_graph")
require File.join(Rails.root, "lib/cache_graph")
require File.join(Rails.root, "lib/create_key")

class VisualizeRubyController < ApplicationController
  def show
    expires_in CacheGraph.to_i, public: true
    if download_file
      tempfile.binmode
      graph
      send_file tempfile.path, type: media_type, x_sendfile: true
      tempfile.close
    else
      render json: { graph: graph, format: format }
    end
  rescue Parser::SyntaxError => e
    render json: error_response(e), status: :bad_request
  rescue => e
    log_error(e)
    render json: error_response(e), status: :internal_server_error
  end

  def version
    render json: { version: VisualizeRuby::VERSION }
  end

  private

  def graph
    CreateGraph.call(
        path:           path,
        format:         format,
        ruby_code:      params["ruby_code"],
        render_options: params.permit!["render_options"].to_h
    )
  end


  def format
    params.fetch(:format, :svg).to_sym
  end

  def path
    tempfile if download_file
  end

  def media_type
    case format
    when :png
      "application/png"
    when :dot
      "text/plain"
    when :svg
      "image/svg+xml"
    end
  end

  def tempfile
    @tempfile ||= Tempfile.new("graph")
  end

  def log_error(e)
    Rails.logger.error e.class.name
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end

  def error_response(e)
    { exception: { message: e.message, type: e.class.name } }
  end

  def download_file
    !!params[:download_file]
  end
end
