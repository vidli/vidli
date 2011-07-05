class ConfigurationManagerHash < Hash
  def method_missing(method, *args)
    if ((actual_key = method.to_s) && self.keys.include?(actual_key)) || ((actual_key = method.to_s.to_sym) && self.keys.include?(actual_key))
      result = self[actual_key]
      if result.class == Hash
        result = self[actual_key] = ConfigurationManagerHash.new_from_hash(result)
      end
      return result
    else
      super
    end
  end
  
  def self.new_from_hash(hash)
    hash.is_a?(Hash) ? ConfigurationManagerHash.new.merge(hash) : {}
  end
end