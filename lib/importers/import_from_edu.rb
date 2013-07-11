# encoding: utf-8

require 'open-uri'
require 'nokogiri'

class ImportFromEdu

  def initialize
    @site_url = 'http://www.edu.ru'
  end

  def import_from_url(path)
    page = Nokogiri::HTML(open(@site_url + path))
    page.css('table.tmain td.tdcont table')[1].css('td a').each do |show_url|
      import_organization(show_url.children.first.text.strip, show_url.attributes.first[1].value)
      #break
    end
    next_page_path = page.css('table.tmain div.pages1 b+a')
    import_from_url next_page_path.first.attributes.first[1].value if next_page_path.any?
  end

  def import_organization(title, path)
    data = {'Название' => title}
    page = Nokogiri::HTML(open(@site_url + path)).css('table.tmain td.tdcont')
    site = begin page.at('b:contains("Сайт") + a').children.text rescue '' end
    city = begin page.css('h1').first.text rescue 'не понятно' end
    kind = begin page.css('table')[2].css('td b').first.children.text.strip rescue 'не понятно' end
    address = begin page.css('table')[2].at('td b:contains("Адрес")').next_sibling.text.strip rescue '' end
    phone = begin page.css('table')[2].at('td b:contains("Телефон")').next_sibling.text.strip rescue '' end
    email = begin page.css('table')[2].at('td b:contains("Электронная почта") + a').children.text.strip rescue '' end
    p title
    p site
    p calculate_groups path.gsub("ds.1", "ds.20") #page.at('a:contains("Направления подготовки")').attributes['href'].value
  end

  def calculate_groups(path)
    begin
      page = Nokogiri::HTML(open(@site_url + path)).css('table.tmain td.tdcont table.t2')
      page.css('tr:contains("Специалист")').size*5 +
      page.css('tr:contains("Бакалавр")').size*4 +
      page.css('tr:contains("Магистр")').size*2
    rescue
      0
    end
  end
end
