module CreateGraph
  def self.call(path: nil, format:, ruby_code:, render_options:)
    render_options = render_options ? render_options.permit(:unique_nodes).to_h : {}
    return unless ruby_code
    graphs, options = VisualizeRuby::Builder.new(ruby_code: ruby_code).build
    all_options = (options || {}).merge(render_options).symbolize_keys
    VisualizeRuby::Graphviz.new(
        graphs,
        all_options
    ).to_graph(path: path, format: format)
  end
end
