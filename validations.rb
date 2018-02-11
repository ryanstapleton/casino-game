class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def validated? selection, valid_options
  validated = false
    if valid_options.include?(selection)
      validated = true
    else
      puts "That's not a valid option ..."
    end
  validated
end

def selections_validated? selections, valid_options
  validated = false  
  
  # If the user made a selection, if the selections are not more than allowed, and if they are not duplicated ...
  if !selections.empty? && (selections.length <= valid_options.length) && (selections.uniq.length == selections.length)
    # If the user selections are valid options
    if (valid_options & selections).empty? == false
      validated = true
    end
    # One last check for bad entries mixed with allowed entries
    selections.each do |entry|
      if valid_options.include?(entry) == false
        validated = false
        break
      end
    end
  end

  puts "Please enter valid options ..." if !validated
  validated  
end

def pressed_enter?
  validated = false
  system('stty -echo')
  loop do
    if gets.chomp.empty?
      validated = true
      break
    end
  end
  system('stty echo')
  validated
end
