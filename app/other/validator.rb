class Validator

  def Validator.input_empty?(value)
    return value.empty?() if(value.class == "".class)
    return !value 
  end

end
