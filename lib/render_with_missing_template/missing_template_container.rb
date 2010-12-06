module RenderWithMissingTemplate
  class MissingTemplateContainer < Exception
    attr_accessor :missing_template

    def initialize(e)
      self.missing_template = e
    end
    
    def reraise
      raise self.missing_template
    end
  end
end