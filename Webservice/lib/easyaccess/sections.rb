module EasyAccess
  class Sections

    # Get the unic STIF code of the line
    def self.getTransportLineCode(code, destination)
      @line = Line.where("name=? AND destination LIKE ? OR origin LIKE ?",
                         code,"%#{destination}%", "%#{destination}%").first
      return @line.nil? ? nil : @line.stif
    end

    # Check if the section is accessible
    def self.isSectionAccessible?(transport)
      @info = transport["display_informations"]
      if (!@info.nil?)
        @lineNumber = getTransportLineCode(@info["code"], @info["direction"])
        # Everything except walking mode
        if (!transport["stop_date_times"].nil?)
          # Get the stop where the person got off the bus, train...
          @lastStop = transport["stop_date_times"].last
          if (EasyAccess::Stops::isStopAccessible?(@lastStop, @lineNumber) == false)
            return false
          end
        end
      end
      return true
    end

  end
end