class XmlDocument
  def initialize(indent_flag=false)
    @indent_flag = indent_flag
    @indent_level = 0
  end

  def method_missing(method_name, *args, &prc)
    kwargs = make_kwargs(args[0]) if args[0].is_a?(Hash)

    xml_indent = @indent_flag ? '  ' * @indent_level : ''
    xml_string = xml_indent + "<#{method_name}#{kwargs}"
    if block_given?
      xml_string += '>'
      xml_string += "\n" if @indent_flag
      @indent_level += 1
      xml_string += yield
      @indent_level -= 1
      xml_string += xml_indent + "</#{method_name}>"
    else
      xml_string += '/>'
    end
    xml_string += "\n" if @indent_flag
    xml_string
  end

  def make_kwargs(args)
    kwargs = []
    args.each do |label, value|
      kwargs << "#{label}='#{value}'"
    end
    kwargs = ' ' + kwargs.join(' ')
  end
end
