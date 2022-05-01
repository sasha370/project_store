# frozen_string_literal: true

require 'nokogiri'

class YandexYmlGeneratorService
  # rubocop:disable Metrics/BlockLength, Metrics/MethodLength, Metrics/AbcSize
  def generate_fid
    @categories = Category.all
    @projects = Project.all.includes(:category)

    builder = Nokogiri::XML::Builder.new(encoding: 'utf-8') do |xml|
      xml.yml_catalog(date: Time.now.iso8601) do
        xml.shop do
          xml.name 'Diy-plans.ru'
          xml.company 'Diy-plans.ru'
          xml.url 'https://diy-plans.ru'
          xml.url 'budka52@bk.ru'
          xml.currencies do
            xml.currency(id: 'RUR', rate: '1')
          end
          xml.categories
          @categories.each do |category|
            xml.category(category.title, id: category.id)
          end
          xml.offers do
            @projects.each do |project|
              xml.offer(id: project.id, type: 'vendor.model') do
                xml.name "Чертеж: #{project.short_description}"
                xml.vendorCode project.vendor_code
                xml.url Rails.application.routes.url_helpers.project_url(project, host: 'https://diy-plans.ru')
                xml.price project.price
                xml.oldprice project.old_price
                xml.currencyId 'RUR'
                xml.count '100'
                xml.categoryId project.category.id
                xml.category project.category.title
                xml.picture Rails.application.routes.url_helpers.url_for(project.main_image.url)
                xml.description do
                  xml.cdata project.description
                end
                xml.country_of_origin 'Россия'
                xml.downloadable true
              end
            end
          end
        end
      end
    end

    xml_string = builder.to_xml
    File.write('./file.xml', xml_string)
  end
  # rubocop:enable Metrics/BlockLength, Metrics/MethodLength, Metrics/AbcSize
end
