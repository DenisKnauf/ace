# encoding: utf-8

require "sass"
require "ace/filters"

module Ace
  class SassFilter < Filter
    def call(item, content)
      if item.output_path && item.output_path.match(/\.s[ac]ss$/)
        syntax = item.output_path.end_with?(".scss") ? :scss : :sass
        item.output_path.sub!(/\.s[ac]ss$/, '')
        output = nil
        begin
          engine = Sass::Engine.new(content, syntax: syntax, filename: item.original_path)
          output = engine.render
        rescue Exception => e
          warn "~~ SassFilter exception: #{e}"
          abort
        end
        #p caller: Kernel.caller
        return output
      else
        return content
      end
    end
  end
end
