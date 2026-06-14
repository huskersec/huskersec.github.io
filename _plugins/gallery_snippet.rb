# frozen_string_literal: true

# gallery_snippet — include a line range from a file in the WinPrivEscLab
# gallery (checked out at build time into ./_gallery) as a fenced, highlighted
# code block.
#
# Usage in a post (Markdown):
#   {% gallery_snippet file="src/pool_overflow.c" lang="c" lines="42-58" %}
#   {% gallery_snippet file="src/pool_overflow.c" lang="c" %}          (whole file)
#
# Params:
#   file  - path within the gallery repo, relative to _gallery/ (required)
#   lang  - fence language for Rouge highlighting (required), e.g. c, nasm, csharp
#   lines - "START-END" 1-indexed inclusive (optional; omit for whole file).
#           Also accepts a single line "42" or open ranges "42-" / "-58".
#
# Build-time only: content comes from the ref pinned in the deploy workflow,
# so a writeup stays in sync with the exact lab version it documents.
#
# Fails the build loudly if the file or line range is invalid — better a red
# build than a silently-wrong snippet in an exploitation writeup.

module Jekyll
  class GallerySnippetTag < Liquid::Tag
    GALLERY_DIR = "_gallery"

    def initialize(tag_name, markup, tokens)
      super
      @markup = markup
    end

    def render(context)
      params = parse_params(@markup, context)
      file = params["file"]
      lang = params["lang"] || ""
      lines = params["lines"]

      raise "gallery_snippet: missing required 'file' param" if file.nil? || file.empty?

      site_source = context.registers[:site].source
      base = File.expand_path(GALLERY_DIR, site_source)
      full = File.expand_path(file, base)

      # path-traversal guard: resolved path must stay inside _gallery/
      unless full.start_with?(base + File::SEPARATOR)
        raise "gallery_snippet: '#{file}' resolves outside #{GALLERY_DIR}/"
      end
      unless File.file?(full)
        raise "gallery_snippet: file not found: #{GALLERY_DIR}/#{file} " \
              "(is the gallery checked out? is the path right?)"
      end

      all = File.read(full).split("\n", -1)
      # drop a single trailing empty element from a final newline
      all.pop if all.last == ""

      snippet =
        if lines.nil? || lines.empty?
          all
        else
          slice_range(all, lines, file)
        end

      body = snippet.join("\n")
      "```#{lang}\n#{body}\n```"
    end

    private

    def slice_range(all, spec, file)
      m = spec.match(/\A(\d*)-?(\d*)\z/)
      raise "gallery_snippet: bad lines spec '#{spec}' for #{file}" unless m

      has_dash = spec.include?("-")
      from = m[1].empty? ? 1 : m[1].to_i
      to   = m[2].empty? ? (has_dash ? all.size : from) : m[2].to_i

      if from < 1 || to < from || from > all.size
        raise "gallery_snippet: line range #{from}-#{to} out of bounds " \
              "(#{file} has #{all.size} lines)"
      end
      to = all.size if to > all.size
      all[(from - 1)...to]
    end

    def parse_params(markup, context)
      params = {}
      markup.scan(/(\w+)\s*=\s*"([^"]*)"/) { |k, v| params[k] = v }
      # allow variable interpolation in values (e.g. file="{{ page.foo }}")
      params.transform_values { |v| Liquid::Template.parse(v).render(context) }
    end
  end
end

Liquid::Template.register_tag("gallery_snippet", Jekyll::GallerySnippetTag)
