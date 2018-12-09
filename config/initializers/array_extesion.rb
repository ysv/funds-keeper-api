module ArrayExtension
  def deep_symbolize_keys
    map { |item| item.respond_to?(:deep_symbolize_keys) ? item.deep_symbolize_keys : item }
  end
end

Array.include ArrayExtension