module CreateGraph
  def self.call(path: nil, format:, ruby_code:, render_options:, graphs: nil)
    return unless ruby_code
    VisualizeRuby.new do |vb|
      vb.ruby_code     = ruby_code
      vb.output_path   = path
      vb.output_format = format
      vb.options(render_options.to_h || {})
    end
  end
end
