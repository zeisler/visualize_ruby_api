require "visualize_ruby"
require File.join(Rails.root, "lib/create_graph")
require File.join(Rails.root, "lib/cache_graph")

class ShareController < ApplicationController
  def create
    key = CreateKey.call(graph_options)
    $redis.set(key, graph_options.to_json, nx: true)
    $redis.set("#{key}graph", CreateGraph.call(graph_options), nx: true, ex: CacheGraph.to_i)
    render json: { share_key: key }
  rescue => e
    render json: { exception: { message: e.message, type: e.class } }
  end

  def show
    hydrated_graph_options = JSON.parse($redis.get(params[:key]), symbolize_names: true)
    render json: {
        graph:     $redis.get("#{params[:key]}graph") || CreateGraph.call(hydrated_graph_options),
        share_key: params[:key],
        **hydrated_graph_options
    }
  rescue => e
    render json: { exception: { message: e.message, type: e.class } }
  end

  def graph_options(ruby_code = params["ruby_code"])
    {
        format:         :svg,
        ruby_code:      ruby_code,
        render_options: params["render_options"]
    }
  end
end
