module BlobHelper
  def render_file(file)
    blob = Linguist::FileBlob.new(file.path)

    formatter = Rouge::Formatters::HTML.new
    formatter = Rouge::Formatters::HTMLTable.new(formatter)

    lexer = Rouge::Lexer.guess(filename: blob.name, source: blob.data).new

    formatter.format(lexer.lex(blob.data)).html_safe
  end
end
