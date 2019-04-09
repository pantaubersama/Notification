class WordstadiumApplicationRecord < ApplicationRecord
  self.abstract_class = true
  establish_connection WORDSTADIUM_DB
end
