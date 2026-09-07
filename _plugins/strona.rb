require "kramdown"

# Identyfikatory nagłówków zgodne z serwisem repozytorium: zachowują znaki
# diakrytyczne, więc odsyłacze wewnątrz dokumentów działają w obu miejscach.
module Kramdown
  module Converter
    class Base
      def basic_generate_id(str)
        gen_id = str.downcase
        gen_id.gsub!(/[^\p{Word}\- ]/, "")
        gen_id.tr!(" ", "-")
        gen_id
      end
    end
  end
end

# Tytuł strony pochodzi z pierwszego nagłówka pierwszego stopnia.
Jekyll::Hooks.register :site, :pre_render do |site|
  site.pages.each do |page|
    next unless page.data["title"].to_s.empty?

    naglowek = page.content[/^\#\s+(.+)$/, 1]
    page.data["title"] = naglowek.strip if naglowek
  end
end

# Listy kontrolne zapisane składnią zadań renderują się jako pola wyboru.
Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output.to_s.include?("<li>[")

  page.output = page.output
    .gsub("<li>[ ] ", %(<li class="zadanie"><input type="checkbox" disabled> ))
    .gsub("<li>[x] ", %(<li class="zadanie"><input type="checkbox" checked disabled> ))
end
