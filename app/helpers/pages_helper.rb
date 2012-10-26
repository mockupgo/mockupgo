module PagesHelper


  def self.guess_name_from_filename(filename)
    filename.split('.').first.tr('_', ' ')
  end

end
