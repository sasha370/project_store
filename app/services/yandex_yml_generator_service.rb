# frozen_string_literal: true

require 'nokogiri'

# https://yandex.ru/support/webmaster/feed/about.html
# https://yandex.ru/support/partnermarket/offers.html#offers
class YandexYmlGeneratorService
  def initialize
    @report_path = Rails.root.join('public/yml_report.xml')
  end

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
          xml.email 'budka52@bk.ru'
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

    File.write(@report_path, builder.to_xml)
  end
  # rubocop:enable Metrics/BlockLength, Metrics/MethodLength, Metrics/AbcSize
end
