module CreateGraph
  def self.call(path: nil, format:, ruby_code:, render_options:)
    require "pry"; binding.pry
    render_options = render_options ? render_options : {}
    return unless ruby_code
    result = VisualizeRuby::Builder.new(ruby_code: ruby_code).build
    all_options = (result.options || {}).merge(render_options).symbolize_keys
    require "pry"; binding.pry
    if render_options.key?(:executed_lines)
      VisualizeRuby::HighlightTracer.new(
          builder: result,
          executed_lines: render_options.delete(:executed_lines)
      ).highlight!
    end
    VisualizeRuby::Graphviz.new(
        result,
        all_options
    ).to_graph(path: path, format: format)
  end
end
