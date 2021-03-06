module Jekyll
  class ReplOnly < Liquid::Tag
    #### usage
    # `repl_only` id#editor

    def count_lines(s)
      ans = 0
      len = s.length
      i   = 0
      while i < len
        ans += 1 if s[i].match(/\n/)
        i   += 1
      end
      return ans
    end

    def initialize(tag_name, text, tokens)
      super
      @text   = text.split('#')
      @id     = @text[0]                ## : Liquid::Token
      @editor = @text[1...@text.length] ## : Array[Liquid::Token]
      @lines  = count_lines(@editor[0]) + 1
      @height = @lines * 21.33333396911621
    end

    def render(context)
      [
        '<div class="js-editor" data-identifier="',
        @id,
        '" style="width: auto; height:',
        @height,
        'px;">',
        @editor,
        '</div>',
        '<p><input class="js-console ',
        @id,
        '"><button class="js-go" data-identifier="',
        @id,
        '">EVAL</button> ',
        '<br /><code>></code> ',
        '<code class="js-results ',
        @id,
        '"></code></p>',
        '<p class="js-errors ',
        @id,
        '"></p>'
      ].join('')
    end
  end
end

Liquid::Template.register_tag('repl_only', Jekyll::ReplOnly)
