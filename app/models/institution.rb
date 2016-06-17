class Institution < ActiveRecord::Base
  require 'csv'

  has_many :action_institutions
  has_many :action_pages, through: :action_institutions
  has_many :signatures

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.import(file, action_page)
    CSV.foreach(file.path, headers: true) do |row|
      params = row.to_hash
      action_page.institutions.find_or_create_by!(name: params['name'])
    end
  end
end
