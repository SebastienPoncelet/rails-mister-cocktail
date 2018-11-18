class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(unsafe_prop, user_search_string)
    self.where("#{unsafe_prop} ~* :re", re: "\\y#{Regexp.escape(user_search_string)}\\y")
    # e.g. Cocktail.search(:name, 'ace')
  end
end
