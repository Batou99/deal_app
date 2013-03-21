module Importer
  class Loader
    def initialize(line_regexp,capture="(", subst = ";")
      @subst = subst
      @line_regexp = line_regexp
      @num_of_group_captures = line_regexp.source.split(capture).count-1
      raise "No group captures defined" if @num_of_group_captures <= 0
    end

    def parse_file(file, header=false)
      lines = IO.readlines(file)
      # Remove first line if is a header
      lines = lines[1..-1] if header
      lines.each { |line|  
        line.gsub!(@line_regexp,subst_line)
      }
      import(lines)
    end

    def import(lines)
      raise NotImplementedError
    end

    private
    def subst_line
      line = 1.upto(@num_of_group_captures).to_a.join("#{@subst}\\")
      #1..upto(@num_of_group_captures).each { |group_capture|  
        #line+="\\group_capture"
      #}
      "\\#{line}"
    end
  end

  class DailyPlanetLoader < Loader
    def initialize
      num = "([0-9]*)"
      nonum = "([^0-9]*)"
      date = "([0-9]{2}\/[0-9]{1,2}\/[0-9]{4})"
      line_regexp = /^#{nonum} +#{date} +#{date} +#{nonum} +#{num} +#{num}$/
      super(line_regexp,"+(")
    end

    def import(lines)
      lines.each { |line|  
        elems = line.split(";")

      }
    end
  end
end
