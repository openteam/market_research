# encoding: utf-8

require 'open-uri'
require 'nokogiri'

class ImportFromEdu

  def initialize
    @site_url = 'http://www.edu.ru'
  end

  def mine
    @mine ||= Mine.first
  end

  def import
    paths = [
      #'/abitur/act.4/index.php',
      '/abitur/act.17/sch.2/index.php'
    ]
    paths.each_with_index do |path, index|
      page = Nokogiri::HTML(open(@site_url + path))
      table = page.css('table.tmain td.tdcont')
      if table.at('h1:contains("Техникумы и Колледжи")')
        table = table.css('table')[1]
      else
        table = table.css('table')[2]
      end
      #table.css('td a').each do |city_path|
      table.css('td a')[74..79].each do |city_path, index|
        import_from_page city_path.attributes.first[1].value, 'ssuz' #index == 0 ? 'vuz' : 'ssuz'
        #break
      end
    end
  end

  def import_from_page(path, import_kind)
    page = Nokogiri::HTML(open(@site_url + path))
    region = page.css('table.tmain td.tdcont h1.cart').text.strip.gsub('Регион: ', '').squish
    page.css('table.tmain td.tdcont table')[1].css('td a').each do |show_url|
      import_organization(show_url.children.first.text.strip, region, show_url.attributes.first[1].value, import_kind)
      #break
    end
    next_page_path = page.css('table.tmain div.pages1 b+a')
    import_from_page next_page_path.first.attributes.first[1].value, import_kind if next_page_path.any?
  end

  def import_organization(title, region, path, import_kind)
    page = Nokogiri::HTML(open(@site_url + path)).css('table.tmain td.tdcont')
    site = begin page.at('b:contains("Сайт") + a').children.text rescue '' end
    city = begin page.css('h1').first.text rescue 'не понятно' end
    page = case import_kind
                   when 'vuz'
                     page.css('table')[2]
                   when 'ssuz'
                     page.css('table')[1]
                   end
    kind = begin page.css('td b').first.children.text.strip rescue 'не понятно' end
    address = begin page.at('td b:contains("Адрес")').next_sibling.text.strip rescue '' end
    phone = begin page.at('td b:contains("Телефон")').next_sibling.text.strip rescue '' end
    email = begin page.at('td b:contains("Электронная почта") + a').children.text.strip rescue '' end
    groups_count = case import_kind
                   when 'vuz'
                     calculate_vuz_groups path.gsub("ds.1", "ds.20")
                   when 'ssuz'
                     calculate_ssuz_groups path.gsub("ds.1", "ds.4")
                   end
    data = {
      "Название" => title,
      "Тип" => kind,
      "Регион" => region,
      "Город" => city,
      "Адрес" => address,
      "Телефон" => phone,
      "Email" => email,
      "Количество групп" => groups_count,
      "Сайт" => site }
      p region
    mine.items.create(:data => OpenStruct.new(data))
    #p title
    #p site
    #p city
    #p kind
    #p address
    #p phone
    #p email
    #p groups_count
    #p "-"*80
  end

  def calculate_vuz_groups(path)
    begin
      page = Nokogiri::HTML(open(@site_url + path)).css('table.tmain td.tdcont table.t2')
      page.css('tr:contains("Специалист")').size*5 +
      page.css('tr:contains("Бакалавр")').size*4 +
      page.css('tr:contains("Магистр")').size*2
    rescue
      0
    end
  end

  def calculate_ssuz_groups(path)
    begin
      page = Nokogiri::HTML(open(@site_url + path)).css('table.tmain td.tdcont table.t2')
      page.css('td:contains("Программы СПО")').size*2
    rescue
      0
    end
  end

  def set_state_for_region(region, state)
    Item.all.select {|i| i.data['Регион'].match(region)}.map {|i| i.data['Округ'] = state; i.save}
  end

  def regions_without_state
    Item.all.select {|i| i.data['Округ'].nil?}.map {|i| i.data['Регион']}.uniq
  end
end
