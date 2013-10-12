# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  poster_url   :string(255)
#  origin_url   :string(255)
#  published_at :datetime
#  guid         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Movie < ActiveRecord::Base

  def poster_original_url
    self.poster_url.gsub("C198x288", "R678x0")
  end
end
